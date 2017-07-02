clear,clc
addpath('liblinear/matlab');
parent_dir = 'DFDI4caffe/test/';
Norm4S_dir1 = [parent_dir,'test_DFDIf_depth/'];
if ~exist(Norm4S_dir1)
    mkdir(Norm4S_dir1);
end
Norm4S_dir2 = [parent_dir,'test_DFDIr_depth/'];
if ~exist(Norm4S_dir2)
    mkdir(Norm4S_dir2);
end

fpn = fopen ('video/test_seg_depth.txt');           %打开文档clear,clc

while feof(fpn) ~= 1                %用于判断文件指针p在其所指的文件中的位置，如果到文件末，函数返回1，否则返回0  
      file = fgetl(fpn);           %获取文档第一行  
      obj_origin = VideoReader(['video/',file(1:16),'.avi']);
      disp(['Processing DIs of ',file(10:16)]);
      numFrames_origin = obj_origin.NumberOfFrames;
      wd = obj_origin.Width;
      ht = obj_origin.Height;
      
      depth_final = zeros(ht,wd,3,numFrames_origin-1);
      
      for t = 2:numFrames_origin
          depthmap_origin = read(obj_origin, t)-read(obj_origin,t-1);          
          depth_final(:,:,:,t-1) = depthmap_origin;
      end
      
      
      outImageNamef = fullfile(Norm4S_dir1,sprintf('%s.jpg',file(10:16)));
      outImageNamer = fullfile(Norm4S_dir2,sprintf('%s.jpg',file(10:16)));
      
      

      [zWF,zWR] = GetDynamicImages4(uint8(depth_final/max(max(max(max(depth_final))))*255));
      imwrite(zWF(:,:,:,1),outImageNamef,'jpg');
      imwrite(zWR(:,:,:,1),outImageNamer,'jpg');
      
end
fclose(fpn);