% The function steplength_analyse gets the loaded data of steplength after
% the pre-processing stage, analyzes the gait (steps) of the subject and returns 
% the calculated parameters: 
%                      'Gait  cadence',
%                      'Gait  mean Stride in m',
%                      'Gait  std. Stride',
%                      'Gait  mean Step Left in m',
%                      'Gait  mean Step Right in m',
%                      'Gait  std. Step Left',
%                      'Gait  std. Step Right',and
%                      'Gait  meter per minute'
%  back. The accurate time of the measurment is also calculated and given
%  back to be shown in the gait analysis GUI.


% Program :  Repetitive Movement Analysis
% Version :  1.2
% Function:  steplength_analyse
% Authors  :  Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic



function [cadence, Stride_mean,Stride_std, average_maxima,...
    average_minima,std_maxima,std_minima,m_min]=steplength_analyse(varargin)

Time_steplength=varargin{1};
sg_steplength=varargin{2};

sg_std=std(sg_steplength);

s=diff(sg_steplength);
s1=s(2:end);
s2=s(1:end-1);
imx1=find(s1.*s2<0 & s1-s2<0)+1;  % indices of maxima in the signal
imx2=find(s1.*s2<0 & s1-s2>0)+1;  % indices of minima in the signal

maxima=sg_steplength(imx1); 
maxima_ind=maxima>0.3*sg_std;
maxima_in_curve=nonzeros(maxima.*maxima_ind);

minima=sg_steplength(imx2);
minima_ind=minima<-0.3*sg_std;
minima_in_curve=nonzeros(minima.*minima_ind);

%% Calculating the Time and cadence
min_first=minima_in_curve(1);
min_last=minima_in_curve(end);
min_first_ind=find(sg_steplength==min_first);
min_last_ind=find(sg_steplength==min_last);
min_first_time=Time_steplength(min_first_ind);
min_last_time=Time_steplength(min_last_ind);

max_first=maxima_in_curve(1);
max_last=maxima_in_curve(end);
max_first_ind=find(sg_steplength==max_first);
max_last_ind=find(sg_steplength==max_last);
max_first_time=Time_steplength(max_first_ind);
max_last_time=Time_steplength(max_last_ind);

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

cadence=(length(find(nonzeros(diff(sign(sg_steplength))))))*(60/measure_Time);


%% Calculating the Stride Length

L_maxima=length(maxima_in_curve);
L_minima=length(minima_in_curve);

L_differenz=L_maxima-L_minima;

if isequal(sign(L_differenz),-1)
    minima_in_curve=minima_in_curve(1:L_maxima);
end
if isequal(sign(L_differenz),1)
    maxima_in_curve=maxima_in_curve(1:L_minima);
end

average_maxima=abs(mean(maxima_in_curve));   
average_minima=abs(mean(minima_in_curve));  

std_maxima=std(maxima_in_curve);
std_minima=std(minima_in_curve);

Stride_length=round((average_maxima-average_minima)*100);

Stride_mean=mean(maxima_in_curve-minima_in_curve);   
Stride_std=std(maxima_in_curve-minima_in_curve);

diff_maxima=diff(maxima_in_curve);
diff_minima=diff(minima_in_curve);

m_min=(Stride_mean/2)*cadence;

