%% Depth Evaluation with ZED and ZED-Mini
%{

This software was created to asses depth estimation calculated by 3 
different algorithms, namely Direct Linear Transformation (DLT), 
Disparity Map via Semi-Global Matching (SMG) and Direct Disparity  
using data obtained with ZED and ZED-Mini Stereo Cameras.

Data was obtained as part of a Master's Thesis Project at Carleton 
Univerisity, Ottawa, ON, Canada. 
 
The data is obtained as raw images for further stereo rectification and
rectified obtained from ZED SDK software to compare the impact of camera
calibration over the final results.
 
For further reading, please refer to chapters 1 to 4 from [1].

Author:         Fabian Aguilar
Date:           06/30/19
Edition:        2
Latest Edition: 07/05/20
 

Reference: [1] E. F. Aguilar Calzadillas, "Sparse Stereo Visual Odometry 
           with Local Non-Linear Least-Squares Optimization for 
           Navigation of Autonomous Vehicles", M.A.Sc. Thesis, 
           Depart. of Mech. and Aero. Eng., Carleton University, 
           Ottawa ON, Canada, 2019. [Online] Available: 
           https://curve.carleton.ca/7270ba62-1fd3-4f1b-a1fa-6031b06585e9
%}
%% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
close all; clear all; clc;

%% Get input from user:
[model, calibration, environment, depth, resolution, features, debug] ...
    = getInputFromUser();

%% Read data & rectify images
[IL, IR, stereo] = getData(model, calibration, environment, ...
    depth, resolution);

% Plot images for debuging
if debug
    figure
    imshow(IL)
    axis on; %grid minor
    title('Left Lens Input Image with no Rectification - Resolution 1080x1920 pixels', 'FontSize', 18)
    xlabel('u [pixels]', 'FontSize', 16); ylabel('v [pixels]', 'FontSize', 16)
    set(gca,'FontSize',14)
    
    figure
    imshow(IR)
    axis on; %grid minor
    title('Right Lens Input Image with no Rectification - Resolution 1080x1920 pixels', 'FontSize', 18)   
    xlabel('u [pixels]', 'FontSize', 16); ylabel('v [pixels]', 'FontSize', 16)
    set(gca,'FontSize',14)
end


%% Rectify Stereo Images ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
switch(calibration)
    case 'ZED'
        [~, ~] = rectifyStereoImages(IL, IR, stereo.stereoParams);
        IL_Rect = IL;
        IR_Rect = IR;
    case 'Custom'
        [IL_Rect, IR_Rect] = rectifyStereoImages(IL, IR, stereo.stereoParams);
end

% Plot images for debuging 
if debug
    figure
    imshow(IL_Rect)
    axis on; %grid minor
    title('Left Lens Rectified Image - Input Res. 1080x1920p - Output Res. 1045x2070p', 'FontSize', 18)
    xlabel('u [pixels]', 'FontSize', 16); ylabel('v [pixels]', 'FontSize', 16)
    set(gca,'FontSize',14)
    
    figure
    imshow(IR_Rect)
    axis on; %grid minor
    title('Right Lens Rectified Image - Input Res. 1080x1920p - Output Res. 1045x2070p', 'FontSize', 18)   
    xlabel('u [pixels]', 'FontSize', 16); ylabel('v [pixels]', 'FontSize', 16)
    set(gca,'FontSize',14)
    
    figure
    imshow(stereoAnaglyph(IL_Rect,IR_Rect));
    axis on
    title('Left and Right Rectified Images - Input Res. 1080x1920p - Output Res. 1045x2070p', 'FontSize', 18)   
    xlabel('u [pixels]', 'FontSize', 16); ylabel('v [pixels]', 'FontSize', 16)
    set(gca,'FontSize',14)
end
 
%% Find Checkerboard ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[matchedPoints, keyPoints, descriptor] = getMatchingKeyPoints(IL_Rect, ...
            IR_Rect, stereo, features);

if debug
    figure
    showMatchedFeatures(IL_Rect, IR_Rect, matchedPoints.Left, matchedPoints.Right);
    legend('Features Left Camera', 'Features Right Camera')
    title('Harris Corner Detection and Matching - FLANN', 'FontSize', 18); axis on
    xlabel('u [pixels]', 'FontSize', 16); ylabel('v [pixels]', 'FontSize', 16)
    set(gca,'FontSize',14)
end

%% Remove Outliers from matchedPoints ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if length(matchedPoints.Left.Location) >= 5
    [~, idxInliers] = estimateEssentialMatrix(matchedPoints.Left.Location, ...
            matchedPoints.Right.Location, stereo.stereoParams.CameraParameters1,...
            stereo.stereoParams.CameraParameters2, ...
            'MaxNumTrials', 1000, 'MaxDistance', 0.01, 'Confidence', 99.9999);
    
    % Retrive inliers
    inliers.Left = matchedPoints.Left(idxInliers);
    inliers.Right = matchedPoints.Right(idxInliers);   
