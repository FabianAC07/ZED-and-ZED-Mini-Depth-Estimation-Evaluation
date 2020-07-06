%% sceneReconstruction ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%{
    This function calculates a 3D scene based on the images and the 

    * I/O       * Objects       * Description   
    Inputs:     - IL            - Rectified Image Left 
                - IR            - Rectified Image Right
                - points2D      - Inliers only set of matched keypoints
                - stereo        - Stereo Parameters (struct)
                - calibration   - Type of calibration (ZED of Custom)
                - debug         - Debugging parameter

    Outputs:    - worldPointsDLT    - 3D Points calculated via Direct 
                                      Linear Triangulation (DLT) 
                - worldPointsSGM    - 3D Points calculated via Disparity 
                                      Map using the Semi-Global Matching 
                                      (SGM) algorithm
                - worldPointsDisparity  - 3D Points calculated via Direct 
                                          Disparity, e.g. calculate the 
                                          disparity of a pair of points 2D
                                          and then process them to get a 3D
                                          point cloud.

    Helper Function:  
    
    - projectPoints() This function calculates the reprojection of the 3D
      world points into image plane, for error calculation porpuses.

    Created by:     Fabian Aguilar.
    Date:           06/30/19
    Edition:        2
    Edition date:   07/05/20
%}

%% Start Funtion ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [worldPointsDLT, worldPointsSGM, worldPointsDisparity] = ...
            sceneReconstruction(IL, IR, points2D, stereo, ...
            calibration, debug)           
%% Direct Linear Triangulation (DLT) ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[points3D_DLT, error_DLT] = triangulate(points2D.Left, ...
                points2D.Right, stereo.stereoParams);

% Output of DLT is in mm, convert to meters
points3D_DLT = points3D_DLT ./ 1000;

%% Semi-Global Matching for Disparity Map
% Define a Diparity range between the two stereo images
disparityRange = [0, 128];

% Calculate the disparity map
disparityMap = disparitySGM(rgb2gray(IL), rgb2gray(IR), ...
                'DisparityRange',disparityRange,...
                'UniquenessThreshold',0);

% Apply a median filter to the disparity map
disparityMapFiltered = medfilt2(disparityMap, [15 15]);

% Check if the calibration type is ZED, if so MATLAB will not allow you to
% produce the scene reconstruction (pointcloud) from the disparity map,
% this is becuase MATLAB requires to rectify the stereo images with  
% "rectifyStereoImages()" before performe scene reconstruction with 
% reconstructScene()
if strcmp(calibration, 'Custom')
    scene = reconstructScene(disparityMapFiltered, stereo.stereoParams);

    % Convert to meters and create a pointCloud object
    scene = scene ./ 1000;
    scenePC = pointCloud(scene, 'Color', IL);
    
    if debug
        % Create a streaming point cloud viewer
        player3D = pcplayer([-15, 30], [-25, 2], [-2, 70], ...
                            'VerticalAxis', 'y', 'VerticalAxisDir', 'down');
        view(player3D, scenePC)
    end
end
    
% Plot the disparity maps for debugging  
if debug
    % Use imtool for debugging puposes, imtool() is used to determine the
    % right disparityRange: 
    % imtool(stereoAnaglyph(IL, IR));
    
    figure(40);
    subplot(2,1,1)
    imshow(disparityMap, disparityRange);
    title('Disparity Map');
    hold on
    colormap(gca,jet)
    axis on
    colorbar
    
    % figure;
    subplot(2,1,2)
    imshow(disparityMapFiltered, disparityRange);
    title('Disparity Map Filtered');
    hold on
    colormap(jet)
    axis on
    colorbar
    xlabel('u pixels'); 
    ylabel('v pixels');
    
    figure(41)
    imshow(disparityMapFiltered, disparityRange);
    title('Disparity Map from SGM', 'FontSize', 18)
    axis on; colormap(gca,jet)
    xlabel('u [pixels]', 'FontSize', 16); 
    ylabel('v [pixels]', 'FontSize', 16)
    set(gca,'FontSize',14)
    
