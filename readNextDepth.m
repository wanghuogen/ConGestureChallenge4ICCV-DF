function [depthMap,flag] = readNextDepth( fid, wd, ht )
%readNextDepth(fid,wd,ht) reads next frame of depth map

%   Detailed explanation goes here
flag = 0;
[depthMap, count] = fread(fid,[wd, ht],'uint16');
if (count < wd*ht)
    flag = -1;
    depathMap=[];
    return;
end
depthMap = depthMap';
end

