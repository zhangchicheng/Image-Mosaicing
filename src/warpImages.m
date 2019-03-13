function [I, mask] = warpImages( H, src, dst, dst_mask )
% Warp a image to another image 
%   Input:
%       H - homography matrix
%       src, dst - unwarped image and warped image; format: rgb
%       dst_mask - valid region index
%   Output:
%       I - image after mosaicking
%       mask - valid region of I

    [h1, w1, ~] = size(src);
    [h2, w2, ~] = size(dst);

    [r,c] = meshgrid(1:h1, 1:w1);
    S = ones(3, h1*w1);
    S(1,:) = reshape(r, 1, h1*w1);
    S(2,:) = reshape(c, 1, h1*w1);

    ref = H * S;
    top = fix(min([1, min(ref(1,:)./ref(3,:))]));
    bottom = fix(max([h2, max(ref(1,:)./ref(3,:))]));
    left = fix(min([1, min(ref(2,:)./ref(3,:))]));
    right = fix(max([w2, max(ref(2,:)./ref(3,:))]));

    Height = bottom-top+1;
    Width = right-left+1;
    
    if (Height>5000 || Width > 5000)
        error('Error. \nWarpImage is too large!')
    end
    
    nDstTop = 1-top+1;
    nDstLeft = 1-left+1;

    I = zeros(Height, Width, 3, class(dst));
    I(nDstTop:nDstTop+h2-1, nDstLeft:nDstLeft+w2-1, :) = dst;

    mask = false(Height, Width);
    mask(nDstTop:nDstTop+h2-1, nDstLeft:nDstLeft+w2-1) = mask(nDstTop:nDstTop+h2-1, nDstLeft:nDstLeft+w2-1) | dst_mask;

    for i = 1:Height
        for j = 1:Width
            coor = [i-nDstTop+1; j-nDstLeft+1; 1];
            ref_coor = H \ coor;
            r = fix(ref_coor(1)/ref_coor(3));
            c = fix(ref_coor(2)/ref_coor(3));
            if (r >=1 && r <= h1 && c >= 1 && c <= w1)
                if (mask(i,j))
                    sp = src(r,c,:);
                    dp = dst(i-nDstTop+1,j-nDstLeft+1,:);
                    if (sum(sp)>sum(dp))
                        I(i,j,:) = sp;
                    else
                        I(i,j,:) = dp;
                    end
                else
                    I(i,j,:) = src(r,c,:);
                    mask(i,j) = true;
                end
            else
                continue;
            end
        end
    end

end

