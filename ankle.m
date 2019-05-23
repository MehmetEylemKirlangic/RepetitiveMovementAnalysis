% The function ankle loads the ankle-ascii-file,
% performs the pre-prossing steps (interpolation) and  returns
% the data series (time and y1 values) to be plotted
% in the Gait analysis GUI

% Program :  Repetitive Movement Analysis
% Version :  1.2
% Function:  ankle
% Authors  :  Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic

function [Time_Ankle,X1,Y1]=ankle(varargin)

Patient_Ankle=varargin{1};

H=importdata(Patient_Ankle); % Patient

[ok]=file_control(H);

if ok==1
 
% cond=size(H.data,2);   
% if ~isequal(cond,3)
%    Time_Ankle='';
%    X1='';
%    Y1='';
%     return;
% end

Time_Ankle=H.data(:,1);

X=H.data(:,2);
X1= interp1(Time_Ankle,X,Time_Ankle,'cubic'); 

Y=H.data(:,3);
    
Y1=interp1(Time_Ankle,Y,Time_Ankle,'cubic'); 


% sg_Ankle=sig-mean(sig);
% 
% diff_sg_Ankle=diff(sg_Ankle);
% diff_sg_Ankle=[0;diff_sg_Ankle];
% 
% sg_std=std(sg_Ankle);    % Standard deviation

else
   Time_Ankle='';
   X1='';
   Y1='';
   return;
end