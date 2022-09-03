# MarsData-V2
We release MarsData-V2, a rock segmentation dataset of real Martian scenes for the training of deep networks, extended from our previously published [MarsData](https://github.com/CVIR-Lab/MarsData)[1]. The raw unlabeled RGB images of MarsData-V2 are from [here](https://dominikschmidt.xyz/mars32k/), which were collected by a Mastcam camera of the Curiosity rover on Mars between August 2012 and November 2018. After sorting out images with an opportune shooting distance, labeling Mars rocks with fine-grained boundaries, and performing data augmentation referring to [2], we obtained 8390 labeled images with a resolution of 512 × 512, and divided them into 5040 images for training, 1680 for validation and 1670 for testing. 

We show two samples in MarsData-V2, where the Martian rocks with varying shapes, sizes, textures and colors are labeled with fine-grained annotations

<div align=center>
<img src="https://github.com/CVIR-Lab/MarsData/blob/MarsData-V2/samples/img_332.png" width="20%">
<img src="https://github.com/CVIR-Lab/MarsData/blob/MarsData-V2/samples/mask_332.png" width="20%">
<img src="https://github.com/CVIR-Lab/MarsData/blob/MarsData-V2/samples/img_336.png" width="20%">
<img src="https://github.com/CVIR-Lab/MarsData/blob/MarsData-V2/samples/mask_336.png" width="20%">
<img src="https://github.com/CVIR-Lab/MarsData/blob/MarsData-V2/samples/img_538.png" width="20%">
<img src="https://github.com/CVIR-Lab/MarsData/blob/MarsData-V2/samples/mask_538.png" width="20%">
<img src="https://github.com/CVIR-Lab/MarsData/blob/MarsData-V2/samples/img_1101.png" width="20%">
<img src="https://github.com/CVIR-Lab/MarsData/blob/MarsData-V2/samples/mask_1101.png" width="20%">
</div>


## References
[1] Xiao X, Yao M, Liu H, et al. A Kernel-Based Multi-Featured Rock Modeling and Detection Framework for a Mars Rover[J]. IEEE Transactions on Neural Networks and Learning Systems, 2021.

[2] Furlán F, Rubio E, Sossa H, et al. Rock detection in a Mars-like environment using a CNN[C]//Mexican Conference on Pattern Recognition. Springer, Cham, 2019: 149-158.
