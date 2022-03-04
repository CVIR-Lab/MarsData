## Official implementation for KLRD and KPRD methods (code and data)
------------------------
This is the official implementation of the codes and data that produced the results in titled

"*A Kernel-based Multi-featured Rock Modeling and Detection Framework for a Mars Rover*" submitted to IEEE TNNLS Special Issue on:
Deep Learning for Earth and Planetary Geosciences.

We will soon released the whole codes and data after the paper is availabe.

## MarsData  — a Martian rock dataset for segmentation.
----------------------------------
We refined and built the first labeled dataset for rocks on Mars, **MarsData**. Images are collected from an unlabeled [Mars image dataset](https://dominikschmidt.xyz/mars32k/). The intention of **MarsData** is to provied a standard rock detection benchmark with pixel-level mask for researchers who are interseting on deep learning methods for planetray sciences and robotics. Note: All mars images are courtesy of NASA/JPL-Caltech. You can read the full use policy [here](https://www.jpl.nasa.gov/jpl-image-use-policy).

## Data
------------------------
Currently, **MarsData** currently includes two sub-datasets, **Rock-A**, **Rock-B** with total 405 labeled rock images and more than 20,000 rocks. **Rock-A** is a simple rock dataset with a few rocks in one scene. **Rock-B** is a challenging dataset with more abundant rocks in one image. We used them to evaluate proposed algorithms and others in our paper. In order to produce sufficient data to well support the deep training, we combined them together and split all images randomly into train and test sets. After data augmentation, the **train** and **test** sets can be used to train and evaluate the deep learning-based rock segmentation methods, as mentioned in our paper. Of course, you can do the augmentation work by yourself with more methods in order to produce more data.

Sementtion samples
<div align="center">
<img src=https://user-images.githubusercontent.com/20831138/156727546-c2019bb6-5167-47e8-b431-c4f9cda7a2f3.jpg width="40%" />
<img src=https://user-images.githubusercontent.com/20831138/156726734-0d1a9f63-0ec5-401c-9433-04877ab82416.png width="40%" />
<img src=https://user-images.githubusercontent.com/20831138/156730443-6622b3bc-5f37-4352-9be6-724fbd291514.jpg width="40%" />
<img src=https://user-images.githubusercontent.com/20831138/156730587-4f7dd0a5-269a-4cee-8881-ae81ad4ddd5d.png width="40%" />
</div>


|**MarsData** | **Rock-A** | **Rock-B** | **train**(after aug) | **test**(after aug)|
|:-|:-:|:-:|:-:|:-:|
|Number of images     | 201  |204     | 25092 | 5820 |
|Average rock number  | 3.15 | 15.89  | -    | 9.91|
|max rock number      | 12   | 77     | -    | 55  | 
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
3. for evaluating, run *evaluate.m*



## Further plan
We will continue to improve **MarsData**, planing to build a more complex and challenging sub-dataset(tentatively named **Rock-C**), and striving to reach more than 2000 labeled images. Anyone who wants join us to further optimize and improve **MardData** is strongly welcome. Besides, we are applying for the data of China's First Mars Exploration Mission("TianWen-1"), looking for passionate researchers to collaborate with us! Contact: alexcapshow@gmail.com or meibaoyao@jlu.edu.cn. 

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
