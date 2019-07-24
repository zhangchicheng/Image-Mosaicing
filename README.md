# Image-Mosaicing
Image mosaicing is the process of combining multiple photographic images with overlapping fields of view to produce a segmented panorama. In this repo, a image mosaicing pipeline was presented and the experimental results demonstrate that framework has good performance on accuracy and speed.
# Usage
Refer to [example](https://github.com/zhangchicheng/Image-Mosaicing/blob/master/example.m)
# Details
* [Detect Harris Corners](https://github.com/zhangchicheng/Image-Mosaicing/blob/master/src/detectHarris.m)

  In the first phase of this approach, two RGB images were converted to grayscale due to the data reduction and simplicity. Then, Harris corner detector was applied to both images.
  
  <img src=https://github.com/zhangchicheng/Image-Mosaicing/blob/master/images/eg1/harriscorner1.jpg width="250">
  <img src=https://github.com/zhangchicheng/Image-Mosaicing/blob/master/images/eg1/harriscorner2.jpg width="250">

* [Compute Normalized Cross Correlation](https://github.com/zhangchicheng/Image-Mosaicing/blob/master/src/calcNormxcorrelation.m)

  Given two set of corners from the images, we compute normalized cross correlation (NCC) of image patches centered at each cornerand choose potential corner matches by finding pair of corners (one from each image) such that they have the highest NCC value.
  
  <img src=https://github.com/zhangchicheng/Image-Mosaicing/blob/master/images/eg1/badline.jpg width="500">
  
* [Apply RANSAC](https://github.com/zhangchicheng/Image-Mosaicing/blob/master/src/runRANSAC.m)

  Since these correspondences are likely to have many errors, we should use RANSAC to robustly estimate the homography from the noisy correspondences.
  
  <img src=https://github.com/zhangchicheng/Image-Mosaicing/blob/master/images/eg1/goodline.jpg width="500">
  
* [Estimate the homography](https://github.com/zhangchicheng/Image-Mosaicing/blob/master/src/findHomography.m)

  Finally, using thehomography, we warp one image onto the other one, blending overlapping pixels together to create a single image.

  <img src=https://github.com/zhangchicheng/Image-Mosaicing/blob/master/images/eg1/combined.jpg width="500">
