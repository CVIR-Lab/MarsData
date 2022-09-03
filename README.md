# MarsData-V2
We release MarsData-V2, a rock segmentation dataset of real Martian scenes for the training of deep networks, extended from our previously published [MarsData](https://github.com/CVIR-Lab/MarsData)[1]. The raw unlabeled RGB images of MarsData-V2 are from [here](https://dominikschmidt.xyz/mars32k/), which were collected by a Mastcam camera of the Curiosity rover on Mars between August 2012 and November 2018. After sorting out images with an opportune shooting distance, labeling Mars rocks with fine-grained boundaries, and performing data augmentation referring to [2], we obtained 8390 labeled images with a resolution of 512 × 512, and divided them into 5040 images for training, 1680 for validation and 1670 for testing. 

We show two samples in MarsData-V2, where the Martian rocks with varying shapes, sizes, textures and colors are labeled with fine-grained annotations

<div align=center>
  <img src=https://user-images.githubusercontent.com/20831138/156727546-c2019bb6-5167-47e8-b431-c4f9cda7a2f3.jpg width="20%" />
  <img src=https://user-images.githubusercontent.com/20831138/156726734-0d1a9f63-0ec5-401c-9433-04877ab82416.png width="20%" />
  <img src=https://user-images.githubusercontent.com/20831138/156730443-6622b3bc-5f37-4352-9be6-724fbd291514.jpg width="20%" />
  <img src=https://user-images.githubusercontent.com/20831138/156730587-4f7dd0a5-269a-4cee-8881-ae81ad4ddd5d.png width="20%" />
  <img src=https://user-images.githubusercontent.com/73680591/156786345-0469cf84-a4a7-40e4-9400-c728a1cfb093.jpg width="20%" />
  <img src=https://user-images.githubusercontent.com/73680591/156786442-24184580-7077-4ff2-81f6-faff1c57b099.png width="20%" />
  <img src=https://user-images.githubusercontent.com/73680591/156786542-1885a7ab-9824-4fb7-8ed9-60190ca8912d.jpg width="20%" />
  <img src=https://user-images.githubusercontent.com/73680591/156786597-279a1d5e-f3ba-40e1-98cc-eadf6fc4b6ac.png width="20%" />
<img src=https://github.com/CVIR-Lab/MarsData/blob/MarsData-V2/samples/img_332.png width="20%">
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
