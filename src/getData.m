%% getData ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%{
    This function call the data to be used during the processing, acording
    to the user inputs, e.g. Stereo Image Pairs, Stereo Camara Parameters

    * I/O       * Objects       * Description   
    Inputs:     - model         - ZED or ZED Mini 
                - calibration   - ZED or Custom
                - environment   - Indoors os Outdoors
                - depth         - 5, 10, 15, 20, 25, 30 meters
                - resolution    - HD (720p) or FHD (1080p)

    Outputs:    - IL            - Image Left
                - IR            - Image Right
                - stereo        - Struct containing the stereo parameters
                                  of the stereo camera
                

    Helper Function: getStereoParameters

    Created by:     Fabian Aguilar.
    Date:           06/30/19
    Edition:        2
    Edition date:   07/04/20
%}

%% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function [IL, IR, stereo] = getData(model, calibration, environment, ...
    distance, resolution)

% Add the Data directory
addpath(genpath('../Data'))

%% ZED 120 mm
switch(model)
    case 'ZED'
        switch(calibration)
            case 'ZED'
%% ZED 120 mm - ZED RECTIFICATION - Indoor
                switch(environment)
                    case 'Indoor'
                        switch(distance)
                            case 5
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-720-L1-05.png');
                                        IR = imread('INDOOR-ZED-720-R1-05.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [550, 400, 200, 100];
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-1080-L1-05.png');
                                        IR = imread('INDOOR-ZED-1080-R1-05.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [850, 630, 250, 150];
                                end
                            case 10
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-720-L1-10.png');
                                        IR = imread('INDOOR-ZED-720-R1-10.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [580, 350, 70, 50];
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-1080-L1-10.png');
                                        IR = imread('INDOOR-ZED-1080-R1-10.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [875, 550, 100, 50];
                                end
                            case 15
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-720-L1-15.png');
                                        IR = imread('INDOOR-ZED-720-R1-15.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [600, 350, 35, 20];
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-1080-L1-15.png');
                                        IR = imread('INDOOR-ZED-1080-R1-15.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [900, 535, 85, 50];
                                end
                            case 20
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-720-L1-20.png');
                                        IR = imread('INDOOR-ZED-720-R1-20.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [605, 350, 20, 15];
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-1080-L1-20.png');
                                        IR = imread('INDOOR-ZED-1080-R1-20.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [905, 515, 40, 25];
                                end
                            case 25
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-720-L1-25.png');
                                        IR = imread('INDOOR-ZED-720-R1-25.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [608, 348, 18, 12];
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-1080-L1-25.png');
                                        IR = imread('INDOOR-ZED-1080-R1-25.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [905, 510, 30, 20];
                                end
                            case 30
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-720-L1-30.png');
                                        IR = imread('INDOOR-ZED-720-R1-30.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [605, 345, 15, 15];
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-1080-L1-30.png');
                                        IR = imread('INDOOR-ZED-1080-R1-30.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [910, 515, 30, 15];
                                end
                        end
%% ZED 120 mm - ZED RECTIFICATION - Outdoor
                    case 'Outdoor'
                        switch(distance)
                            case 5
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-720-L1-05.png');
                                        IR = imread('OUTDOOR-ZED-720-R1-05.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [600, 400, 80, 80];
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-1080-L1-05.png');
                                        IR = imread('OUTDOOR-ZED-1080-R1-05.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [850, 650, 180, 100];
                                end
                            case 10
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-720-L1-10.png');
                                        IR = imread('OUTDOOR-ZED-720-R1-10.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [615, 350, 35, 50];
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-1080-L1-10.png');
                                        IR = imread('OUTDOOR-ZED-1080-R1-10.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [900, 525, 100, 90];
                                end
                            case 15
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-720-L1-15.png');
                                        IR = imread('OUTDOOR-ZED-720-R1-15.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [620, 355, 35, 20];
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-1080-L1-15.png');
                                        IR = imread('OUTDOOR-ZED-1080-R1-15.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [900, 525, 100, 90];
                                end
                            case 20
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-720-L1-20.png');
                                        IR = imread('OUTDOOR-ZED-720-R1-20.png');
                                        stereo =getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [620, 352, 25, 12];
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-1080-L1-20.png');
                                        IR = imread('OUTDOOR-ZED-1080-R1-20.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [930, 525, 40, 20];
                                end
                            case 25
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-720-L1-25.png');
                                        IR = imread('OUTDOOR-ZED-720-R1-25.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [622, 348, 18, 12];
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-1080-L1-25.png');
                                        IR = imread('OUTDOOR-ZED-1080-R1-25.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [940, 525, 30, 15];
                                end
                            case 30
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-720-L1-30.png');
                                        IR = imread('OUTDOOR-ZED-720-R1-30.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [620, 340, 15, 10];
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-1080-L1-30.png');
                                        IR = imread('OUTDOOR-ZED-1080-R1-30.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [935, 500, 15, 15];
                                end
                        end
                end
%% ZED 120 mm - CUSTOM RECTIFICATION - Indoor
            case 'Custom'
                switch(environment)
                    case 'Indoor'
                        switch(distance)
                            case 5
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-720-L1-UNREC-05.png');
                                        IR = imread('INDOOR-ZED-720-R1-UNREC-05.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [700, 400, 100, 50];
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-1080-L1-UNREC-05.png');
                                        IR = imread('INDOOR-ZED-1080-R1-UNREC-05.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [935, 600, 170, 150];
                                end
                            case 10
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-720-L1-UNREC-10.png');
                                        IR = imread('INDOOR-ZED-720-R1-UNREC-10.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [750, 340, 50, 40];
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-1080-L1-UNREC-10.png');
                                        IR = imread('INDOOR-ZED-1080-R1-UNREC-10.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [950, 550, 100, 100]; 
                                end
                            case 15
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-720-L1-UNREC-15.png');
                                        IR = imread('INDOOR-ZED-720-R1-UNREC-15.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [750, 350, 35, 20];
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-1080-L1-UNREC-15.png');
                                        IR = imread('INDOOR-ZED-1080-R1-UNREC-15.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [975, 500, 150, 50]; 
                                end
                            case 20
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-720-L1-UNREC-20.png');
                                        IR = imread('INDOOR-ZED-720-R1-UNREC-20.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [755, 350, 25, 10]; 
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-1080-L1-UNREC-20.png');
                                        IR = imread('INDOOR-ZED-1080-R1-UNREC-20.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [975, 500, 150, 50];
                                end
                            case 25
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-720-L1-UNREC-25.png');
                                        IR = imread('INDOOR-ZED-720-R1-UNREC-25.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [760, 340, 20, 20]; 
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-1080-L1-UNREC-25.png');
                                        IR = imread('INDOOR-ZED-1080-R1-UNREC-25.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [980, 500, 50, 20];
                                end
                            case 30
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-720-L1-UNREC-30.png');
                                        IR = imread('INDOOR-ZED-720-R1-UNREC-30.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [760, 340, 20, 15];  
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-1080-L1-UNREC-30.png');
                                        IR = imread('INDOOR-ZED-1080-R1-UNREC-30.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [990, 495, 30, 15];
                                end
                        end
%% ZED 120 mm - CUSTOM RECTIFICATION - Outdoor
                    case 'Outdoor'
                        switch(distance)
                            case 5
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-720-L1-UNREC-05.png');
                                        IR = imread('OUTDOOR-ZED-720-R1-UNREC-05.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [735, 415, 100, 50]; 
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-1080-L1-UNREC-05.png');
                                        IR = imread('OUTDOOR-ZED-1080-R1-UNREC-05.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [925, 635, 175, 90];
                                end
                            case 10
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-720-L1-UNREC-10.png');
                                        IR = imread('OUTDOOR-ZED-720-R1-UNREC-10.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [760, 375, 50, 25]; 
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-1080-L1-UNREC-10.png');
                                        IR = imread('OUTDOOR-ZED-1080-R1-UNREC-10.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [1000, 555, 80, 45];
                                end
                            case 15
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-720-L1-UNREC-15.png');
                                        IR = imread('OUTDOOR-ZED-720-R1-UNREC-15.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [775, 355, 30, 20]; 
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-1080-L1-UNREC-15.png');
                                        IR = imread('OUTDOOR-ZED-1080-R1-UNREC-15.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [1010, 520, 50, 45]; 
                                end
                            case 20
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-720-L1-UNREC-20.png');
                                        IR = imread('OUTDOOR-ZED-720-R1-UNREC-20.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [770, 350, 25, 15]; 
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-1080-L1-UNREC-20.png');
                                        IR = imread('OUTDOOR-ZED-1080-R1-UNREC-20.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [1000, 500, 50, 25];  
                                end
                            case 25
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-720-L1-UNREC-25.png');
                                        IR = imread('OUTDOOR-ZED-720-R1-UNREC-25.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [775, 345, 20, 15]; 
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-1080-L1-UNREC-25.png');
                                        IR = imread('OUTDOOR-ZED-1080-R1-UNREC-25.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [1010, 505, 30, 20];
                                end
                            case 30
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-720-L1-UNREC-30.png');
                                        IR = imread('OUTDOOR-ZED-720-R1-UNREC-30.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [770, 335, 15, 15]; 
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-1080-L1-UNREC-30.png');
                                        IR = imread('OUTDOOR-ZED-1080-R1-UNREC-30.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [995, 475, 20, 15]; 
                                end
                        end
                end
        end
%% ZED Mini - 63 mm
    case 'ZED Mini'
        switch(calibration)
            case 'ZED'
%% ZED Mini 63 mm - ZED RECTIFICATION - Indoor
                switch(environment)
                    case 'Indoor'
                        switch(distance)
                            case 5
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-M-720-L1-05.png');
                                        IR = imread('INDOOR-ZED-M-720-R1-05.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [605, 435, 100, 50];
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-M-1080-L1-05.png');
                                        IR = imread('INDOOR-ZED-M-1080-R1-05.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [890, 680, 150, 100];
                                end
                            case 10
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-M-720-L1-10.png');
                                        IR = imread('INDOOR-ZED-M-720-R1-10.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [610, 410, 40, 30];
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-M-1080-L1-10.png');
                                        IR = imread('INDOOR-ZED-M-1080-R1-10.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [900, 610, 80, 70];
                                end
                            case 15
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-M-720-L1-15.png');
                                        IR = imread('INDOOR-ZED-M-720-R1-15.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [620, 390, 25, 20];
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-M-1080-L1-15.png');
                                        IR = imread('INDOOR-ZED-M-1080-R1-15.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [900, 610, 80, 70];
                                end
                            case 20
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-M-720-L1-20.png');
                                        IR = imread('INDOOR-ZED-M-720-R1-20.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [625, 390, 25, 10];
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-M-1080-L1-20.png');
                                        IR = imread('INDOOR-ZED-M-1080-R1-20.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [925, 610, 30, 15];
                                end
                            case 25
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-M-720-L1-25.png');
                                        IR = imread('INDOOR-ZED-M-720-R1-25.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [625, 385, 17, 10];
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-M-1080-L1-25.png');
                                        IR = imread('INDOOR-ZED-M-1080-R1-25.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [925, 590, 25, 15];
                                end
                            case 30
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-M-720-L1-30.png');
                                        IR = imread('INDOOR-ZED-M-720-R1-30.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [630, 380, 10, 8];
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-M-1080-L1-30.png');
                                        IR = imread('INDOOR-ZED-M-1080-R1-30.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [930, 570, 25, 20];
                                end
                        end
%% ZED Mini 63 mm - ZED RECTIFICATION - Outdoor
                    case 'Outdoor'
                        switch(distance)
                            case 5
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-M-720-L1-05.png');
                                        IR = imread('OUTDOOR-ZED-M-720-R1-05.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [615, 480, 70, 50];
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-M-1080-L1-05.png');
                                        IR = imread('OUTDOOR-ZED-M-1080-R1-05.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [915, 800, 100, 100];
                                end
                            case 10
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-M-720-L1-10.png');
                                        IR = imread('OUTDOOR-ZED-M-720-R1-10.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [640, 435, 40, 30];
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-M-1080-L1-10.png');
                                        IR = imread('OUTDOOR-ZED-M-1080-R1-10.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [950, 700, 70, 70];
                                end
                            case 15
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('ZED-M-720-L1-15.png');
                                        IR = imread('ZED-M-720-R1-15.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [650, 403, 20, 15];
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-M-1080-L1-15.png');
                                        IR = imread('OUTDOOR-ZED-M-1080-R1-15.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [975, 625, 30, 20];
                                end
                            case 20
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-M-720-L1-20.png');
                                        IR = imread('OUTDOOR-ZED-M-720-R1-20.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [650, 400, 15, 15];
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-M-1080-L1-20.png');
                                        IR = imread('OUTDOOR-ZED-M-1080-R1-20.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [975, 625, 30, 20];
                                end
                            case 25
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-M-720-L1-25.png');
                                        IR = imread('OUTDOOR-ZED-M-720-R1-25.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [650, 400, 15, 15];
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-M-1080-L1-25.png');
                                        IR = imread('OUTDOOR-ZED-M-1080-R1-25.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [975, 625, 25, 15];
                                end
                            case 30
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-M-720-L1-30.png');
                                        IR = imread('OUTDOOR-ZED-M-720-R1-30.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [645, 400, 10, 10];
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-M-1080-L1-30.png');
                                        IR = imread('OUTDOOR-ZED-M-1080-R1-30.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [970, 625, 20, 15];
                                end
                        end
                end
%% ZED Mini 63 mm - CUSTOM RECTIFICATION - Indoor
            case 'Custom'
                switch(environment)
                    case 'Indoor'
                        switch(distance)
                            case 5
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-M-720-L1-UNREC-05.png');
                                        IR = imread('INDOOR-ZED-M-720-R1-UNREC-05.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [640, 445, 75, 40]; 
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-M-1080-L1-UNREC-05.png');
                                        IR = imread('INDOOR-ZED-M-1080-R1-UNREC-05.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [965, 680, 150, 100]; 
                                end
                            case 10
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-M-720-L1-UNREC-10.png');
                                        IR = imread('INDOOR-ZED-M-720-R1-UNREC-10.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [645, 415, 45, 30]; 
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-M-1080-L1-UNREC-10.png');
                                        IR = imread('INDOOR-ZED-M-1080-R1-UNREC-10.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [1000, 650, 65, 50];  
                                end
                            case 15
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-M-720-L1-UNREC-15.png');
                                        IR = imread('INDOOR-ZED-M-720-R1-UNREC-15.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [665, 405, 20, 15]; 
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-M-1080-L1-UNREC-15.png');
                                        IR = imread('INDOOR-ZED-M-1080-R1-UNREC-15.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [1000, 615, 60, 50]; 
                                end
                            case 20
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-M-720-L1-UNREC-20.png');
                                        IR = imread('INDOOR-ZED-M-720-R1-UNREC-20.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [655, 395, 20, 15];
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-M-1080-L1-UNREC-20.png');
                                        IR = imread('INDOOR-ZED-M-1080-R1-UNREC-20.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [1010, 600, 50, 30];  
                                end
                            case 25
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-M-720-L1-UNREC-25.png');
                                        IR = imread('INDOOR-ZED-M-720-R1-UNREC-25.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [660, 390, 15, 12]; 
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-M-1080-L1-UNREC-25.png');
                                        IR = imread('INDOOR-ZED-M-1080-R1-UNREC-25.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [1005, 585, 35, 20];
                                end
                            case 30
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('INDOOR-ZED-M-720-L1-UNREC-30.png');
                                        IR = imread('INDOOR-ZED-M-720-R1-UNREC-30.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [660, 380, 15, 15]; 
                                    case 'FHD'
                                        IL = imread('INDOOR-ZED-M-1080-L1-UNREC-30.png');
                                        IR = imread('INDOOR-ZED-M-1080-R1-UNREC-30.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [1015, 575, 20, 20]; 
                                end
                        end
%% ZED Mini 63 mm - CUSTOM RECTIFICATION - Outdoor
                    case 'Outdoor'
                        switch(distance)
                            case 5
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-M-720-L1-UNREC-05.png');
                                        IR = imread('OUTDOOR-ZED-M-720-R1-UNREC-05.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [645, 495, 90, 50];  
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-M-1080-L1-UNREC-05.png');
                                        IR = imread('OUTDOOR-ZED-M-1080-R1-UNREC-05.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [985, 790, 150, 80]; 
                                end
                            case 10
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-M-720-L1-UNREC-10.png');
                                        IR = imread('OUTDOOR-ZED-M-720-R1-UNREC-10.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [670, 445, 50, 30];
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-M-1080-L1-UNREC-10.png');
                                        IR = imread('OUTDOOR-ZED-M-1080-R1-UNREC-10.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [1045, 675, 60, 125];
                                end
                            case 15
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-M-720-L1-UNREC-15.png');
                                        IR = imread('OUTDOOR-ZED-M-720-R1-UNREC-15.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [675, 405, 35, 25]; 
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-M-1080-L1-UNREC-15.png');
                                        IR = imread('OUTDOOR-ZED-M-1080-R1-UNREC-15.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [1050, 630, 50, 30];
                                end
                            case 20
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-M-720-L1-UNREC-20.png');
                                        IR = imread('OUTDOOR-ZED-M-720-R1-UNREC-20.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [680, 405, 20, 15]; 
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-M-1080-L1-UNREC-20.png');
                                        IR = imread('OUTDOOR-ZED-M-1080-R1-UNREC-20.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [1050, 625, 50, 30];
                                end
                            case 25
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-M-720-L1-UNREC-25.png');
                                        IR = imread('OUTDOOR-ZED-M-720-R1-UNREC-25.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [680, 410, 20, 10];  
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-M-1080-L1-UNREC-25.png');
                                        IR = imread('OUTDOOR-ZED-M-1080-R1-UNREC-25.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [1060, 625, 25, 15]; 
                                end
                            case 30
                                switch(resolution)
                                    case 'HD'
                                        IL = imread('OUTDOOR-ZED-M-720-L1-UNREC-30.png');
                                        IR = imread('OUTDOOR-ZED-M-720-R1-UNREC-30.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [675, 405, 15, 10]; 
                                    case 'FHD'
                                        IL = imread('OUTDOOR-ZED-M-1080-L1-UNREC-30.png');
                                        IR = imread('OUTDOOR-ZED-M-1080-R1-UNREC-30.png');
                                        stereo = getStereoParameters(model, calibration, resolution);
                                        stereo.ROI = [1060, 620, 20, 15];  
                                end
                        end
                end
        end
end

end

% End of Function ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~