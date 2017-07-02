function D = scalebilateral(A,scaleFactor,edgeDepth,sigma_d,sigma_r);
                             
%   Usage: D = scalebilateral(A,SCALEFACTOR,EDGEDEPTH,SIGMA_D,SIGMA_R);
%   SCALEBILATERAL scales images while preserving edges using bilateral
%   filtering and isotropic high pass filtering (Laplacian)
%       A: input image
%       SCALEFACTOR: Order of up-scale
%       EDGEDEPTH: Measure of level of edge detection (0 to 1, from none to
%                  very aggressive)
%       SIGMA_D: Std. deviation of domain filter in pixels.
%                (Sub-pixel values quantized to even fractions, i.e. in
%                steps of 0.2)
%       SIGMA_R: Std. deviation of range filter. Value between 0 and 1.
%               (Relative to colorspace range which is normalized to 0 - 1)
%       D: output image
%
%   Author: Harold Nyikal & Haarith Devarajan
%   Date: 03/20/2006

A = im2double(A);   % Normalize image range to 0 - 1
[y,x] = size(A);  % Establish input image size

% Set up the edge-enhancing high pass filter kernel
eFilt = [-1 2 -1]'*edgeDepth;   % Edge Detection Filter (Laplacian)
eFilt(2) = eFilt(2)+1;  % To overlay (enhance) detected edges on image

% Create edge detection transformation matrix  using the kernel above
padding = length(eFilt);
T = zeros(y+padding,x);
for k = 1:x
    T(1:length(eFilt),k) = eFilt;
    T(:,k) = circshift(T(:,k),(k-1));
end
idx = floor(padding/2)+1:floor(padding/2)+y;
T = T(idx,:);   %Edge enhancing transformation matrix

% Apply bilateral filter to remove noise while preserving edges on original
% image. (More efficient to do before rather than after scaling)
B = mybilateral(A,sigma_d,sigma_r);

% Enhance the edges using the high-pass filter created above to
% pre-compensate for the smoothing effect of interpolating filter
C = T*B*T';

% Set up the scaling/interpolating filter kernel. We use bilinear
% interpolation
filtlength = scaleFactor*2-1;     % Length of interpolating filter
sFilt = triang(filtlength);    % Bartlett window for bilinear interpolation
sFilt = scaleFactor*sFilt/sum(sFilt);   % Intensity compensation

% Create a scaling tranformation matrix using the kernel above
padding = length(sFilt);
T = zeros(scaleFactor*y+padding,x);
for k = 1:x
    T(1:length(sFilt),k) = sFilt;
    T(:,k) = circshift(T(:,k),(k-1)*scaleFactor);
end
idx = floor(padding/2)+1:floor(padding/2)+scaleFactor*y;
T = T(idx,:); % Scaling transformation matrix

% Perform scaling
D = T*C*T';

