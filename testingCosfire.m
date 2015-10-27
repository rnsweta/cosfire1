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
% close all;
 clear all;
%load reshape_config_max_response.mat
path('COSFIRE/',path);
path('Gabor/',path);
%mkdir('Results');
%new_max_response = zeros(1,30);
load ./OUTPUT_FOLDER/mat_files/max_response.mat;
temp_training_response=[max_response(1,1:3), max_response(2,4:6), max_response(3,7:9), max_response(4,10:12), max_response(5,13:15)]

%skip = [operator_03_003,operator_05_001, operator_05_002 ];
% The bad filters are (image,filter) (1,2) (3,3) (4,1) (4,2) (4,3)
% bad_operator_num=[2, 9, 10, 11, 12] 
    
% First, compile the c-function called maxblurring_written_in_c.c
d = dir('./COSFIRE/maxblurring.*');
if isempty(d)
    mex COSFIRE/written_in_c_maxblurring.c -outdir . -output maxblurring;
end

dir_im=('/Users/vnpandey/Pictures/NarrativeClip/testing_lap/')
dir_im_temp=[dir_im,'*jpg']
d = dir(dir_im_temp);

%%%%testing%%%%%
for i = 21% [1,2,3,7,8,15,17,19,21,22]%:20%:numel(d)
    
    testingImage = imread([dir_im d(i).name]);
    testingImage = imresize(testingImage,0.3);
    testingImage = preprocessImage(testingImage);
    
    for variable= 1:15
        image_num=floor((variable-1)/3)+1
        coord_num=floor(variable-(image_num-1)*3)
      
        load (['./OUTPUT_FOLDER/operator_' sprintf('%02d',image_num),'_',sprintf('%03d',coord_num), '.mat'])
        
        output = applyCOSFIRE(testingImage,operator);
        [max_val,posn]=max(output(:));
        test_max_response(i,variable) = max_val;
%        if test_max_response(i,variable) >= 0.7*temp_training_response(1,variable)
 if test_max_response(i,variable) >= 0.7*temp_training_response(1,variable)
    
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
    
end
save('test_max_response.mat','test_max_response');

%   
%   temp_training_response=[max_response(1,1:3), max_response(2,4:6), max_response(3,7:8), max_response(4,10:12), max_response(5,15)]
% 
%   test_max_response(1,:) >= 0.66*temp_training_response
%   

