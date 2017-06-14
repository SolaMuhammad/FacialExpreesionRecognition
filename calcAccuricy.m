function [ accuracy ] = calcAccuricy( )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
size1 = 34;
rightClassified = 0;
for i = 1:34

    img = strcat('emo',int2str(i), '.tiff');
    im = imread(img);
    si1 = size(im)
    if(size(si1,2) > 2)
        continue;
    else
        x = meanDistanceClassifier( img );
    end
    
    
    if i <= 25 && strcmp(x,'This is a Surprised face')
        rightClassified = rightClassified +1 ;
    
    elseif i <= 35 && strcmp(x, 'This is a happy face')
        rightClassified = rightClassified +1 ;
       
    elseif i <= 45 && strcmp(x,'This is a smile face')
        rightClassified = rightClassified +1 ;
     
    elseif i <= 67 && strcmp(x, 'This is a sad face')
        rightClassified = rightClassified +1 ;
        
    elseif  i <= 76 && i> 67 && strcmp(x,'This is a disgust face')
        rightClassified = rightClassified +1 ;
    
    end
    
    accuracy  = rightClassified/size1;
        
end

end

