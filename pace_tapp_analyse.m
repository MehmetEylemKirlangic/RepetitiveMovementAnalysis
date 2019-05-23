% Cued Tapping is the new naming on the menu. 
% The function pace_tapp_analyse gets the loaded data of paced_tapping after
% the pre-processing stage, analyzes the tapping process of the subject and returns 
% the calculated parameters: 
%                      'RMS',
%                      'Error falling','Error rising',
%                      'Max. error falling in Hz',
%                      'Max. error rising in Hz',
%                      'Max. error falling by the frequency: in Hz',
%                      'Max. error rising by the frequency: in Hz',
%                      'Duration in sec'
%  back. The accurate time of the measurment is also calculated and given
%  back to be shown in the Cued Tapping  GUI.

% Program :  Repetitive Movement Analysis
% Version :  1.2
% Function:  pace_tapp_analyse
% Author  :  Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic




function [Ton_Phase,Tapp_Phase,RMS,m_falling,m_reising,max_falling,max_reising,freq_falling,freq_reising,T_diff,F_]=pace_tapp_analyse(varargin)

imx2d2=varargin{1};  % indizes of times of ton
imx2d3=varargin{2};  % indizes of times of tapping 
freq_ton=varargin{3};      % frequency of ton 21 values
freq_Patient=varargin{4};  % frequency of tapping 21 values

Fs=50;               % sampling rate

Ton_Time=imx2d2/Fs ;         
Ton_Phase=diff(imx2d2)/Fs;     
Ton_Freq=Fs./diff(imx2d2);

Tapp_Time=imx2d3./Fs;
% Tapp_Time=Tapp_Time(2:2:end); % to select either maxima or minima
Tapp_Phase=diff(imx2d3)/Fs;
Tapp_Freq=Fs./diff(imx2d3);

length_Ton_Time=length(Ton_Time);
length_Tapp_Time=length(Tapp_Time);

Ld=0;
T_diff=[];
F_=[];
for i=1:numel(Ton_Time)-1
for j=1:numel(Tapp_Time)
    
    a(i,j)=Tapp_Time(j)>=Ton_Time(i) & Tapp_Time(j)<Ton_Time(i+1); 
    
end
F=Tapp_Time(a(i,:)==1);   % times of tapping
F_=cat(1,F_, F);          % times_vector of tapping for plot
D=F-Ton_Time(i);          % differenz between ton_time and tapping_time
Ld=Ld+numel(D);           % controll the length of differenz vector, how many tappings between tow tons
T_diff=cat(1,T_diff, D);  % collecting the time differenzes in one vector for plot
end

length_T_diff=length(T_diff);

%% Calculating the Parameters 
format short g

a=1:0.5:6; b=5.5:-0.5:1;
c=cat(2,a,b).*6; %% factor-vector for Normal
Frequenz_differenz=zeros(1,numel(freq_ton));
for k=1:numel(freq_ton)
Frequenz_differenz(k)=(freq_ton(k)-freq_Patient(k));
end
for i=1:numel(freq_ton)
f(i)=((freq_Patient(i)-freq_ton(i)).^2); %./c(i);
end

RMS=sqrt(sum(f)/21);

mIn=Frequenz_differenz>0;   %%% falling

b=any(mIn);
if ~b   % if all values are zeros
    freq_falling=0;
    m_falling=0;
    max_falling=0;
    return
   
else
    
Frequenz_differenz_mIn=Frequenz_differenz(mIn);
m_falling=(sum(abs(Frequenz_differenz_mIn))/21);

max_falling=max(Frequenz_differenz_mIn);
max_falling_ind=find(Frequenz_differenz==max_falling);
freq_falling=c(max_falling_ind)/6;
end

mAx=Frequenz_differenz<0;  %%% rising

a=any(mAx);
if ~a   % if all values are zeros
    freq_reising=0;
    m_reising=0;
    max_reising=0;
    return
   
else
    
Frequenz_differenz_mAx=Frequenz_differenz(mAx);
m_reising=(sum(abs(Frequenz_differenz_mAx))/21);

max_reising=min(Frequenz_differenz_mAx);
max_reising_ind=find(Frequenz_differenz==max_reising);
freq_reising=c(max_reising_ind)/6;

end

