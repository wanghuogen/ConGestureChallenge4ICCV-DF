clear,clc
parent_dir = 'Image4LSTM/train/';
Norm4S_dir1 = [parent_dir,'train_depth_fullbody/'];
if ~exist(Norm4S_dir1)
    mkdir(Norm4S_dir1);
end
Norm4S_dir2 = [parent_dir,'train_depth_DF/'];
if ~exist(Norm4S_dir2)
    mkdir(Norm4S_dir2);
end


fpn = fopen ('video/train_depth.txt');
ff_train1 = fopen('Image4LSTM/train/train_depth_fullbody.txt','w');
ff_val1 = fopen('Image4LSTM/train/val_depth_fullbody.txt','w');
ff_train2 = fopen('Image4LSTM/train/train_depth_DF.txt','w');
ff_val2 = fopen('Image4LSTM/train/val_depth_DF.txt','w');

while feof(fpn) ~= 1                  
      file = fgetl(fpn);          
      obj_origin = VideoReader(['video/',file(1:17),'.avi']);
      disp(['Exract Frame of ',file(11:17)]);
      
      numFrames_origin = obj_origin.NumberOfFrames;
      wd = obj_origin.Width;
      ht = obj_origin.Height;
      
      
      outImageNamef = fullfile(Norm4S_dir1,file(7:9),file(11:17));
      outImageNamer = fullfile(Norm4S_dir2,file(7:9),file(11:17));
      if ~exist(fullfile(Norm4S_dir1,file(7:9),file(11:17)))
          mkdir(fullfile(Norm4S_dir1,file(7:9),file(11:17)));
      end
      if ~exist(fullfile(Norm4S_dir2,file(7:9),file(11:17)))
          mkdir(fullfile(Norm4S_dir2,file(7:9),file(11:17)));
      end
      for t = 1:numFrames_origin
          depthmap_origin = read(obj_origin, t);
          imageNamef = fullfile(outImageNamef,sprintf('%s.jpg',num2str(t,'%03d')));
          imwrite(depthmap_origin,imageNamef)
          if t>1
              imageNamer = fullfile(outImageNamer,sprintf('%s.jpg',num2str(t,'%03d')));
              imwrite(abs(read(obj_origin, t)-read(obj_origin, t-1)),imageNamer)
          end  
      end
        fprintf(ff_train1,[outImageNamef,' ',num2str(numFrames_origin),' ',file(7:9),'\n']);
        fprintf(ff_train2,[outImageNamer,' ',num2str(numFrames_origin-1),' ',file(7:9),'\n']);
        if mod(str2num(file(11:15)),3)==0
            fprintf(ff_val1,[outImageNamef,' ',num2str(numFrames_origin),' ',file(7:9),'\n']);
            fprintf(ff_val2,[outImageNamef,' ',num2str(numFrames_origin-1),' ',file(7:9),'\n']);
        end
      
end
fclose(ff_train1);
fclose(ff_val1);
fclose(ff_train2);
fclose(ff_val2);
fclose(fpn);
