% The function steplength_function loads the steplength-ascii-file
% (gait 1 or 2), performs the pre-prossing steps (interpolation, moving 
% average and baseline correction) and  returns the data series (time
% and signal values) to be anaylized and plotted in the Gait analysis 
% GUI.


% Program :  Repetitive Movement Analysis
% Version :  1.2
% Function:  steplength_function
% Authors  :  Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic



function [Time_steplength,sg_steplength]=steplength_function(varargin)

Patient_steplength=varargin{1};

H=importdata(Patient_steplength); % Patient

[ok]=file_control(H);

if ok==1;

Time_steplength=H.data(:,1);
sig=H.data(:,2);

sig= interp1(Time_steplength,sig,Time_steplength,'cubic');  % Interpolation of NaN points

windowSize = 3;
sig1=filter(ones(1,windowSize)/windowSize,1,sig);      % running average

sg_steplength=sig1-mean(sig1);  % Baseline
sg_std=std(sg_steplength);    % Standard deviation

% figure
% plot(Time_steplength,(sig-mean(sig)))
% plot(Time_steplength,sg_steplength,'r')
% title('Gait right postOP2')
% xlabel('Time [sec]')
% ylabel('Amplitude [m]')

else
    Time_steplength='';
    sg_steplength='';
    return
end  
