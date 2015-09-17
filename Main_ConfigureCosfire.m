
clear;
close all;
disp('####### START of the Program ######')
path('COSFIRE/',path);
a = dir('narrative_pics/*jpg');
path('narrative_pics/',path);
path('../COSFIRE_Matlabcode',path);
%for i = 3:length(a);
NCOSFIRES=1;


mkdir OUTPUT_FOLDER
for  i =1 %i=1:numel(a)
    a(i).name
    prototype = imread(a(i).name); % prototype is the image in this case example lap1.jpg
    prototype = imresize(prototype,0.3);
    prototype = preprocessImage(prototype);
    
    % select 3 such coordinate points for both x and y
    
    %for lap1.jpg
    x=[42 34 121] ; y=[25 197 259];
     
    
    %for lap2.jpg
    %x=[9 110 61] ; y=[224 212 146];
    
    %for lap3.jpg
   % x=[106 65 18] ; y=[31 62 144];
    
    %for lap4.jpg
    %x=[184 172 106] ; y=[128 95 96];
   
    % for lap5.jpg
    %x=[220 38 130] ; y=[145 88 31];
    
    num=0;
    for i_xy=1:length(x)
        % assign values to params
        params = Parameters_Sw;% assigning parameter values
        
        % Configure a COSFIRE operator
        operator = configureCOSFIRE(prototype, round([y(i_xy),x(i_xy)]),params);
        size(operator.tuples,2)% generates edges of the image
        
       if size(operator.tuples,2)>4
           % if size(operator.tuples,2)<20
            num = num+1
            % Show the structure of the COSFIRE operator
            viewCOSFIREstructure(operator);% shows the filters round structures
            img_cosfire=['OUTPUT_FOLDER/cosfire_filter_',a(i).name,'_',num2str(i_xy),'_num_',num2str(num),'.jpg']
            saveas(gcf,img_cosfire,'jpg') ;
            %disp('Press any key to continue')
            % prototype2 -> prototype + keypoint selected
            imshow(prototype);
            hold on;
            
            imwrite(plot(x,y,'r.','MarkerSize',20),'prototype2.jpg');
 
            
            %imshow(prototype2);
            img_out=['OUTPUT_FOLDER/ptype_',a(i).name,'_',num2str(i_xy),'_num_',num2str(num),'.jpg']
            saveas(gcf,img_out,'jpg') ;
            % save operator
            save(['OUTPUT_FOLDER/operator_', a(i).name,'_',num2str(i_xy),'_num_',num2str(num), '.mat'], 'operator') ;
            
            figure,
            subplot(1,3,1), imshow(prototype);
            prototype_temp = imread(img_out);
            prototype_temp = imresize(prototype_temp,0.3);
            prototype_temp = preprocessImage(prototype_temp);
            
            subplot(1,3,2), imshow(prototype_temp);
            subplot(1,3,3), imshow(img_cosfire);
            
            img_plot=['OUTPUT_FOLDER/plot_',a(i).name,'_',num2str(i_xy),'_num_',num2str(num),'.jpg']
            saveas(gcf,img_plot,'jpg') ;
            
        end
        if num >= NCOSFIRES
            break
        end
    end
    
    
    
end
