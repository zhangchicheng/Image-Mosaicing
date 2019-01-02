a = imread('DanaHallWay1\DSC_0281.JPG');
b = imread('DanaHallWay1\DSC_0282.JPG');
ima = rgb2gray(a);
imb = rgb2gray(b);

% get corner location 
loc1 = detectHarris(ima, 1.5, 0.01);
loc2 = detectHarris(imb, 1.5, 0.01);

% get image patch centered at each corner
[des1, res_loc1] = getFeatureDescriptor(ima, loc1, 1.5);
[des2, res_loc2] = getFeatureDescriptor(imb, loc2, 1.5);

% compute normalized cross correlation and choose largest correlation
cor = calcNormxcorrelation(des1, des2);
[ord_cor, index] = sort(cor, 2, 'descend');

coor1 = res_loc1;
coor2 = res_loc2(index(:,1), :);

% estimate homography matrix
[H, inliners] = runRANSAC(coor1, coor2, 6000, 1);

% drawLines(a, coor1, b, coor2);
% drawLines(a, coor1(inliners,:), b, coor2(inliners,:));

[I, mask] = warpImages(H, a, b, true(size(b,1),size(b,2)));
imshow(I)
imwrite(I,'mosaicking.jpg');
