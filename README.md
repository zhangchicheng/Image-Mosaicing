# Image-Mosaicing
Image mosaicing is the process of combining multiple photographic images with overlapping fields of view to produce a segmented panorama. In this repo, a image mosaicing pipeline was presented and the experimental results demonstrate that framework has good performance on accuracy and speed.
# Usage
Refer to example
# Details
In the first phase of this approach, two RGB images were converted to grayscale due to the data reduction and simplicity. Next, Harris corner detector was applied to both images. Given two set of corners from the images, we compute normalized cross correlation (NCC) of image patches centered at each cornerand choose potential corner matches by finding pair of corners (one from each image) such that they have the highest NCC value. Since these correspondences are likely to have many errors, we should use RANSAC to robustly estimate the homography from the noisy correspondences. Finally, using thehomography, we warp one image onto the other one, blending overlapping pixels together to create a single image.
# Result
![alt text](https://github.com/zhangchicheng/Image-Mosaicing/blob/master/images/eg1/combined.jpg "combined")
