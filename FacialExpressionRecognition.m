function [ output_args ] = FacialExpressionRecognition( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
size1 = 38;
index = 1;
allFVs = zeros(11,size1);

%Starting the training algorithm
for i = 1:size1

    im = imread(strcat('emo',int2str(i), '.tiff'));
    i
    si1 = size(im)
    
    %Skip 3D images
    if(size(si1,2) > 2)
        continue;
    else
        fv= preProcessor (im) ;
        [rows,cols] = size(fv);
        
        %Save feature vectors for all training data
        allFvs(:,i)=fv(:,1);
    end
    
        
end
dlmwrite('trainingFvs.txt',allFvs) ;
end

