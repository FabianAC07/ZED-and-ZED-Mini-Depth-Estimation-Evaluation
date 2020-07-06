%% getInputFromUser ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%{
    This function request inputs from the user to perform the study:

    * I/O       * Objects       * Description   
    Inputs:     - None          - N/A

    Outputs:    - baseline      - 120 mm or 63 mm 
                - calibration   - ZED or Custom
                - environment   - Indoors os Outdoors
                - depth         - 5, 10, 15, 20, 25, 30 meters
                - resolution    - HD (720p) or FHD (1080p)
                - features      - Harris, SURF
                - debug         - Debuging 

    Helper Function: getInput

    Recursive function which checks that the inputs are set correctly.

    Created by: Fabian Aguilar.
    Date:       07/05/19
    Edition:    0
%}

%% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function [model, calibration, environment, depth, resolution, ...
    features, debug] = getInputFromUser()

[model, calibration, environment, depth, resolution, ...
    features, debug] = getInput;

end

% End of Function ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%% Helper Function: getInput ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [model, calibration, environment, depth, resolution, ...
    features, debug] = getInput

% Set up the dialog box
% Title
dlgtitle = 'Inputs for Depth Study';

% Promts
promt = {'Stereo Camera - Options ZED or ZED Mini', ...
         'Calibration - Options: ZED or Custom', ...
         'Environment - Options: Indoor or Outdoor', ...
         'Depth - Options: 5, 10, 15, 20, 25 or 30 meters', ...
         'Resolution - Options: HD (720p) or FHD (1080p)', ...
         'Features - Options: Harris or SURF', ...
         'Debug - Options: Yes or No'};
     
% Default inputs
definput = {'ZED Mini', 'Custom', 'Outdoor', '25', 'HD', 'Harris', 'No'};

% Dimensions
dims = [1 50];

% Output dialog box
answer = inputdlg(promt, dlgtitle, dims, definput);

% Assess inputs:
model = answer{1};
if ~strcmp(model, 'ZED') && ~strcmp(model, 'ZED Mini')
    %show error and restart prompt
    uiwait(msgbox('The value you entered for baseline was not correct.',...
                  'Error!','error'))
    [model, calibration, environment, depth, resolution, ...
    features, debug] = getInput;
end

calibration = answer{2};
if ~strcmp(calibration, 'ZED') && ~strcmp(calibration, 'Custom')
    %show error and restart prompt
    uiwait(msgbox('The value you entered for calibration was not correct.',...
                  'Error!','error'))
    [model, calibration, environment, depth, resolution, ...
    features, debug] = getInput;
end

environment = answer{3};
if ~strcmp(environment, 'Indoor') && strcmp(model, 'Outdoor')
    %show error and restart prompt
    uiwait(msgbox('The value you entered for environment was not correct.',...
                  'Error!','error'))
    [model, calibration, environment, depth, resolution, ...
    features, debug] = getInput;
end

depth = str2double(answer{4});
if depth ~= 5 && depth ~= 10 && depth ~= 15 && depth ~= 20 && ...
        depth ~= 25 && depth ~= 30
    %show error and restart prompt
    uiwait(msgbox('The value you entered for depth was not correct.',...
                  'Error!','error'))
    [model, calibration, environment, depth, resolution, ...
    features, debug] = getInput;
end

resolution = answer{5};
if ~strcmp(resolution, 'HD') && ~strcmp(resolution, 'FHD')
    %show error and restart prompt
    uiwait(msgbox('The value you entered for resolution was not correct.',...
                  'Error!','error'))
    [model, calibration, environment, depth, resolution, ...
    features, debug] = getInput;
end

features = answer{6};
if ~strcmp(features, 'Harris') && ~strcmp(features, 'SURF')
    %show error and restart prompt
    uiwait(msgbox('The value you entered for features was not correct.',...
                  'Error!','error'))
    [model, calibration, environment, depth, resolution, ...
    features, debug] = getInput;
end

debug = answer{7};
if ~strcmp(debug, 'Yes') && ~strcmp(debug, 'No')
    %show error and restart prompt
    uiwait(msgbox('The value you entered for debug was not correct.',...
                  'Error!','error'))
    [model, calibration, environment, depth, resolution, ...
    features, debug] = getInput;
end

if strcmp(debug, 'Yes')
    debug = true;
else
    debug = false;
end

end