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

path('COSFIRE/',path);
path('Gabor/',path);

% First, compile the c-function called maxblurring_written_in_c.c
d = dir('./COSFIRE/maxblurring.*');
if isempty(d)
    mex COSFIRE/written_in_c_maxblurring.c -outdir . -output maxblurring;
end

%d = dir('/Users/vnpandey/Pictures/NarrativeClip/2015/04/23/*jpg');
dir_im=('./narrative_pics/');
d = dir(dir_im);

for i = 1:numel(d)
    
    testingImage = imread([dir_im d(i+3).name]);
    testingImage = preprocessImage(testingImage);
    
   load ('./OUTPUT_FOLDER/operator_lap1.jpg_1_num_1.mat')
    
    % Apply the uCOSFIRE to the input image
    output = applyCOSFIRE(testingImage,operator);
    
    % Show the detected points based on the maxima responses of output.
    fig_aux=figure('visible','off'); 
        maximaPoints(testingImage,{output},8,1);
    saveas(fig_aux,['./Results/R1/Results_' d(i).name '_' i],'jpg')
end







