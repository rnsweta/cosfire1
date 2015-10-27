% function Main_applyCosfire_Application
% Keypoint detection by a COSFIRE filter
%
% VERSION 01/07/2012
% CREATED BY: George Azzopardi and Nicolai Petkov, University of Groningen,
%             Johann Bernoulli Institute for Mathematics and Computer Science, Intelligent Systems
%
% If you use this script please cite the following paper:
%   George Azzopardi and Nicolai Petkov, "Trainable COSFIRE filters for
%   keypoint detection and pattern recognition", IEEE Transactions on Pattern
%   Analysis and Machine Intelligence, vol. 35(2), pp. 490-503, 2013.
%
close all;
clear all;
%load reshape_config_max_response.mat
path('COSFIRE/',path);
path('Gabor/',path);
mkdir('Results');
new_max_response = zeros(1,30);
c=0;

% First, compile the c-function called maxblurring_written_in_c.c
d = dir('./COSFIRE/maxblurring.*');
if isempty(d)
    mex COSFIRE/written_in_c_maxblurring.c -outdir . -output maxblurring;
end

dir_im=('/Users/vnpandey/Pictures/NarrativeClip/testing_lap/')
dir_im_temp=[dir_im,'*jpg']
d = dir(dir_im_temp);

%%%%testing%%%%%
for i = [1,2,3,7,8,15,17,19,21,22]%:20%:numel(d)
    
    testingImage = imread([dir_im d(i).name]);
    testingImage = imresize(testingImage,0.3);
    testingImage = preprocessImage(testingImage);
    
    
    for variable= 1:30
      c = c+1
        image_num=floor((variable-1)/3)+1
        coord_num=floor(variable-(image_num-1)*3)
        load (['./OUTPUT_FOLDER/operator_' sprintf('%02d',image_num),'_',sprintf('%03d',coord_num), '.mat'])
        output = applyCOSFIRE(testingImage,operator);
        [max_val,posn]=max(output(:));
        max_response(i,variable) = max_val;
        
        [rind,cind]=ind2sub(size(output),posn)
        imshow(testingImage); hold on;
        imwrite(plot(cind,rind,'r.','MarkerSize',20),'prototype2.jpg');
        
        marked_test = ['OUTPUT_FOLDER/marked_test_',sprintf('%03d',i), '_',sprintf('%02d',image_num),'_',sprintf('%03d',coord_num),'.jpg']
        temp=['test\_marked\_',sprintf('%03d',i), '\_',sprintf('%02d',image_num),'\_',sprintf('%03d',coord_num),'.jpg']
        title(temp)
        saveas(gcf,marked_test,'jpg');
        hold off;
    end  
end
  load config_max_response.mat;
  z=reshape(config_max_response',1,30);
 test_res= new_max_response>=z
 test_result_thrs =new_max_response>=0.7*z







