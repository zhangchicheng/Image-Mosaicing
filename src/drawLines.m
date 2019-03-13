function [] = drawLines( A, loc1, B, loc2 )
% Draw lines to match keypoints between images 
%   Input:
%       A, B - input images
%       loc1, loc2 - locations of keypoints
%   Output:
%       None

    x1 = loc1(:,2);
    y1 = loc1(:,1);
    x2 = loc2(:,2);
    y2 = loc2(:,1);
    dist = size(A, 2);
    imshowpair(A, B, 'montage');
    hold on
    for k = 1:size(x1,1)
        plot(x1(k), y1(k), 'b*');
        plot(x2(k)+dist, y2(k), 'b*');
        plot([x1(k), x2(k)+dist], [y1(k), y2(k)]);
    end

end

