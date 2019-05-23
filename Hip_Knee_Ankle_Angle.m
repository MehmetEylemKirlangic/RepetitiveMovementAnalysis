% The function Knee_Ankle_Angle loads the Knee_Ankle_Angle-ascii-file,
% performs the pre-prossing steps (interpolation) and  returns
% the data series (time and signal values) to be
% anaylized and plotted in the Gait analysis GUI

% Program :  Repetitive Movement Analysis
% Version :  1.2
% Function:  Knee_Ankle_Angle
% Authors  :  Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic


function [Time_Knee_Ankle_Angle,sg_Knee_Ankle_Angle]=Knee_Ankle_Angle(varargin)

Patient_Knee_Ankle_Angle=varargin{1};

H=importdata( Patient_Knee_Ankle_Angle); % Patient

Time_Knee_Ankle_Angle=H.data(:,1);

sig=H.data(:,2);

sig= interp1(Time_Knee_Ankle_Angle,sig,Time_Knee_Ankle_Angle,'cubic'); 

sg_Knee_Ankle_Angle=sig;

sg_std=std(sg_Knee_Ankle_Angle);    % Standard deviation
