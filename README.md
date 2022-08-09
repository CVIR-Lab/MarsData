## Official implementation for KLRD and KPRD methods (code and data)
------------------------
This is the official implementation of the codes and data that produced the results in titled

"*A Kernel-based Multi-featured Rock Modeling and Detection Framework for a Mars Rover*" submitted to IEEE TNNLS Special Issue on:
Deep Learning for Earth and Planetary Geosciences.

## MarsData  — a Martian rock dataset for segmentation.
----------------------------------
We refined and built the first labeled dataset for rocks on Mars, **MarsData**. Images are collected from an unlabeled [Mars image dataset](https://dominikschmidt.xyz/mars32k/). The intention of **MarsData** is to provied a standard rock detection benchmark with pixel-level mask for researchers who are interseting on deep learning methods for planetray sciences and robotics. Note: All mars images are courtesy of NASA/JPL-Caltech. You can read the full use policy [here](https://www.jpl.nasa.gov/jpl-image-use-policy).

## Data
------------------------
Currently, **MarsData** currently includes two sub-datasets, **Rock-A**, **Rock-B** with total 405 labeled rock images and more than 20,000 rocks. **Rock-A** is a simple rock dataset with a few rocks in one scene. **Rock-B** is a challenging dataset with more abundant rocks in one image. We used them to evaluate proposed algorithms and others in our paper. In order to produce sufficient data to well support the deep training, we combined them together and split all images randomly into **Train** and **Test** sets. After data augmentation(mainly crop and rotate), the **Train** and **Test** sets contain 25,092 and 5,820 images respectively, and can be used to train and evaluate learning-based rock segmentation methods. Of course, you can do augmentation work by yourself with more methods to produce more data.

Segmentation samples:
<div align="center">
<img src=https://user-images.githubusercontent.com/20831138/156727546-c2019bb6-5167-47e8-b431-c4f9cda7a2f3.jpg width="20%" />
<img src=https://user-images.githubusercontent.com/20831138/156726734-0d1a9f63-0ec5-401c-9433-04877ab82416.png width="20%" />
<img src=https://user-images.githubusercontent.com/20831138/156730443-6622b3bc-5f37-4352-9be6-724fbd291514.jpg width="20%" />
<img src=https://user-images.githubusercontent.com/20831138/156730587-4f7dd0a5-269a-4cee-8881-ae81ad4ddd5d.png width="20%" />
<img src=https://user-images.githubusercontent.com/73680591/156786345-0469cf84-a4a7-40e4-9400-c728a1cfb093.jpg width="20%" />
<img src=https://user-images.githubusercontent.com/73680591/156786442-24184580-7077-4ff2-81f6-faff1c57b099.png width="20%" />
<img src=https://user-images.githubusercontent.com/73680591/156786542-1885a7ab-9824-4fb7-8ed9-60190ca8912d.jpg width="20%" />
<img src=https://user-images.githubusercontent.com/73680591/156786597-279a1d5e-f3ba-40e1-98cc-eadf6fc4b6ac.png width="20%" />
</div>


|**MarsData** | **Rock-A** | **Rock-B** | **train**(after aug) | **test**(after aug)|
|:-|:-:|:-:|:-:|:-:|
|Number of images     | 201  |204     | 25092 | 5820 |
|Average rock number  | 3.15 | 15.89  | 3.8    | 5.08 |
|max rock number      | 12   | 77     | 77    | 55  | 
|min rock number      | 1    | 1      | 0    |  0  | 

## Codes
---------------------
### Main Dependencies:

1. Matlab R2018b and C++

### Contents
1. **Exfeatures**  
This folder includes all the functions that extract gray-scale features for each superpixel region.

2. **Dependencies**  
This folder includes the core functions of the proposed KPCA-based Rock Detection method(KPRD), KLRR-based Rock Detection method(KLRD) and the RKLRR method. In addition, it also includes codes for superpixel generation in folder of *SLIC*, as well as some dependent functions used in our algorithms.  

3. **Evaluation**  
This folder includes all the source codes of the evaluating metrics used in our paper.

### Get started  
1. clone the respository to your PC
2. for testing KLRD, KPRD and RKLRR, please run *demo.m*, all the detection results will be saved in the folder of **Results**



## Further plan
We will continue to improve **MarsData**, planing to build a more complex and challenging reall mars dataset(tentatively named **MarsData2.0**), and striving to reach more than 10,000 labeled images. Anyone who wants join us to further optimize and improve **MardData** is strongly welcome. Besides, we are studying on the data of China's First Mars Exploration Mission("TianWen-1"), looking for passionate researchers to collaborate with us! Contact: alexcapshow@gmail.com or meibaoyao@jlu.edu.cn. 

If you find **MarsData** is helpful for your research, please cite our paper：

```
@article{xiao2021kernel,
  title={A Kernel-Based Multi-Featured Rock Modeling and Detection Framework for a Mars Rover},
  author={Xiao, Xueming and Yao, Meibao and Liu, Haiqiang and Wang, Jiake and Zhang, Lei and Fu, Yuegang},
  journal={IEEE Transactions on Neural Networks and Learning Systems},
  year={2021},
  doi={10.1109/TNNLS.2021.3131206},
  publisher={IEEE}
}
```
