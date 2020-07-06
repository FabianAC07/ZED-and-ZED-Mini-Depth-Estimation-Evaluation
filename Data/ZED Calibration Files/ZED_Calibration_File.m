%% ZED_Calibration_File ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
%{
    Stereo Camera Parameters for ZED and ZED Mini Stereo Cameras by
    StereoLabs Coorporation. The data included in this file correspond to
    the ZED Camera SN21531 and ZED Mini Camera SN10027514, which are 
    available to download in the following links:
  
    * http://calib.stereolabs.com/?SN=21531
    * http://calib.stereolabs.com/?SN=10027514
    
    Intrinsic Parameters Nomenclature:

    fx >> Focal length x-axis               [pixels]
    fy >> Focal length y-axis               [pixels]
    cx >> Optical center coordinates x-axis [pixels]
    cy >> Optical center coordinates y-axis [pixels]
    k1 >> Distorcion coefficient 1
    k2 >> Distorcion coefficient 2
    p1 >> Tangential distorcion coefficient 1
    p2 >> Tangential distorcion coefficient 2

    Extrinsic Parameters Nomenclature

    B  >> Baseline (distance) from the Right optical center to the Left
          optical center.
    TY >> Translation in of the right optical center wrt the left optical 
          center in the Y-axis 
    TZ >> Translation in of the right optical center wrt the left optical 
          center in the Z-axis 
    RY >> Also CV. Rotation of Left optic center wrp to Right one.
    RX >> Rotation of Left optic center wrp to Right one.
    RZ >> Rotation of Left optic center wrp to Right one.

    NOTE: Stereolabs Calibration is Left sensor wrp to Right sensor.
          Rotations are in Rodigres notation and in milimeters [mm].


    Created by:     Fabian Aguilar.
    Date:           06/28/19
    Edition:        2
    Edition date:   07/04/20
%}
%% ZED 120 mm Camera parameters SN000021531  

%% Full HD - 1080 HD - Intrinsic Params 

% [LEFT_CAM_FHD]
ZED.FHD.L.fx = 1398.68;               
ZED.FHD.L.fy = 1398.68;               
ZED.FHD.L.cx = 959.873;                
ZED.FHD.L.cy = 576.67;
ZED.FHD.L.k1 = -0.176359;
ZED.FHD.L.k2 = 0.029149;
ZED.FHD.L.p1 = 0.000361254;
ZED.FHD.L.p2 = -0.000543264;

% [RIGHT_CAM_FHD]
ZED.FHD.R.fx = 1401.57;
ZED.FHD.R.fy = 1401.57;
ZED.FHD.R.cx = 966.608;
ZED.FHD.R.cy = 508.49;
ZED.FHD.R.k1 = -0.174367;
ZED.FHD.R.k2 = 0.0280189;
ZED.FHD.R.p1 = -0.000190735;
ZED.FHD.R.p2 = -0.000897378;

%% HD - 720 HD - Intrinsic Params

% [LEFT_CAM_HD]
ZED.HD.L.fx = 699.34;
ZED.HD.L.fy = 699.34;
ZED.HD.L.cx = 638.437;
ZED.HD.L.cy = 376.835;
ZED.HD.L.k1 = -0.176359;
ZED.HD.L.k2 = 0.029149;
ZED.HD.L.p1 = 0.000361254;
ZED.HD.L.p2 = -0.000543264;

% [RIGHT_CAM_HD]
ZED.HD.R.fx = 700.784;
ZED.HD.R.fy = 700.784;
ZED.HD.R.cx = 641.804;
ZED.HD.R.cy = 342.745;
ZED.HD.R.k1 = -0.174367;
ZED.HD.R.k2 = 0.0280189;
ZED.HD.R.p1 = -0.000190735;
ZED.HD.R.p2 = -0.000897378;

%% ZED 120 mm - Extrinsic Params Params
% [STEREO]
ZED.E.Baseline = 119.997;
ZED.E.TY = 0.00157105;
ZED.E.TZ = 0.00237081;
ZED.E.FHD.RY = 0.0125461;
ZED.E.FHD.RX = -0.00903268;
ZED.E.FHD.RZ = -0.00163963;
ZED.E.HD.RY = 0.0125461;
ZED.E.HD.RX = -0.00903268;
ZED.E.HD.RZ = -0.00163963;

%% ZED MINI 63 mm Camera parameters SN10027514

%% Full HD - 1080 HD - Intrinsic Params 

% [LEFT_CAM_FHD]
ZEDM.FHD.L.fx = 1400.42;
ZEDM.FHD.L.fy = 1400.42;
ZEDM.FHD.L.cx = 983.826;
ZEDM.FHD.L.cy = 544.321;
ZEDM.FHD.L.k1 = -0.174219;
ZEDM.FHD.L.k2 = 0.0277628;
ZEDM.FHD.L.p1 = -0.0000310761;
ZEDM.FHD.L.p2 = -0.0000335258;

% [RIGHT_CAM_FHD]
ZEDM.FHD.R.fx = 1399.68;
ZEDM.FHD.R.fy = 1399.68;
ZEDM.FHD.R.cx = 992.552;
ZEDM.FHD.R.cy = 524.002;
ZEDM.FHD.R.k1 = -0.176395;
ZEDM.FHD.R.k2 = 0.0290527;
ZEDM.FHD.R.p1 = 0.0000150278;
ZEDM.FHD.R.p2 = 0.00018937;

%% HD - 720 HD - Intrinsic Params

% [LEFT_CAM_HD]
ZEDM.HD.L.fx = 700.21;
ZEDM.HD.L.fy = 700.21;
ZEDM.HD.L.cx = 650.413;
ZEDM.HD.L.cy = 360.661;
ZEDM.HD.L.k1 = -0.174219;
ZEDM.HD.L.k2 = 0.0277628;
ZEDM.HD.L.p1 = -0.0000310761;
ZEDM.HD.L.p2 = -0.0000335258;

% [RIGHT_CAM_HD]
ZEDM.HD.R.fx = 699.838;
ZEDM.HD.R.fy = 699.838;
ZEDM.HD.R.cx = 654.776;
ZEDM.HD.R.cy = 350.501;
ZEDM.HD.R.k1 = -0.176395;
ZEDM.HD.R.k2 = 0.0290527;
ZEDM.HD.R.p1 = 0.0000150278;
ZEDM.HD.R.p2 = 0.00018937;

%% ZED 63 mm - Extrinsic Params Params
% [STEREO]
ZEDM.E.Baseline = 63.0226;
ZEDM.E.TY = 0.00302386;
ZEDM.E.TZ = -0.0360835;
ZEDM.E.FHD.RY = 0.000189208;
ZEDM.E.FHD.RX = 0.00300136;
ZEDM.E.FHD.RZ = -0.000855091;
ZEDM.E.HD.RY = 0.000189208;
ZEDM.E.HD.RX = 0.00300136;
ZEDM.E.HD.RZ = -0.000855091;

