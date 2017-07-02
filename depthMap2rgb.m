function rgbImage = depthMap2rgb(map,wd,ht)
%DEPTHMAP2RGB(map,wd,ht) converts a depth map into a RGB color image
%   It is used for display depath map

if (nargin < 3)
    message = 'Not sufficient number of input args!';
    display(message);
end
[clrlut sz] = depthMapColorTable();
maxvalue = max(max(map));
minvalue = min(min(map));
rgbImage = uint8(zeros(ht,wd,3));
normalized = (map-minvalue)/(maxvalue-minvalue);
index = min(int16(normalized *511.0+1),512);

for y=1:ht
    for x = 1:wd
        rgbImage(y,x,1) = clrlut(index(y,x),1);
        rgbImage(y,x,2) = clrlut(index(y,x),2);
        rgbImage(y,x,3) = clrlut(index(y,x),3);
    end
end
end