else
    % Retrive inliers
    inliers.Left = matchedPoints.Left;
    inliers.Right = matchedPoints.Right;
end

% Plot images for debuging 
if debug
    figure
    showMatchedFeatures(IL_Rect, IR_Rect,inliers.Left, inliers.Right, 'montage');
    legend('Inliers Left Camera', 'Inliers Right Camera')
    title('Inliers Only - Harris Corner Detector - FLANN', 'FontSize', 18); axis on
    xlabel('u [pixels]', 'FontSize', 16); ylabel('v [pixels]', 'FontSize', 16)
    set(gca,'FontSize',14)
    
    figure
    showMatchedFeatures(IL_Rect, IR_Rect,inliers.Left, inliers.Right);
    legend('Inliers Left Camera', 'Inliers Right Camera')
    title('Inliers Only - Harris Corner Detector - FLANN', 'FontSize', 18); axis on
    xlabel('u [pixels]', 'FontSize', 16); ylabel('v [pixels]', 'FontSize', 16)
    set(gca,'FontSize',14)
end


%% Calculate Depth ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[worldPointsDLT, worldPointsSGM, worldPointsDisparity] = ...
            sceneReconstruction(IL_Rect, IR_Rect, inliers, stereo, ...
            calibration, debug);
        
%% Find the closest point to the desired distance ~~~~~~~~~~~~~~~~~~~~~~~
% For Direct Disparity ...
worldPointsDisparity.distance = sqrt(sum(worldPointsDisparity.points3D_Disparity.^2,2));
[~, worldPointsDisparity.idx] = min(abs(bsxfun(@minus, depth, ...
                worldPointsDisparity.distance)));
worldPointsDisparity.label = sprintf('Depth = %0.2f meters', ...
                worldPointsDisparity.distance((worldPointsDisparity.idx))); 
worldPointsDisparity.position = [matchedPoints.Left.Location(worldPointsDisparity.idx,1) - 5,...
                matchedPoints.Left.Location(worldPointsDisparity.idx,2) - 5, 10, 10];

% For Direct Linear Transformation ...
worldPointsDLT.distance = sqrt(sum(worldPointsDLT.points3D_DLT.^2,2));
[~, worldPointsDLT.idx] = min(abs(bsxfun(@minus, depth, ...
                worldPointsDLT.distance)));
worldPointsDLT.label = sprintf('Depth = %0.2f meters', ...
                worldPointsDLT.distance(worldPointsDLT.idx));
worldPointsDLT.position = [matchedPoints.Left.Location(worldPointsDLT.idx,1) - 5, ...
                matchedPoints.Left.Location(worldPointsDLT.idx,2) - 5, 10, 10];

% For Disparity Map with Semi-Global matching ...
worldPointsSGM.distance = sqrt(sum(worldPointsSGM.points3D_SGM.^2,2));
[~, worldPointsSGM.idx] = min(abs(bsxfun(@minus, depth, ...
                worldPointsSGM.points3D_SGM(:,3))));
worldPointsSGM.label = sprintf('Depth = %0.2f meters',...
                worldPointsSGM.distance(worldPointsSGM.idx));
worldPointsSGM.position = [matchedPoints.Left.Location(worldPointsSGM.idx,1) - 5, ...
                matchedPoints.Left.Location(worldPointsSGM.idx,2) - 5, 10, 10];

%% Plot results ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% For Direct Disparity ...
figure
imshow(insertObjectAnnotation(IL_Rect, 'rectangle', ...
                worldPointsDisparity.position, ...
                worldPointsDisparity.label, 'FontSize',21));
title(sprintf('Closest Keypoint Depth Estimation by Direct Disparity at %d meters', depth));
xlabel('u [pixels]', 'FontSize', 16); ylabel('v [pixels]', 'FontSize', 16)
set(gca,'FontSize',14)

% For Direct Linear Transformation ...
figure
imshow(insertObjectAnnotation(IL_Rect, 'rectangle', ...
                worldPointsDLT.position, worldPointsDLT.label, 'FontSize',21));
title(sprintf('Closest Keypoint Depth Estimation by DLT at %d meters', depth));
axis on;
xlabel('u [pixels]', 'FontSize', 16); ylabel('v [pixels]', 'FontSize', 16)
set(gca,'FontSize',14)

% For Disparity Map with Semi-Global matching ...
figure
imshow(insertObjectAnnotation(IL_Rect, 'rectangle', ...
                worldPointsSGM.position, worldPointsSGM.label, 'FontSize',21));
title(sprintf('Closest Keypoint Depth Estimation by SGM at %d meters', depth));
axis on;
xlabel('u [pixels]', 'FontSize', 16); ylabel('v [pixels]', 'FontSize', 16)
set(gca,'FontSize',14)