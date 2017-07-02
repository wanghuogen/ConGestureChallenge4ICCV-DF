
clear all;
clc;
%% set path
dataPath = 'DATA/ConGD_phase1/'
dataPathTrain=[dataPath,'train/'];
list_file_path = 'DATA/con_list/train.txt';

segData=importdata(list_file_path);
[name_list] = textread(list_file_path, '%s %*[^\n]');

DMM_dirf = ['DFDI4caffe/train/RgbDMM/'];
if ~exist(DMM_dirf)
    mkdir(DMM_dirf);
end

baseFName = 0;

foutid1 = fopen('DFDI4caffe/train/train_rgb.txt','w');
foutid2 = fopen('DFDI4caffe/train/val_rgb.txt','w');

for i = 1:length(name_list)
    tic;
    TotalSegNoChar=sprintf('%d',length(name_list));
    iChar=sprintf('%d',i);
    disp(['Processing DMMs of ', name_list{i},':->',iChar,'/',TotalSegNoChar]);
    %RGB_name = [dataPathTrain name_list{i} '.M.avi'];
    %RGBobj = VideoReader(RGB_name);
    D_name = [dataPathTrain name_list{i} '.M.avi'];
    Dobj=VideoReader(D_name);
    %RGBnumFrames = RGBobj.NumberOfFrames;% Frame No.
    NumFrames = Dobj.NumberOfFrames;% Frame No.
    wd = Dobj.Width;
    ht = Dobj.Height;
    TempSegFile = regexp(segData{i}, ' ', 'split');
    segNo=size(TempSegFile,2);
    for j=2:segNo
        tempNode=regexp(TempSegFile{j}, '[,:]', 'split');
        tempStartFrame=str2num(tempNode{1});
        tempEndFrame=str2num(tempNode{2});
        tempClass=str2num(tempNode{3});
        
        baseFName = baseFName + 1;
        classDir = strcat('DFDI4caffe/train/RgbDMM/',sprintf('%03s',num2str(tempClass-1)));
        if ~exist(classDir)
            mkdir(classDir);
        end
        outImageName = fullfile(DMM_dirf,sprintf('%03s',num2str(tempClass-1)),sprintf('%05s.jpg',num2str(baseFName)));
        pre_frame = zeros(wd,ht);
        DMM = zeros(ht,wd);
        for k = tempStartFrame : tempEndFrame % Read frame
            if k == tempStartFrame
                depthmap = read(Dobj,k);
                depthmap = rgb2gray(depthmap);
                pre_frame = im2double(depthmap);
            end
            if k > tempStartFrame
                depthmap = read(Dobj,k);
                depthmap = rgb2gray(depthmap);
                current_frame = im2double(depthmap);
                DMM = DMM + abs(current_frame - pre_frame);
            end
            
        end
        DMM = medfilt2(DMM);
        DMM = medfilt2(DMM);
        DMM = medfilt2(DMM);
        DMM = medfilt2(DMM);
        rgbdepth= depthMap2rgb(DMM,wd,ht);
%         imshow(rgbdepth);
        imwrite(rgbdepth,outImageName,'jpg');
        fprintf(foutid1,'%03s/%s %03s\n',num2str(tempClass-1),sprintf('%05s.jpg',num2str(baseFName)),num2str(tempClass-1));
        if mod(baseFName,3)==0
           fprintf(foutid2,'%03s/%s %03s\n',num2str(tempClass-1),sprintf('%05s.jpg',num2str(baseFName)),num2str(tempClass-1));
        end
    end
    
end
fclose(foutid1);
fclose(foutid2);