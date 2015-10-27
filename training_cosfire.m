
% close all;
% clear all;

disp('####### START of the Program ######')
path('COSFIRE/',path);
a = dir('narrative_pics/*jpg');
path('narrative_pics/',path);
path('../COSFIRE_Matlabcode',path);
path('./Gabor',path);
load('config_max_response.mat');
z=reshape(config_max_response',1,15);
z = repmat(z, 5,1);
%for i = 3:length(a);
%count= 0;
NCOSFIRES=3;
max_response = zeros(5,15);
operator_num = 0;
for training_image = 1:5  % get the image lap1 etc
    a(training_image).name
    training_image_prototype = imread(a(training_image).name); % prototype is the image in this case example lap1.jpg
    training_image_prototype = imresize(training_image_prototype,0.3);
    training_image_prototype = preprocessImage(training_image_prototype);

    for variable= 1:15
        a(training_image).name
       
        % get the operator
        % get the image number and coordinate number
        image_num=floor((variable-1)/3)+1
        coord_num=floor(variable-(image_num-1)*3)
       %p ['./OUTPUT_FOLDER/operator_' sprintf('%02d',image_num),'_',sprintf('%03d',coord_num), '.mat']
        load (['./OUTPUT_FOLDER/operator_' sprintf('%02d',image_num),'_',sprintf('%03d',coord_num), '.mat'])
        %load (['./OUTPUT_FOLDER/operator_' num2str(image_num) '_' num2str(coord_num) '.mat'])

        % apply cosfire
        new_matrix = applyCOSFIRE(training_image_prototype, operator );
        [max_val,posn]=max(new_matrix(:));
        [rind,cind]=ind2sub(size(new_matrix),posn)
        max_response(training_image,variable) = max_val

%         % Visualize
        % save if the max value is equal or bigger to the training max + th
        %if max_response(training_image,variable) >= 0 %.7*z(training_image,variable)
       if max_response(training_image,variable)>=z(training_image,variable)
        imshow(training_image_prototype); hold on;
        imwrite(plot(cind,rind,'r.','MarkerSize',20),'prototype2.jpg');
        training_marked_img = ['OUTPUT_FOLDER/TrainNoTh/training_marked_',sprintf('%03d',training_image), '_',sprintf('%02d',image_num),'_',sprintf('%03d',coord_num),'.jpg']
        temp=['training\_marked\_',sprintf('%03d',training_image), '\_',sprintf('%02d',image_num),'\_',sprintf('%03d',coord_num),'.jpg']
        title(temp);
        saveas(gcf, training_marked_img , 'jpg');
         hold off;
        end
        

        % save maximum from the matrix
        
%         hold off;
        

    end

end

 
    save('max_response.mat', 'max_response') ; 
%    load('config_max_response.mat');
%    z=reshape(config_max_response',1,15);
%save('response_compre_config_training.mat','response_compre_config_training');
     response_compre_config_training=max_response>=z;
% %   result_thrsh = max_response>=0.7*repmat(z,10,1)



% nnz(~res) % counts number of zeros


