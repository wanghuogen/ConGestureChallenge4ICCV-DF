clear,clc
addpath('liblinear/matlab');
parent_dir = 'DFDI4caffe/train/';   %Please change your parent_dir to your own folder
Norm4S_dir1 = [parent_dir,'DFDIf/'];
if ~exist(Norm4S_dir1)
    mkdir(Norm4S_dir1);
end
Norm4S_dir2 = [parent_dir,'DFDIr/'];
if ~exist(Norm4S_dir2)
    mkdir(Norm4S_dir2);
end
fpn = fopen('video/train_rgb.txt');   %Please change this folder to your own folder

ftrain = fopen('DFDI4caffe/train/train_rgb_DFDI.txt','w');  %Genarate the training list for caffe
fval = fopen('DFDI4caffe/train/val_rgb_DFDI.txt','w');   %Generate the validation list for caffe

while feof(fpn) ~= 1               
      file = fgetl(fpn);             
      obj_origin = VideoReader(['video/',file(1:17),'.avi']);
      disp(['Processing DFDIs of ',file(11:17)]);
      numFrames_origin = obj_origin.NumberOfFrames;
      wd = obj_origin.Width;
      ht = obj_origin.Height;      
      depth_final = zeros(ht,wd,3,numFrames_origin-1);      

      for t = 2:numFrames_origin
          depthmap_origin = read(obj_origin, t)-read(obj_origin,t-1);          
          depth_final(:,:,:,t-1) = depthmap_origin;
      end      

      outImageNamef = fullfile(Norm4S_dir1,file(7:9),sprintf('%s.jpg',file(11:17)));
      outImageNamer = fullfile(Norm4S_dir2,file(7:9),sprintf('%s.jpg',file(11:17)));
      
      
      if ~exist(fullfile(Norm4S_dir1,file(7:9)))
          mkdir(fullfile(Norm4S_dir1,file(7:9)));
      end
      if ~exist(fullfile(Norm4S_dir2,file(7:9)))
          mkdir(fullfile(Norm4S_dir2,file(7:9)));
      end
     
      [zWF,zWR] = GetDynamicImages4(uint8(depth_final/max(max(max(max(depth_final))))*255));%uint8(DMM2Frame/max(max(max(max(DMM2Frame))))*255)

      imwrite(zWF(:,:,:,1),outImageNamef,'jpg');
      imwrite(zWR(:,:,:,1),outImageNamer,'jpg');
      
      fprintf(ftrain,'%s %s\n',fullfile(file(7:9),sprintf('%s.jpg',file(11:17))),file(7:9));
      if mod(str2num(file(11:15)),3) == 0
          fprintf(fval,'%s %s\n',fullfile(file(7:9),sprintf('%s.jpg',file(11:17))),file(7:9));
      end
      
end
fclose(fpn);
fclose(ftrain);
fclose(fval);