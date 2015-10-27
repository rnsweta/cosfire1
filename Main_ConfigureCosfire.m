
clear all;
close all;
disp('####### START of the Program ######')
path('COSFIRE/',path);
a = dir('narrative_pics/*jpg');
path('narrative_pics/',path);
path('../COSFIRE_Matlabcode',path);
path('./Gabor',path);
%for i = 3:length(a);
NCOSFIRES=3;
max_response = zeros(7,3);
operator_num = 0;

mkdir OUTPUT_FOLDER
for  i=1:5
  
    % select 3 such coordinate points for both x and y
    
    if i == 1
         %for lap1.jpg as on 14th october
        x=[263 580 93] ; y=[401 483 373];
%         %for lap1.jpg
%         x=[580 93 46] ; y=[474 373 553];
     
    elseif i == 2
        %for lap2.jpg
        x=[130 13 59] ; y=[69 72 164];
     
    elseif i == 3
        %for lap3.jpg
        x=[20 53 261] ; y=[147 95 133];
     
        
    elseif i ==4
        %for lap4.jpg
        x=[260 18 260] ; y=[130 142 131];
    
    else i == 5
        % for lap5.jpg
        x=[213 220 45] ; y=[31 144 41];
% 
%     elseif i== 6
%          %for lap6.jpg
%           x=[394 346 390]; y=[220 234 123];
%        % x = [16 12]; y = [421 389];
%     
%      elseif i== 7
% % %          %for lap7.jpg
%             x=[243 566 308] ; y=[503 442 526];
% % 
%     elseif i== 8
%           %for lap8.jpg
%         x=[292 116 580] ; y=[184 29 198];
% 
%      elseif i== 9
% % %          %for lap8.jpg
%             x=[91 113 520] ; y=[158 15 259];
%    else i== 10
% %          %for lap10.jpg
%             x=[367 156 408] ; y=[293 567 526];

   
    end
 
     a(i).name
     prototype = imread(a(i).name); % prototype is the image in this case example lap1.jpg
     prototype = imresize(prototype,0.3);
     prototype = preprocessImage(prototype);
     num=0;
     
    for j = 1:3
        
        % assign values to params
        params = Parameters_Sw;% assigning parameter values  
        % Configure a COSFIRE operator       
        operator = configureCOSFIRE(prototype, round([y(j),x(j)]),params);
        size(operator.tuples,2)% generates edges of the image
      
        
        if size(operator.tuples,2)>4
            % if size(operator.tuples,2)<20
            num = num+1
            close all;
            % Show the structure of the COSFIRE operator
          viewCOSFIREstructure(operator);% shows the filters round structures
        
            operator_num = operator_num +1;
            img_cosfire=['OUTPUT_FOLDER/cosfire_filter_',sprintf('%02d',i),'_',sprintf('%03d',j),'.jpg']
%             saveas(gcf,img_cosfire,'jpg') ;
% %             
% %             
%             imshow(prototype); hold on;
%             imwrite(plot(x(j),y(j),'r.','MarkerSize',20),'prototype2.jpg');
%             hold off;
%             prototype2_img = ['OUTPUT_FOLDER/prototype_marked_',sprintf('%02d',i),'_', sprintf('%03d',j),'.jpg']
%             saveas(gcf,prototype2_img,'jpg') % marker image
%             
%           
%             
%             % save operator
            save(['OUTPUT_FOLDER/operator_',sprintf('%02d',i),'_', sprintf('%03d',j), '.mat'], 'operator') ;
            config_max_response(i,j) = max(max(applyCOSFIRE(prototype, operator) ));
        else
            disp('The operator does not have enough elements for the cosfire filter')
            a(i).name
            size(operator.tuples)
       
            
        end
        
        save('config_max_response.mat','config_max_response');
        if num >= NCOSFIRES
            break
        end
    end
    
end





%%%%%%%%%%training%%%%%%%%%%%%%%
% %% Once you have selected the operator as good / you save it
% % and you apply it over the image from which it was configured
% % in order to see the maximum response it can achieve.
% % max_response=zeros(5,15);
% %
% % for training_image = 1:5  % get the image lap1 etc
% %
% %     training_image_prototype = imread(a(training_image).name); % prototype is the image in this case example lap1.jpg
% %     training_image_prototype = imresize(training_image_prototype,0.3);
% %     training_image_prototype = preprocessImage(training_image_prototype);
% %
% %     for variable= 1:15
% %
% %         % get the operator
% %         load (['./OUTPUT_FOLDER/operator_' num2str(variable) '.mat'])
% %
% %
% %         % apply cosfire
% %         new_matrix = applyCOSFIRE(training_image_prototype, operator );
% %
% %         % save maximum from the matrix
% %         max_response(training_image,variable) = max(max(new_matrix))
% %
% %     end
% %
% % end
% %
%  save('max_response.mat', 'max_response') ;
% 
%  z=reshape(config_max_response',1,15);
% % res=max_response>=repmat(z,5,1)
% % result_thrs = max_response>=0.7*repmat(z,5,1)
% %
% 
% save('reshape_config_max_response.mat','z');
% save everything_config_cosfire.mat


