function [fv] = preProcessor (im) 

% Create a cascade detector object.
faceDetector = vision.CascadeObjectDetector;

%Returns Bounding Box values based on number of objects
BB = step(faceDetector,im);

% figure,
% imshow(im); hold on
size(BB,1);

% ----------------------------------------------------------------------------

% to  detect Nose
NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',16);

BB=step(NoseDetect,im);

% Detect feature points in the nose region.
points = detectMinEigenFeatures(im, 'ROI', BB);
xnose = points.Location();
xnose = xnose(:,1);
ynose = points.Location();
ynose = ynose(:,2);
% line(xnose,ynose,'Color','red','LineStyle','--')

% Display the detected points.
figure,
imshow(im), hold on,
title('Detected features');
plot(points);


% -----------------------------------------------------------------------------------------
%To detect Eyes
EyeDetect = vision.CascadeObjectDetector('EyePairBig');

BB=step(EyeDetect,im);
size(BB)
%Eyes=imcrop(im,BB);

% Detect feature points in the face region.
points = detectMinEigenFeatures(im, 'ROI', BB(1,:));
xeye = points.Location();
xeye = xeye(:,1);
yeye = points.Location();
yeye = yeye(:,2);


% Display the detected points.
figure, imshow(im), hold on, title('Detected features');
plot(points);

% -------------------------------------------------------------------------------------------------
 MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',32); 
BBMouth=step(MouthDetect,im);
size(BBMouth)
% Detect feature points in the face region.
pointsUp = detectMinEigenFeatures(im, 'ROI', BBMouth(1,:));
pointsUp.Location();
xmouthUp = pointsUp.Location();
xmouthUp = xmouthUp(:,1);
ymouthUp = pointsUp.Location();
ymouthUp = ymouthUp(:,2);

% Display the detected points.
figure, imshow(im), hold on, title('Detected features');
plot(pointsUp);
if(size(BBMouth,1)) > 1
    % Detect feature points in the face region.
    pointsDown = detectMinEigenFeatures(im, 'ROI', BBMouth(2,:));
    pointsDown.Location();
    xmouthDown = pointsDown.Location();
    xmouthDown = xmouthDown(:,1);
    ymouthDown = pointsDown.Location();
    ymouthDown = ymouthDown(:,2);
    
    % Display the detected points.
    figure, imshow(im), hold on, title('Detected features');
    plot(pointsDown);
    
end

% =========================================>

%Get the most imortant points for the eye
eyeFv = zeros(8,1);
xleft = 1000 ;
indexLeft = 1 ;
indexRight = 1 ;
xright = -1000 ;
for i = 1:size(xeye,1)
    if xeye > xright
        xright = xeye ;
        indexRight = i ;
        
    end
    if xeye < xleft
        xleft = xeye ;
        indexLeft = i ;
    end
end

yUp = -1000 ;
indexDown = 1 ;
indexUp = 1 ;
yDown = 1000 ;
for i = 1:size(yeye,1)
    if yeye > yUp
        yUp = yeye ;
        indexUp = i ;
    end
    if yeye < yDown
        yDown = yeye ;
        indexDown = i ;
    end
end
eyeFv(1,:) = xeye(indexLeft,1) ;
eyeFv(2,:) = yeye(indexLeft,1) ;
eyeFv(3,:) = xeye(indexUp,1) ;
eyeFv(4,:) = yeye(indexUp,1) ;
eyeFv(5,:) = xeye(indexRight,1) ;
eyeFv(6,:) = yeye(indexRight,1) ;
eyeFv(7,:) = xeye(indexDown,1) ;
eyeFv(8,:) = yeye(indexDown,1) ;

%Get the most imortant points for the nose
noseFv = zeros(8,1);
xleft = 1000 ;
indexLeft = 1 ;
indexRight = 1 ;
xright = -1000 ;
for i = 1:size(xnose,1)
    if xnose > xright
        xright = xnose ;
        indexRight = i ;
        
    end
    if xnose < xleft
        xleft = xnose ;
        indexLeft = i ;
    end
end

yUp = -1000 ;
indexDown = 1 ;
indexUp = 1 ;
yDown = 1000 ;
for i = 1:size(ynose,1)
    if ynose > yUp
        yUp = ynose ;
        indexUp = i ;
    end
    if ynose < yDown
        yDown = ynose ;
        indexDown = i ;
    end
end
noseFv(1,:) = xnose(indexLeft,1) ;
noseFv(2,:) = ynose(indexLeft,1) ;
noseFv(3,:) = xnose(indexUp,1) ;
noseFv(4,:) = ynose(indexUp,1) ;
noseFv(5,:) = xnose(indexRight,1) ;
noseFv(6,:) = ynose(indexRight,1) ;
noseFv(7,:) = xnose(indexDown,1) ;
noseFv(8,:) = ynose(indexDown,1) ;

%Get the most imortant points for the mouthUp
mouthUpFv = zeros(8,1);
xleft = 1000 ;
indexLeft = 1 ;
indexRight = 1 ;
xright = -1000 ;
for i = 1:size(xmouthUp,1)
    if xmouthUp > xright
        xright = xmouthUp ;
        indexRight = i ;
        
    end
    if xmouthUp < xleft
        xleft = xmouthUp ;
        indexLeft = i ;
    end
end

