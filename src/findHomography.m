function H = findHomography( src, dst )
% Finds a perspective transformation between two planes.
%   Input:
%       src, dst - Coordinates of the points in the original plane,
%                  a matrix of the size 4*3
%   Output:
%       H - the homography matrix

    if ~isequal(size(src), size(dst))
        error('Error. \nMatrix dimensions of src and dst must agree')
    end

    src_r = src(:,1);
    src_c = src(:,2);
    dst_r = dst(:,1);
    dst_c = dst(:,2);
    
    P = zeros(8,8);
    P(1:2:end, 1:3) = [src_r, src_c, ones(4,1)];
    P(2:2:end, 4:6) = [src_r, src_c, ones(4,1)];
    P(1:2:end, 7:8) = [-src_r.*dst_r, -src_c.*dst_r];
    P(2:2:end, 7:8) = [-src_r.*dst_c, -src_c.*dst_c];
    
    D = [dst_r, dst_c];
    D = reshape(D', 8, 1);
    
    % avoid singular matrix
    if (rcond(P) < 1e-12 )
        H = ones(3,3);
    else
        h = P\D;
        H = [h(1),h(2),h(3); h(4), h(5), h(6); h(7), h(8), 1];
    end

end

