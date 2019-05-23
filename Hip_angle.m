% The function Hip_angle loads the Hip_angle-ascii-file,
% performs the pre-prossing steps (interpolation) and  returns
% the data series (time and signal values) to be
% anaylized and plotted in the Gait analysis GUI

% Program :  Repetitive Movement Analysis
% Version :  1.2
% Function:  Hip_angle
% Authors  : Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic

function [Time_Hip_Knee_Angle,sg_Hip_Knee_Angle]=Hip_angle(varargin)

Patient_Hip_Knee_Angle=varargin{1};


H=importdata(Patient_Hip_Knee_Angle); % Patient

[ok]=file_control(H);

if ok==1;

Time_Hip_Knee_Angle=H.data(:,1);

sig=H.data(:,2);

sig= interp1(Time_Hip_Knee_Angle,sig,Time_Hip_Knee_Angle,'cubic'); 
sg_Hip_Knee_Angle=sig;

sg_std=std(sg_Hip_Knee_Angle);    % Standard deviation

else
    Time_Hip_Knee_Angle='';
    sg_Hip_Knee_Angle='';
    return
end  


%plot(sg_Hip_Knee_Angle)