yUp = -1000 ;
indexDown = 1 ;
indexUp = 1 ;
yDown = 1000 ;
for i = 1:size(ymouthUp,1)
    if ymouthUp > yUp
        yUp = ymouthUp ;
        indexUp = i ;
    end
    if ymouthUp < yDown
        yDown = ymouthUp ;
        indexDown = i ;
    end
end
mouthUpFv(1,:) = xmouthUp(indexLeft,1) ;
mouthUpFv(2,:) = ymouthUp(indexLeft,1) ;
mouthUpFv(3,:) = xmouthUp(indexUp,1) ;
mouthUpFv(4,:) = ymouthUp(indexUp,1) ;
mouthUpFv(5,:) = xmouthUp(indexRight,1) ;
mouthUpFv(6,:) = ymouthUp(indexRight,1) ;
mouthUpFv(7,:) = xmouthUp(indexDown,1) ;
mouthUpFv(8,:) = ymouthUp(indexDown,1) ;
%Get the most imortant points for the mouthDown
if(size(BBMouth,1) > 1)
    mouthDownFv = zeros(8,1);
    xleft = 1000 ;
    indexLeft = 1 ;
    indexRight = 1 ;
    xright = -1000 ;
    for i = 1:size(xmouthDown,1)
        if xmouthDown > xright
            xright = xmouthDown ;
            indexRight = i ;
            
        end
        if xmouthDown < xleft
            xleft = xmouthDown ;
            indexLeft = i ;
        end
    end

    yUp = -1000 ;
    indexDown = 1 ;
    indexUp = 1 ;
    yDown = 1000 ;
    for i = 1:size(ymouthDown,1)
        if ymouthDown > yUp
            yUp = ymouthDown ;
            indexUp = i ;
        end
        if ymouthDown < yDown
            yDown = ymouthDown ;
            indexDown = i ;
        end
    end
    mouthDownFv(1,:) = xmouthDown(indexLeft,1) ;
    mouthDownFv(2,:) = ymouthDown(indexLeft,1) ;
    mouthDownFv(3,:) = xmouthDown(indexUp,1) ;
    mouthDownFv(4,:) = ymouthDown(indexUp,1) ;
    mouthDownFv(5,:) = xmouthDown(indexRight,1) ;
    mouthDownFv(6,:) = ymouthDown(indexRight,1) ;
    mouthDownFv(7,:) = xmouthDown(indexDown,1) ;
    mouthDownFv(8,:) = ymouthDown(indexDown,1) ;
end

% ========================================>
index = 1;
fv = [];

%Calculate the euclodian distance
it = 1 ; 
diference = power((eyeFv(1,1)-eyeFv(5,1)),2) + power((eyeFv(2,1)-eyeFv(6,1)),2);
diference = sqrt(diference);
fv = [fv;diference] ;
diference = power((eyeFv(3,1)-eyeFv(7,1)),2) + power((eyeFv(4,1)-eyeFv(8,1)),2);
diference = sqrt(diference);
fv = [fv;diference] ;
diference = power((mouthUpFv(1,1)-mouthUpFv(5,1)),2) + power((mouthUpFv(2,1)-mouthUpFv(6,1)),2);
diference = sqrt(diference);
fv = [fv;diference] ;
diference = power((noseFv(1,1)-noseFv(5,1)),2) + power((noseFv(2,1)-noseFv(6,1)),2);
diference = sqrt(diference);
fv = [fv;diference] ;
diference = power((eyeFv(1,1)-noseFv(1,1)),2) + power((eyeFv(2,1)-noseFv(2,1)),2);
diference = sqrt(diference);
fv = [fv;diference] ;
diference = power((eyeFv(5,1)-noseFv(5,1)),2) + power((eyeFv(6,1)-noseFv(6,1)),2);
diference = sqrt(diference);
fv = [fv;diference] ;
diference = power((eyeFv(5,1)-mouthUpFv(5,1)),2) + power((eyeFv(6,1)-mouthUpFv(6,1)),2);
diference = sqrt(diference);
fv = [fv;diference] ;
diference = power((noseFv(7,1)-mouthUpFv(3,1)),2) + power((noseFv(8,1)-mouthUpFv(4,1)),2);
diference = sqrt(diference);
fv = [fv;diference] ;
if(size(BBMouth,1) > 1)
    diference = power((mouthUpFv(7,1)-mouthDownFv(3,1)),2) + power((mouthUpFv(8,1)-mouthDownFv(4,1)),2);
    diference = sqrt(diference);
    fv = [fv;diference] ;
%     diference = power((mouthDownFv(1,1)-mouthDownFv(5,1)),2) + power((mouthDownFv(2,1)-mouthDownFv(6,1)),2);
%     diference = sqrt(diference);
%     fv = [fv;diference] ;
else
    diference = power((mouthUpFv(3,1)-mouthUpFv(7,1)),2) + power((mouthUpFv(4,1)-mouthUpFv(8,1)),2);
    diference = sqrt(diference);
    fv = [fv;diference] ;
end

diference = power((noseFv(1,1)-mouthUpFv(1,1)),2) + power((noseFv(2,1)-mouthUpFv(2,1)),2);
diference = sqrt(diference);
fv = [fv;diference] ;
diference = power((noseFv(5,1)-mouthUpFv(5,1)),2) + power((noseFv(6,1)-mouthUpFv(6,1)),2);
diference = sqrt(diference);
fv = [fv;diference] ;


size(fv);
end
