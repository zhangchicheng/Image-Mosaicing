function loc = detectHarris( I, sigma, quality )
% Compute the coordinates of Harris corners
%   Input:
%       I - input image
%       sigma - standard deviation of Gaussian smoothing kernel
%       quality - determine the threshold of non-max suppression
%   Output:
%       loc - location of harris point, size = n*2

	% gradient image
	Ix = filter2([-1 0 1], I, 'same');
	Iy = filter2([-1; 0; 1], I, 'same');

	Ix2 = imgaussfilt(Ix.^2, sigma);
	Iy2 = imgaussfilt(Iy.^2, sigma);
	Ixy = imgaussfilt(Ix.*Iy, sigma);

	k = 0.04;
	R = (Ix2.*Iy2-Ixy.^2) - k*(Ix2 + Iy2).^2;

	% find local maximum
    maxR=max(R(:));
    bw = imregionalmax(R, 8);
    threshold = quality * maxR;
    bw(R < threshold) = 0;
    
    % set boundary to zero
    bw([1,end],:) = 0;
    bw(:,[1,end]) = 0;   
    
 	[row, col] = find(bw);
	loc = [row, col];

end

