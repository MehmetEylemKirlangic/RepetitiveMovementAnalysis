% The function knee_angle loads the knee_angle-ascii-file,
% performs the pre-prossing steps (interpolation) and  returns
% the data series (time and signal values) to be
% anaylized and plotted in the Gait analysis GUI

% Program :  Repetitive Movement Analysis
% Version :  1.2
% Function:  knee_angle
% Authors  :  Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic


function [Time_Knee_Angle,sg_Knee_Angle]=knee_angle(varargin)

Patient_Knee_Angle=varargin{1};

H=importdata(Patient_Knee_Angle); % Patient

[ok]=file_control(H);

if ok==1;

Time_Knee_Angle=H.data(:,1);

sg=H.data(:,2);

% [Time_Knee_Angle,sig]=length_control(Time,signal);

sig= interp1(Time_Knee_Angle,sg,Time_Knee_Angle,'cubic'); 

sg_Knee_Angle=sig;%-mean(sig);

sg_std=std(sg_Knee_Angle);    % Standard deviation

else
    Time_Knee_Angle='';
    sg_Knee_Angle='';
    return;
end  
