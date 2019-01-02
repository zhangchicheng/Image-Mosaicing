function [des, res_loc] = getFeatureDescriptor( I, loc, sigma )
% Extract feature descriptor
%   Input:
%       I - input grayscale image
%       loc - location of keypoint
%       sigma - standard deviation of Gaussian smoothing kernel
%   Output:
%       des - array of descriptor;
%           size = m*n; m is number of feature. n is dimension
%       res_loc - location after removing points near boundary

    blurred_I = imgaussfilt(I, sigma);
    [height, width] = size(blurred_I);
    
    % remove points near boundary
    res_loc = loc(loc(:,1)>2 & loc(:,1)<height-1 ...
          & loc(:,2)>2 & loc(:,2)<width-1, :);
    num = size(res_loc,1);
    des = zeros(num, 25);
    
    for i = 1:num
        xmin = res_loc(i,2)-2;
        ymin = res_loc(i,1)-2;
        patch = imcrop(blurred_I, [xmin ymin 4 4]);
        patch = (patch - mean2(patch)) ./ std2(patch);
        des(i,:) = patch(:);
    end

end

