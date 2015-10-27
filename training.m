
clear;
close all;
disp('####### START of the Program ######')
path('COSFIRE/',path);
a = dir('narrative_pics/*jpg');
path('narrative_pics/',path);
path('../COSFIRE_Matlabcode',path);
path('./Gabor',path);
%for i = 3:length(a);
NCOSFIRES=3;
max_response = zeros(5,3);
operator_num = 0;

%%%%%%%%%training%%%%%%%%%%%%%%
% % Once you have selected the operator as good / you save it
% and you apply it over the image from which it was configured
% in order to see the maximum response it can achieve.
max_response=zeros(5,15);

for training_image = 1:5  % get the image lap1 etc
    
    training_image_prototype = imread(a(training_image).name); % prototype is the image in this case example lap1.jpg
    training_image_prototype = imresize(training_image_prototype,0.3);
    training_image_prototype = preprocessImage(training_image_prototype);
    
    for variable= 1:15
        
        % get the operator
        load (['./OUTPUT_FOLDER/operator_' num2str(variable) '.mat'])
        
        
        % apply cosfire
        new_matrix = applyCOSFIRE(training_image_prototype, operator );
        
        % save maximum from the matrix
        max_response(training_image,variable) = max(max(new_matrix))
        
    end
    
end
save('max_response.mat', 'max_response') ;
load('config_max_response.mat');


