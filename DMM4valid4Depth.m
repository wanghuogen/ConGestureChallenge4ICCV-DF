clear all;
clc;
%% set path
dataPath = 'DATA/ConGD_phase1/'
dataPathTrain=[dataPath 'valid/'];
list_file_path = 'valid_segmented.list';

segData=importdata(list_file_path);
[name_list] = textread(list_file_path, '%s %*[^\n]');

DMM_dir = ['DFDI4caffe/valid/vlid_DMM4Depth/'];
if ~exist(DMM_dir)
    mkdir(DMM_dir);
end
baseFName = 0;

for i = 1:length(name_list)
    tic;
    TotalSegNoChar=sprintf('%d',length(name_list));
    iChar=sprintf('%d',i);
    disp(['Processing DMMs of ', name_list{i},':->',iChar,'/',TotalSegNoChar]);
    %RGB_name = [dataPathTrain name_list{i} '.K.avi'];
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
        
        outImageName = fullfile(DMM_dir,sprintf('%05s.M.jpg',num2str(baseFName)));
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
        %imshow(rgbdepth);
        imwrite(rgbdepth,outImageName,'jpg');
        
    end
    
end