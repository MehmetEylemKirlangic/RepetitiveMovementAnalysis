% The function heel_tapping_function loads the heel_tapping
% -ascii-file, performs the pre-prossing steps (interpolation, baseline
% correction and the band pass filter (cutoff frequencies are 0.5-8Hz)
% and  returns the data series (time and signal before and after the 
% band pass filter) to be anaylized and plotted in the heel_tapping GUI.

% Program :  Repetitive Movement Analysis
% Version :  1.2
% Function:  heel_tapping_function
% Authors  : Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic


function [Time_Hand_Tapping,sg_Hand_Tapping,sg_Hand_Tapping_HPF]=heel_tapping_function(varargin)

comp=varargin{1};

H=importdata(comp); % Patient

[ok]=file_control(H);

if ok==1;
    
Time_Hand_Tapping=H.data(:,1);
sig=H.data(:,2);

sig= interp1(Time_Hand_Tapping,sig,Time_Hand_Tapping,'cubic');  % Interpolation of NaN points

% windowSize = 5;
% sig1=filter(ones(1,windowSize)/windowSize,1,sig);      % running average

sg_Hand_Tapping=sig-mean(sig);              % Baseline

fs=50;		                          % Sampling rate
filterOrder=3;		                  % Order of filter
cutOffFreq=[0.5 8];                   % Cutoff frequency
[b, a]=butter(filterOrder, cutOffFreq/(fs/2));
sig1=filter(b,a,sig);

sg_Hand_Tapping_HPF=sig1;    

else
    Time_Hand_Tapping='';
    sg_Hand_Tapping='';
    sg_Hand_Tapping_HPF='';
    return
end  
 

