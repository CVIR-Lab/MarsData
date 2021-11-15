function a = BinarizedSegDisplay(Img, FC,rr,cc)
Bw_FC = im2bw(FC,graythresh(FC));
%     Bw_FC = im2bw(FC,1.2*mean(FC(:)));
%     Bw_FC = imbinarize(FC,'adaptive','ForegroundPolarity','bright','Sensitivity',0.3);
%     figure,imshow(Bw_FC)
detect = zeros(rr,cc,3);
detect1 = detect(:,:,1);
detect2 = detect(:,:,2);
detect3 = detect(:,:,3);
Mask = Bw_FC ==1;
detect1(Mask) = 0;
detect2(Mask) = 255;
detect3(Mask) = 0;
detecImg = im2uint8(cat(3,detect1,detect2,detect3));
thea = 0.3;
a = Img*(1-thea)+thea*detecImg;
% figure,imshow(a)