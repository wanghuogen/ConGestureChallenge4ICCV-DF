clear,clc
parent_dir = 'Image4LSTM/valid/';
Norm4S_dir1 = [parent_dir,'valid_depth_fullbody/'];
if ~exist(Norm4S_dir1)
    mkdir(Norm4S_dir1);
end
Norm4S_dir2 = [parent_dir,'valid_depth_DF/'];
if ~exist(Norm4S_dir2)
    mkdir(Norm4S_dir2);
end


fpn = fopen ('video/valid_seg_depth.txt');           %打开文档clear,clc

ff_train1 = fopen('Image4LSTM/valid/valid_depth_fullbody.txt','w');
ff_train2 = fopen('Image4LSTM/valid/valid_depth_DF.txt','w');

%ff_val = fopen('val.txt','w');
while feof(fpn) ~= 1                %用于判断文件指针p在其所指的文件中的位置，如果到文件末，函数返回1，否则返回0  
      file = fgetl(fpn);           %获取文档第一行  
      obj_origin = VideoReader(['video/',file(1:17),'.avi']);
      
      disp(['Exract Frame of ',file(11:17)]);
      numFrames_origin = obj_origin.NumberOfFrames;
      wd = obj_origin.Width;
      ht = obj_origin.Height;
      
      
      outImageNamef = fullfile(Norm4S_dir1,file(11:17));
      outImageNamer = fullfile(Norm4S_dir2,file(11:17));
      if ~exist(fullfile(Norm4S_dir1,file(11:17)))
          mkdir(fullfile(Norm4S_dir1,file(11:17)));
      end
      if ~exist(fullfile(Norm4S_dir2,file(11:17)))
          mkdir(fullfile(Norm4S_dir2,file(11:17)));
      end
      for t = 1:numFrames_origin
          depthmap_origin = read(obj_origin, t);
          imageNamef = fullfile(outImageNamef,sprintf('%s.jpg',num2str(t,'%03d')));
          imwrite(depthmap_origin,imageNamef);
          if t>1
              imageNamer = fullfile(outImageNamer,sprintf('%s.jpg',num2str(t-1,'%03d')));
              imwrite(abs(read(obj_origin, t)-read(obj_origin, t-1)),imageNamer);
          end
      end

        fprintf(ff_train1,[outImageNamef,' ',num2str(numFrames_origin),' 0\n']);
        fprintf(ff_train2,[outImageNamer,' ',num2str(numFrames_origin-1),' 0\n']);
end
fclose(ff_train1);
fclose(ff_train2);
fclose(fpn);