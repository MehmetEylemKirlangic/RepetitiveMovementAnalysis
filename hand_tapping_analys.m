% The function hand_tapping_analys gets the loaded data of hand_tapping after
% the pre-processing stage, analyzes the tapping process of the subject and returns 
% the calculated parameters: 
%                      'Mean maxima Tappingrate hand  in Hz',
%                      'Mean minima Tappingrate hand  in Hz',
%                      'Mean maxima Amplitude hand  in cm ',
%                      'Mean minima Amplitude hand  in cm ',
%                      'std. maxima Tappingrate hand ',
%                      'std. minima Tappingrate hand ',
%                      'Mean max and min Tappingrate hand in Hz',
%                      'std. max and min Tappingrate hand ',
%                      'Duration in sec' 
%  back. The accurate time of the measurment is also calculated and given
%  back to be shown in the hand analysis GUI.

% Program :  Repetitive Movement Analysis
% Version :  1.2
% Function:  hand_tapping_analys
% Authors  : Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic

function [Tippingrate_max,Tippingrate_min,sg_mean_max,sg_mean_min,sg_std_max,sg_std_min,...
    Time_ind1,Time_ind2,mean_max_min,std_min_max,measure_Time,Time_plot1,Time_plot2]=hand_tapping_analys(varargin)

comp=varargin{2};  % comp is the signal

s=diff(comp);            
s1=s(2:end);
s2=s(1:end-1);
imx1=find(s1.*s2<0 & s1-s2<0)+1;  % indices of maxima in the signal 
imx2=find(s1.*s2<0 & s1-s2>0)+1;  % indices of minima in the signal

% comp_1= comp(imx1)> 0.1*std(comp);  % Threshhold for maxima
% comp_2=nonzeros(imx1.*comp_1);

Fs=50;                            % Sampling rate 50 Hz
Max_Paced_F=Fs/8;                 % 8 Hz max. Paced-Tapping-frequency. 125 msec

%% the Maxima
fd1=diff(imx1)>=Max_Paced_F;            
fd1=[1; fd1];
imx1d1=nonzeros(imx1.*fd1);         % Maxima not closer than 8 Hz

sg_imx1d1=comp(imx1d1);             % Maxima wider than 8Hz.

Time=varargin{1};

Time_ind1= 1./(diff(imx1d1./Fs));   % or Fs./diff(imx1d1); % Frequency of Tapping
Time_plot1=imx1d1./Fs;

sg_mean_max=mean(sg_imx1d1)*100;        % average maximaum
% sg_std_max=std(sg_imx1d1)*100;          % Standard deviation maximum


%% the Minima
fd2=diff(imx2)>=Max_Paced_F;            
fd2=[1; fd2];
imx2d2=nonzeros(imx2.*fd2);         % Minima not closer than 8 Hz

sg_imx2d2=comp(imx2d2);             % Minima wider than 8Hz.

Time=varargin{1};

Time_ind2= 1./(diff(imx2d2./Fs));   % or Fs./diff(imx2d2);  % Frequency of Tapping
Time_plot2=imx2d2./Fs;

sg_mean_min=mean(abs(sg_imx2d2))*100;      % average minimum
% sg_std_min=std((sg_imx2d2))*100;          % Standard deviation minimum

% L_max=length(imx1d1)
% L_min=length(imx2d2)

%% Calculating the Time 
max_first=sg_imx1d1(1);
max_last=sg_imx1d1(end);
max_first_ind=find(comp==max_first);
max_last_ind=find(comp==max_last);
max_first_time=Time(max_first_ind);
max_last_time=Time(max_last_ind);

min_first=sg_imx2d2(1);
min_last=sg_imx2d2(end);
min_first_ind=find(comp==min_first);
min_last_ind=find(comp==min_last);
min_first_time=Time(min_first_ind);
min_last_time=Time(min_last_ind);

if min_first_time > max_first_time
    start_time=max_first_time;
else 
    start_time=min_first_time;
end

if min_last_time > max_last_time
    end_time=min_last_time;
else 
    end_time=max_last_time;
end

measure_Time=end_time-start_time;     
%%
Tippingrate_max=mean(Time_ind1); %length(sg_imx1d1)/measure_Time;
Tippingrate_min=mean(Time_ind2); %length(sg_imx2d2)/measure_Time;
sg_std_max=std(Time_ind1);       % standard diviation of the Tapping rate max
sg_std_min=std(Time_ind2); 


a=Time_ind1'; b=Time_ind2'; c=[a b];
mean_max_min=mean(c);
std_min_max=std(c);

Tippingrate_min_max=(length(sg_imx1d1) + length(sg_imx2d2))/(measure_Time*2);

