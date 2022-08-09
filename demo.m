% this is the demo code for our paper titled:
%"A Kernel-based Multi-featured Rock Modeling and Detection Framework for a Mars Rover"
% submitted to IEEE TNNLS Special Issue on Deep Learning for Earth and Planetary Geosciences
% for isssues, please contact alexcapshow@gmail.com or meibaoyao@jlu.edu.cn.
% this mainly used to validate the efficiency of proposed method on
% MardData and MarsData2.0.

close all;
clear all;
clc;
%% Set Path
addpath(genpath(pwd));
RootDir = pwd;
% Put your images into ./Data/
ImgPath = fullfile(RootDir, 'Data');

% Save segmentation results of KLRD, KPRD and RKLRR algorithms. 
KPRD_BW_Path = fullfile(RootDir, 'Results','KPRD\');
if ~exist(KPRD_BW_Path, 'file')
    mkdir(KPRD_BW_Path);
end

KLRD_BW_Path = fullfile(RootDir,'Results', 'KLRD\');
if ~exist(KLRD_BW_Path, 'file')
    mkdir(KLRD_BW_Path);
end

RKLRR_BW_Path = fullfile(RootDir,'Results', 'RKLRR\');
if ~exist(RKLRR_BW_Path, 'file')
    mkdir(RKLRR_BW_Path);
end


%% Parameter settings. you can fine-tune them for your data or model.
Para.spn = 300; % number of superpixels, for image with size 1M or more, a larger Para.spn is better.
Para.comp = 10;
Para.Sig = 0.35;
Para.alpha =0.5; 
Para.beta =0.75;

%% Load image file
DiImg = dir(fullfile(ImgPath,'*.png'));
NumImg = length(DiImg);
parfor InxImg = 1 : NumImg
    filename =DiImg(InxImg).name;
    Img = imread(fullfile(ImgPath,DiImg(InxImg).name));
    [rr,cc,z] = size(Img);
    if z == 3
        GrayImg = rgb2gray(Img);
    else
        GrayImg = Img;
        Img = cat(3,GrayImg,GrayImg,GrayImg);
    end
    %% Superpixel Generation
    [idxImg, adjcMatrix, pixelList] = SuperpixelGeneration(Img, Para.spn,Para.comp);
    spn = max(idxImg(:));  % real number of superpixels
    %% Feature extration
    Texture = statexture(GrayImg,pixelList);                      % low-level local textures
    MeanInt = normalization(Texture);                             % the mean intensity of each subregion
    MeanPos = GetNormedMeanPos(pixelList, rr, cc);                % the location of each subregion
    MeanGra = LBPfeature(GrayImg,idxImg,pixelList);               % the average gradient of each subregion
    GaboFea = GaborFeature(GrayImg,pixelList);
    FeaVector = [MeanInt,MeanGra,GaboFea];
    
    %% KPRD : Kernel PCA-based rock detecion model
    % set kernel function
    Ker = Kernel('type', 'gauss', 'width',0.55);
    % parameter setting
    KerPara = struct('application', 'dr', 'dim', 100, 'kernel', Ker);
    % build a KPCA object
    kpca = KernelPCA(KerPara);
    % get the projection map of kernel space
    [Fea_map, KK, time_KPCA(InxImg),KC]= kpca.train(FeaVector);
    [KPRD_RC_map, Ri]= CalFeaContrast((Fea_map),MeanPos,pixelList,rr,cc);
    FF_map =mat2gray(Fea_map);
    [KPRD_BWcut,KPRD_cut] = BinarizedSegDisplay(Img, KPRD_RC_map,rr,cc);
    imwrite(KPRD_BWcut, [KPRD_BW_Path,strcat(filename(1:end-4),'_','KPRD'),'.png']); % save segmentation results of KPRD
    
    %% KLRD : Kernel LRR-based rock detection model
    % Get the background seeds
    BackInd = find(Ri==min(Ri(:)));
    % Calculate the first and second adjacent matrix of superpixels by SMD [H. Peng et al., TPAMI'2017]
    FstSndAdjMat = GetFstSndAdjMat(idxImg, spn);
    % Link the adjacent superpixels with backd seeds
    FstSndAdjMat(BackInd, BackInd) =1;
    FstSndAdjMat_lowTri_Back = tril(FstSndAdjMat, -1);
    [tmpRow, tmpCol] = find(FstSndAdjMat_lowTri_Back>0);
    edge = [tmpRow, tmpCol];
    % Compute the graph-based kernel distance
    KpcaFeaDistM = GetDistanceMatrix(FF_map);
    posDistM = GetDistanceMatrix(MeanPos);       % the distance of intensity between two subregions
    spaSigma = 1;                                %sigma for spatial weight
    PosWeight = Dist2WeightMatrix(posDistM, spaSigma);
    KRC = KpcaFeaDistM.* PosWeight;
    KpcaFeaDistM = mat2gray(KRC);
    WeightedAjdcMatrix = KpcaFeaDistM(FstSndAdjMat_lowTri_Back>0);
    KernelDist = graphallshortestpaths(FstSndAdjMat_lowTri_Back, 'directed', false, 'Weights', WeightedAjdcMatrix);
    % Computate the affinity matrix
    WeightOnEdge = ComputeWeight(KernelDist, FstSndAdjMat_lowTri_Back, Para.Sig);
    WeightOnEdge = exp((-1/0.35)*WeightOnEdge);
    W = sparse([edge(:,1);edge(:,2)], [edge(:,2);edge(:,1)], [WeightOnEdge; WeightOnEdge],spn, spn);
    DCol = full(sum(W,2));
    D = spdiags(DCol,0,speye(spn));
    L = D - W;
    % for solving Z, P, H
    [Z, P, E, time_cost_ZPE(InxImg),t] = UpdateZHP(KK, L, Para.alpha, Para.beta);
    
    %% RKLRR for for solving Z, P, H
    [Z_RKLRR, P_RKLRR,time_cost_RKLRR(InxImg)] = RKLRR(Para.alpha,KC); 
    fprintf('ADM time cost %.4f s\n', toc)

    %% Calculate optiaml region-wise dissimilarity KLRD
    KLRD_Stemp = mapminmax(sum(mat2gray(KC-KC*Z-Z'*KC+Z'*KC*Z),1),0,1);
    [KLRD_Rc_Map, ~] = CreateContrastImage(KLRD_Stemp,pixelList, rr, cc);
    [KLRD_Rc_BWcut,KLRD_Rc_cut] = BinarizedSegDisplay(Img, KLRD_Rc_Map,rr,cc);
    imwrite(KLRD_Rc_BWcut,[KLRD_BW_Path,strcat(filename(1:end-4),'_','KLRD'),'.png']); % save segmentation results of KLRD
    fprintf('Pricessing: %s\n', num2str(InxImg));

    %% Calculate optiaml region-wise dissimilarity RKLRR
    RKLRR_Stemp = mapminmax(sum(mat2gray(KC-KC*Z_RKLRR-Z_RKLRR'*KC+Z_RKLRR'*KC*Z_RKLRR),1),0,1);
    [RKLRR_Rc_Map, ~] = CreateContrastImage(RKLRR_Stemp,pixelList, rr, cc);
    [RKLRR_Rc_BWcut,RKLRR_Rc_cut] = BinarizedSegDisplay(Img, RKLRR_Rc_Map,rr,cc);
    imwrite(RKLRR_Rc_BWcut,[RKLRR_BW_Path,strcat(filename(1:end-4),'_','RKLRR'),'.png']); % save segmentation results of RKLRR
    fprintf('Pricessing: %s\n', num2str(InxImg));
end
%% average running time 
avetime_cost_KLRD = mean(time_cost_ZPE);
avetime_cost_RKLRR= mean(time_cost_RKLRR);
avetime_KPCA = mean(time_KPCA);