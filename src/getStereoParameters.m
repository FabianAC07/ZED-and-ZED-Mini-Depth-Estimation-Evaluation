%% getStereoParameters ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%{
    This function retunrs the stereo parameters of the stereo camera:

    * I/O       * Objects       * Description   
    Inputs:     - model         - ZED or ZED Mini 
                - calibration   - ZED or Custom
                - resolution    - HD (720p) or FHD (1080p)

    Outputs:    - stereo        - Struct containing the stereo parameters
                                  of the stereo camera
                

    Helper Function: getCameraParams

    Function which buids the stereo camera paratemers accordingly to MATLAB
    structure based on the stereo camera parameters provided by ZED
    Coorporation. The aforementioned parameters are stored on the file 
    "ZED_Calibration_File.m"

    Created by:     Fabian Aguilar.
    Date:           06/30/19
    Edition:        2
    Edition date:   07/04/20
%}

function [stereo] = getStereoParameters(model, calibration, resolution)

% ZED and ZED Mini Camera Parameters provided by ZED Corporation
switch(calibration)
    case 'ZED'
        run('ZED_Calibration_File.m')
        switch(model)
            case 'ZED'
                switch(resolution)
                    case 'FHD'
                        % Build Intrinsic Parameters
                        [stereo.PL_intrinsics, stereo.PR_intrinsics, ...
                            stereo.PL_params, stereo.PR_params, ...
                            stereo.stereoParams, stereo.PL, stereo.PR] = ...
                            getCameraParams(ZED, resolution);                     
                    case 'HD'
                        % Build Intrinsic Parameters
                        [stereo.PL_intrinsics, stereo.PR_intrinsics, ...
                            stereo.PL_params, stereo.PR_params, ...
                            stereo.stereoParams, stereo.PL, stereo.PR] = ...
                            getCameraParams(ZED, resolution);
                end                
            case 'ZED Mini'
                switch(resolution)
                    case 'FHD'
                        % Build Intrinsic Parameters
                        [stereo.PL_intrinsics, stereo.PR_intrinsics, ...
                            stereo.PL_params, stereo.PR_params, ...
                            stereo.stereoParams, stereo.PL, stereo.PR] = ...
                            getCameraParams(ZEDM, resolution);                        
                    case 'HD'
                        % Build Intrinsic Parameters
                        [stereo.PL_intrinsics, stereo.PR_intrinsics, ...
                            stereo.PL_params, stereo.PR_params, ...
                            stereo.stereoParams, stereo.PL, stereo.PR] = ...
                            getCameraParams(ZEDM, resolution);
                end
        end
% Custom Stereo Parameters ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~            
    case 'Custom'
        switch(model)
            case 'ZED'
                switch(resolution)
                    case 'FHD'
                        % Load Custom Calibration Parameters
                        stereo = load('Custom_Calibration_ZED_SN21531_FHD_1080.mat');
                    case 'HD'
                        % Load Custom Calibration Parameters
                        stereo = load('Custom_Calibration_ZED_SN21531_HD_720.mat');
                end
            case 'ZED Mini'
                switch(resolution)
                    case 'FHD'
                        % Load Custom Calibration Parameters
                        stereo = load('Custom_Calibration_ZED_Mini_SN10027514_FHD_1080.mat');
                    case 'HD'
                        % Load Custom Calibration Parameters
                        stereo = load('Custom_Calibration_ZED_Mini_SN10027514_HD_720.mat');
                end
        end   
        % Build camera matrix left
        stereo.PL = cameraMatrix(stereo.stereoParams.CameraParameters1, ...
                        eye(3), zeros(1,3));
        % Build camera matrix right
        stereo.PR = cameraMatrix(stereo.stereoParams.CameraParameters2, ...
                        stereo.stereoParams.RotationOfCamera2, ...
                        stereo.stereoParams.TranslationOfCamera2);
end

end

% End of Function ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%% HELPER FUNCTION
function [PL_intrinsics, PR_intrinsics, PL_params, PR_params, ...
                stereoParams, PL, PR] = getCameraParams(ZED, resolution)

