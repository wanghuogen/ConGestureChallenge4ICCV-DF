function [hist, Z] = getDepthHistogram(depthmap,wd,ht, dpmin, dpmax, dpinc);
%getDepthHistogram(depthmap, wd,ht, dpmin, dpmax, dpinc) creates the
%   histogram of the depth map
%   dpmin, dpmax, dpinc should be speciefied in meters

%   assumes the depthmap holds the depth values in millimeters

nelem = uint16((dpmax-dpmin)/dpinc)+1;
idpmin = uint16(dpmin*1000);
idpmax = uint16(dpmax*1000);
idpinc = uint16(dpinc*1000);

hist = zeros(nelem);
index = find(depthmap < idpmin);
depthmap(index) = idpmin;
index = find(depthmap > idpmax);
depthmap(index) = idpmax;

for y=1:ht
    for x=1:wd
    index = uint16((depthmap(y,x)-idpmin)/idpinc)+1;
    hist(index) = hist(index)+1;
end
Z = dpmin:dpinc:dpmax;
end

