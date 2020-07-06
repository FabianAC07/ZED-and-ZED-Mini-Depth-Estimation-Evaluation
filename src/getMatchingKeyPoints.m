%% getMatchingKeyPoints ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%{
    This function detects and return the matched keypoints over a pair of 
    rectified stereo images:

    * I/O       * Objects       * Description   
    Inputs:     - IL            - Rectified Image Left 
                - IR            - Rectified Image Right
                - stereo        - Stereo Parameters (struct)
                - features      - Type of features to be processed

    Outputs:    - matchedPoints - Valid matched points in left and right
                                  images
                - keypoints     - Strongest detected points over images
                                  left and right
                - descriptor    - Type of keypoint descriptor

    Created by:     Fabian Aguilar.
    Date:           06/30/19
    Edition:        2
    Edition date:   07/04/20
%}

%% Start Funtion ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [matchedPoints, keyPoints, descriptor] = ...
            getMatchingKeyPoints(IL, IR, stereo, features)

% Convert images to gray scale 
IL_gray = rgb2gray(IL);
IR_gray = rgb2gray(IR);
    
%% Feature Detection process

% TODO: Include more Features and Descriptors options, such as:
% FAST - detectFASTFeatures
% Good Features to Track - detectMinEigenFeatures
% ORB - detectORBFeatures
% If more features are added, remember to modify getInputFromUser

switch(features)
    case 'Harris' % Harris Features Detector
        detectedFeatures1 = detectHarrisFeatures(IL_gray, ...
            'MinQuality', 1e-5, ...
            'FilterSize', 3, ...
            'ROI', stereo.ROI);
        detectedFeatures2 = detectHarrisFeatures(IR_gray, ...
            'MinQuality', 1e-5, ...
            'FilterSize', 3, ...
            'ROI', stereo.ROI);
    case 'SURF' % SURF Deterctor
        detectedFeatures1 = detectSURFFeatures(IL_gray, ...
            'MetricThreshold', 1e-5, ...
            'NumOctaves', 4, ...
            'NumScaleLevels', 3, ...
            'ROI', stereo.ROI);
        detectedFeatures2 = detectSURFFeatures(IR_gray, ...
            'MetricThreshold', 1e-5, ...
            'NumOctaves', 4, ...
            'NumScaleLevels', 3, ...
            'ROI', stereo.ROI);
end

% Keep strongest features
points1 = selectStrongest(detectedFeatures1, 20);
points2 = selectStrongest(detectedFeatures2, 20);

% Extract Features
[descriptor1, validPoints1] = extractFeatures(IL_gray, points1, ...
              'Upright', true, ...
              'FeatureSize', 128);
[descriptor2, validPoints2] = extractFeatures(IR_gray, points2, ...
              'Upright', true, ...
              'FeatureSize', 128);
          
% Index of matching features
switch(features)
    case 'Harris'
        [idxPairs, ~] = matchFeatures(descriptor1, descriptor2, ...
                        'Method', 'Approximate', ... % Exhaustive or Approximate
                        'MatchThreshold', 100, ...
                        'MaxRatio', 0.7, ...
                        'Unique', true);
    case 'SURF'
        [idxPairs, ~] = matchFeatures(descriptor1, descriptor2, ...
                        'Method', 'Approximate', ... % Exhaustive or Approximate
                        'MatchThreshold', 10, ...
                        'MaxRatio', 0.7, ...
                        'Unique', true);
end

% Valid Matched Points
matchedPoints1 = validPoints1(idxPairs(:,1));
matchedPoints2 = validPoints2(idxPairs(:,2));


%% Wrap output...
matchedPoints.Left = matchedPoints1;
matchedPoints.Right = matchedPoints2;
keyPoints.Left = points1;
keyPoints.Right = points2;
descriptor.Left = descriptor1;
descriptor.Right = descriptor2;

end

%% End of Funtion ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~