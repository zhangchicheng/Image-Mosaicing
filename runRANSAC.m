function [ H, inliers ] = runRANSAC( src, dst, iter, threshold )
% Estimate homography using RANSAC fitting
%   Input:
%       src, dst - coordinates of key-points; size = num*2
%       iter - number of RANSAC iteration
%       threshold - determine inliers
%   Output:
%       H -  the homography matrix
%       inliers - good points

    if ~isequal(size(src), size(dst))
        error('Error. \nMatrix dimensions of src and dst must agree')
    end

    outlier = 0;
    num = size(src,1);
    
    expand_src = [src, ones(num,1)];

    for i = 1:iter
        idx = randperm(num, 4);
        src_p = src(idx,:);
        dst_p = dst(idx,:);
        h = findHomography(src_p, dst_p);
        if (isequal(h, ones(3,3)))
            continue;
        else
            ref = h*expand_src';
            ref(1,:) = ref(1,:)./ref(3,:);
            ref(2,:) = ref(2,:)./ref(3,:);
            err = (ref(1,:)-(dst(:,1))').^2 + (ref(2,:)-(dst(:,2))').^2;
            n = nnz(err<threshold);
            if (n >= num*0.95)
                H = h;
                inliers = find(err<threshold);
                break;
            elseif (n > outlier)
                outlier = n;
                H = h;
                inliers = find(err<threshold);
            end
        end
    end
        
end

