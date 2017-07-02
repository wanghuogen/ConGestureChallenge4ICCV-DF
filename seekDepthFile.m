function flag= seekDepthFile(depthfid,frameno)
%seekRGBFile(fid, frameno) seeks to the position of the 'frameno'
%   frameno - >=1

wd = 640;
ht = 480;
flag = fseek(depthfid,wd*ht*2*(frameno-1),'bof');
% +4*(frameno-1)
end