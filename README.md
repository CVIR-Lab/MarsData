
# MarsData-V2 
This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution </a>.<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/80x15.png" /></a>

We release MarsData-V2, a rock segmentation dataset of real Martian scenes for the training of deep networks, extended from our previously published [MarsData](https://github.com/CVIR-Lab/MarsData) [1]. The raw unlabeled RGB images of MarsData-V2 are from [here](https://dominikschmidt.xyz/mars32k/), which were collected by a Mastcam camera of the Curiosity rover on Mars between August 2012 and November 2018. After sorting out images with an opportune shooting distance, labeling Mars rocks with fine-grained boundaries, and performing data augmentation referring to [2], we obtained 8390 labeled images with a resolution of 512 × 512, and divided them into 5040 images for training, 1680 for validation and 1670 for testing. 

We show 8 samples, including 4 samples in MarsData and 4 new ones in MarsData-V2, where the Martian rocks with varying shapes, sizes, textures and colors are labeled with fine-grained annotations.

4 samples in MarsData:
<div align=center>
  <img src=https://user-images.githubusercontent.com/20831138/156727546-c2019bb6-5167-47e8-b431-c4f9cda7a2f3.jpg width="20%" />
  <img src=https://user-images.githubusercontent.com/20831138/156726734-0d1a9f63-0ec5-401c-9433-04877ab82416.png width="20%" />
  <img src=https://user-images.githubusercontent.com/20831138/156730443-6622b3bc-5f37-4352-9be6-724fbd291514.jpg width="20%" />
  <img src=https://user-images.githubusercontent.com/20831138/156730587-4f7dd0a5-269a-4cee-8881-ae81ad4ddd5d.png width="20%" />
  <img src=https://user-images.githubusercontent.com/73680591/156786345-0469cf84-a4a7-40e4-9400-c728a1cfb093.jpg width="20%" />
  <img src=https://user-images.githubusercontent.com/73680591/156786442-24184580-7077-4ff2-81f6-faff1c57b099.png width="20%" />
  <img src=https://user-images.githubusercontent.com/73680591/156786542-1885a7ab-9824-4fb7-8ed9-60190ca8912d.jpg width="20%" />
  <img src=https://user-images.githubusercontent.com/73680591/156786597-279a1d5e-f3ba-40e1-98cc-eadf6fc4b6ac.png width="20%" />
</div>

4 new samples in MarsData-V2:
<div align=center>
  <img src=https://github.com/CVIR-Lab/MarsData/blob/MarsData-V2/samples/img_332.png width="20%">
  <img src=https://github.com/CVIR-Lab/MarsData/blob/MarsData-V2/samples/mask_332.png width="20%">
  <img src=https://github.com/CVIR-Lab/MarsData/blob/MarsData-V2/samples/img_336.png width="20%">
  <img src=https://github.com/CVIR-Lab/MarsData/blob/MarsData-V2/samples/mask_336.png width="20%">
  <img src=https://github.com/CVIR-Lab/MarsData/blob/MarsData-V2/samples/img_538.png width="20%">
  <img src=https://github.com/CVIR-Lab/MarsData/blob/MarsData-V2/samples/mask_538.png width="20%">
  <img src=https://github.com/CVIR-Lab/MarsData/blob/MarsData-V2/samples/img_1101.png width="20%">
  <img src=https://github.com/CVIR-Lab/MarsData/blob/MarsData-V2/samples/mask_1101.png width="20%">
</div>

Limited by the file size, we temporarily release 100 samples in the train, validation and test set of **MarsData-V2** on github, respectively. The whole data can be found by the following way:

[1]: [IEEE DataPort](https://ieee-dataport.org/documents/marsdata-v2-rock-segmentation-dataset-real-martian-scenes);
<!--
[2]: [Google Drive](https://drive.google.com/drive/folders/1O3euKLzZkqTxFYIzvgd2cEZ-m1o_-6V6?usp=sharing);

[3]: [Baidu Cloud](https://pan.baidu.com/s/1cm17L6BvHaXdrrRYVh78bQ) with passcode:  **rock**

[4]: [Our Lab filestation](http://gofile.me/6V28a/STvoP4tRm)
-->
If you use **MarsDataV2** for your research, please cite our papers and data：

```
@article{liu2023rockformer,
  title={RockFormer: A U-Shaped Transformer Network for Martian Rock Segmentation},
  author={Liu, Haiqiang and Yao, Meibao and Xiao, Xueming and Xiong, Yonggang},
  journal={IEEE Transactions on Geoscience and Remote Sensing},
  volume={61},
  pages={1--16},
  year={2023},
  publisher={IEEE}
}

@article{xiao2021kernel,
  title={A Kernel-Based Multi-Featured Rock Modeling and Detection Framework for a Mars Rover},
  author={Xiao, Xueming and Yao, Meibao and Liu, Haiqiang and Wang, Jiake and Zhang, Lei and Fu, Yuegang},
  journal={IEEE Transactions on Neural Networks and Learning Systems},
  year={2021},
  doi={10.1109/TNNLS.2021.3131206},
  publisher={IEEE}
}

@data{34a5-jq14-22,
doi = {10.21227/34a5-jq14},
url = {https://dx.doi.org/10.21227/34a5-jq14},
author = {Xiao, Xueming and Yao, Meibao and Liu, Haiqiang},
publisher = {IEEE Dataport},
title = {MarsData-V2, a rock segmentation dataset of real Martian scenes},
year = {2022}
}
```

## References
[1] Xiao X, Yao M, Liu H, et al. A Kernel-Based Multi-Featured Rock Modeling and Detection Framework for a Mars Rover[J]. IEEE Transactions on Neural Networks and Learning Systems, 2021.

[2] Furlán F, Rubio E, Sossa H, et al. Rock detection in a Mars-like environment using a CNN[C]//Mexican Conference on Pattern Recognition. Springer, Cham, 2019: 149-158.