switch(resolution)
    case 'FHD'
        % Define Image Size in rows and columns
        row = 1080;
        col = 1920;
        
        % Build Camerame Intrinsics 
        PL_intrinsics = cameraIntrinsics([ZED.FHD.L.fx, ZED.FHD.L.fy], ...
                [ZED.FHD.L.cx, ZED.FHD.L.cy], [row, col], ...
                'RadialDistortion', [ZED.FHD.L.k1, ZED.FHD.L.k2], ...
                'TangentialDistortion', [ZED.FHD.L.p1, ZED.FHD.L.p2]);
            
        PR_intrinsics = cameraIntrinsics([ZED.FHD.R.fx, ZED.FHD.R.fy], ...
                [ZED.FHD.R.cx, ZED.FHD.R.cy], [row, col], ...
                'RadialDistortion', [ZED.FHD.R.k1, ZED.FHD.R.k2],...
                'TangentialDistortion', [ZED.FHD.R.p1, ZED.FHD.R.p2]);
        
        % Build Camera parameters accordingly to matlab
        PL_params = cameraParameters('IntrinsicMatrix', PL_intrinsics.IntrinsicMatrix, ...
                'RadialDistortion', [ZED.FHD.L.k1, ZED.FHD.L.k2], ...
                'TangentialDistortion', [ZED.FHD.L.p1, ZED.FHD.L.p2]);
        PL_params.ImageSize = [row, col];   
        
        PR_params = cameraParameters('IntrinsicMatrix', PR_intrinsics.IntrinsicMatrix, ...
                'RadialDistortion', [ZED.FHD.R.k1, ZED.FHD.R.k2], ...
                'TangentialDistortion', [ZED.FHD.R.p1, ZED.FHD.R.p2]);
        PR_params.ImageSize = [row, col];
        
        % Build Stereo Camera parameters accordingly to matlab
        R = rotationVectorToMatrix([ZED.E.FHD.RX, ZED.E.FHD.RY, ZED.E.FHD.RZ]);
        %TODO: Chack that the translation vector is correctly build
        t = [-ZED.E.Baseline ZED.E.TY ZED.E.TZ];
        stereoParams = stereoParameters(PL_params, PR_params, R, t);
            
        % Build camera matrix left
        PL = (PL_intrinsics.IntrinsicMatrix' * [eye(3), zeros(3,1)])';
        PR = (PR_intrinsics.IntrinsicMatrix' * [R t'])';

    case 'HD'
        % Define Image Size in rows and columns
        row = 720;
        col = 1280;
        
        % Build Camerame Intrinsics
        PL_intrinsics = cameraIntrinsics([ZED.HD.L.fx, ZED.HD.L.fy], ...
                [ZED.HD.L.cx, ZED.HD.L.cy], [row, col], ...
                'RadialDistortion', [ZED.HD.L.k1, ZED.HD.L.k2], ...
                'TangentialDistortion', [ZED.HD.L.p1, ZED.HD.L.p2]);
            
        PR_intrinsics = cameraIntrinsics([ZED.HD.R.fx, ZED.HD.R.fy], ...
                [ZED.HD.R.cx, ZED.HD.R.cy], [row, col], ...
                'RadialDistortion', [ZED.HD.R.k1, ZED.HD.R.k2], ...
                'TangentialDistortion', [ZED.HD.R.p1, ZED.HD.R.p2]);
        
        % Build Camera parameters accordingly to matlab
        PL_params = cameraParameters('IntrinsicMatrix', PL_intrinsics.IntrinsicMatrix, ...
                'RadialDistortion', [ZED.HD.L.k1, ZED.HD.L.k2], ...
                'TangentialDistortion', [ZED.HD.L.p1, ZED.HD.L.p2]);
        PL_params.ImageSize = [row, col];
            
        PR_params = cameraParameters('IntrinsicMatrix', PR_intrinsics.IntrinsicMatrix, ...
                'RadialDistortion', [ZED.HD.R.k1, ZED.HD.R.k2], ...
                'TangentialDistortion', [ZED.HD.R.p1, ZED.HD.R.p2]);
        PR_params.ImageSize = [row, col];
        
        % Build Stereo Camera parameters accordingly to matlab
        %TODO: Chack that the translation vector is correctly build
        R = rotationVectorToMatrix([ZED.E.HD.RX, ZED.E.HD.RY, ZED.E.HD.RZ]);
        t = [-ZED.E.Baseline ZED.E.TY ZED.E.TZ];
        stereoParams = stereoParameters(PL_params, PR_params, R, t);
            
        % Build camera matrix left
        PL = cameraMatrix(PL_params, eye(3), zeros(1,3));
        % Build camera matrix right
        PR = cameraMatrix(PR_params, ...
                     stereoParams.RotationOfCamera2, ...
                     stereoParams.TranslationOfCamera2);
            
end

end