%     imshowpair(disparityMap, disparityMapFiltered, 'montage');
    close(figure(40), figure(41))
end

% Floor the 2D points coordinates. This is due to the disparity map only
% returns integers. Also, this process introduces innerent error to the
% calculation.
points2DLeft = round(points2D.Left.Location);
% points2DRight = floor(points2D.Right.Location);

% Find the 3D world coordinates of the points 2D over the disparity map.
idx = sub2ind(size(disparityMap), points2DLeft(:, 2), points2DLeft(:, 1));
disparities = disparityMap(idx);

points1 = points2D.Left.Location';
points2 = points2D.Right.Location';

% Retive the stereo camara parameters for calculation:
b = abs(stereo.stereoParams.TranslationOfCamera2(1));
f = stereo.stereoParams.CameraParameters1.FocalLength(1);
u0 = stereo.stereoParams.CameraParameters1.PrincipalPoint(1);
v0 = stereo.stereoParams.CameraParameters1.PrincipalPoint(2);

% Calculate 3D world coordinates
X = b * (points1(1,:) - u0) ./ disparities';
Y = b * (points2(2,:) - v0) ./ disparities';
Z = f * b ./ disparities';
points3D_SGM = [X' Y' Z'];

% Backprojection Error:
points1proj = projectPoints(points3D_SGM, stereo.PL');
points2proj = projectPoints(points3D_SGM, stereo.PR');

% Calculate the error of backprojection
errors1 = hypot(points1(1,:)-points1proj(1,:), ...
                points1(2,:) - points1proj(2,:));
errors2 = hypot(points2(1,:)-points2proj(1,:), ...
                points2(2,:) - points2proj(2,:));
error_SGM = mean([errors1; errors2])';

% World coordinates of the inliers.
points3D_SGM = points3D_SGM ./ 1000;

%% Direct Disparity ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Retirve 2D points in left and right image
points2D_Left = points2D.Left.Location;
points2D_Right = points2D.Right.Location;

% Calculate the disparity (distance) between the pait of points
d = points2D_Left(:,1) - points2D_Right(:,1);

% Calculate 3D world coordinates
X = b * (points2D_Left(:,1) - u0) ./ d;
Y = b * (points2D_Left(:,2) - v0) ./ d;
Z = f * b ./ d;
points3D_Disparity = [X Y Z];

% Backprojection Error:
points3proj = projectPoints(points3D_Disparity, stereo.PL');
points4proj = projectPoints(points3D_Disparity, stereo.PR');

% Calculate the error of backprojection
errors3 = hypot(points2D_Left(:,1)'-points3proj(1,:), ...
                points2D_Left(:,2)' - points3proj(2,:));
errors4 = hypot(points2D_Right(:,1)-points4proj(1,:), ...
                points2D_Right(:,1) - points4proj(2,:));
error_Disparity = mean([errors3; errors4])';

% World coordinates of the inliers.
points3D_Disparity = points3D_Disparity ./ 1000;

%% Wrap up the Output ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

worldPointsDLT.points3D_DLT = points3D_DLT;
worldPointsDLT.error_DLT = error_DLT;
worldPointsSGM.points3D_SGM = points3D_SGM;
worldPointsSGM.error_SGM = error_SGM;
worldPointsDisparity.points3D_Disparity = points3D_Disparity;
worldPointsDisparity.error_Disparity = error_Disparity;

end
% End of Function ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%% Helper Function
function points2d = projectPoints(points3d, P)
points3dHomog = [points3d, ones(size(points3d, 1), 1, 'like', points3d)]';
points2dHomog = P * points3dHomog;
points2d = bsxfun(@rdivide, points2dHomog(1:2, :), points2dHomog(3, :));
end
