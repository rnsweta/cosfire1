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
% A COSFIRE filter is automatically configured by a prototype pattern and
% can then be used to detect the same and similar patterns in given images. The configuration
% comprises selecting given channels of a bank of orientation-selective filters
% and determining certain blur and shift parameters. While here we use Gabor
% filters, they are not intrinsic to the method and any
% other orientation-selective filters can be used. The area of support of the resulting
% COSFIRE filter is adaptive as it is composed of the support of a number of
% orientation-selective filters whose geometrical arrangement around a point of
% interest is learned from a single prototype pattern. A COSFIRE filter response
% is computed as the weighted geometric mean of the blurred and shifted responses
% of the selected Gabor filters.
close all
clear
clc
load reshape_config_max_response.mat
path('COSFIRE/',path);
path('Gabor/',path);
mkdir('Results');
new_max_response = zeros(1,15);

% First, compile the c-function called maxblurring_written_in_c.c
d = dir('./COSFIRE/maxblurring.*');
if isempty(d)
    mex COSFIRE/written_in_c_maxblurring.c -outdir . -output maxblurring;
end

% d= dir('/Users/vnpandey/Pictures/NarrativeClip/2015/04/23/*jpg');
% dir_im=('./narrative_pics/');



dir_im=('/Users/vnpandey/Pictures/NarrativeClip/testing_lap/')
dir_im_temp=[dir_im,'*jpg']
d = dir(dir_im_temp);
counter = 0;



%%%%testing%%%%%
for i = 1%:5 %:numel(d)
    
    testingImage = imread([dir_im d(i).name]);
    testingImage = imresize(testingImage,0.3);
    testingImage = preprocessImage(testingImage);
    
    for variable= 1%:15
        
        load (['./OUTPUT_FOLDER/operator_' num2str(variable) '.mat'])
        
        % Apply the COSFIRE to the input image
        %disp(['Applying Cosfire ' num2str(variable) ' to image ' dir_im d(i).name])
        
        
        % apply the cosfire filter and find the maximum response.
        output = applyCOSFIRE(testingImage,operator);
   
       
%          figure,imshow(testingImage); hold on;
%          imwrite(plot(x(i),y(i),'r.','MarkerSize',20),'testingImage_marked.jpg');
%             
%             %prototype2_img = ['OUTPUT_FOLDER/prototype_marked_',num2str(operator_num),'.jpg']
%            testingImage_marked_img = ['OUTPUT_FOLDER/testingImage_marked_',num2str(variable),'.jpg']
%            saveas(gcf,prototype2_img,'jpg') % marker image
%             
            

        new_max_response(i,variable) = max(max(output))
        
        
        
        
        counter = counter +1
        % name=strcat('output_',num2str(counter),'.mat'); % name of the mat  file generated from output
        % save(name,'output');% saving the matfile of particular output
    end
    
    
    
    
end
save('new_max_response.mat', 'new_max_response') ;

%load('./reshape_config_max_response.mat');
full_new_max_response = repmat(new_max_response, 5,1);
test_res= full_new_max_response>=repmat(z,5,1)
test_result_thrs =full_new_max_response>=0.7*repmat(z,5,1)
save('test_result.mat','test_res');
save('test_result_thrs.mat','test_result_thrs');


%     % Show the detected points based on the maxima responses of output.
%     fig_aux=figure('visible','off');
%         maximaPoints(testingImage,{output},8,1);
%     %saveas(fig_aux,['./Results/Results_', d(i).name, '_', num2str(i),'.jpg'],'jpg')
%     saveas(fig_aux,['./Results/Results_', d(i).name],'jpg')
%     disp('waiting')




