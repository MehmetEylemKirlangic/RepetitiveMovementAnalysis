% The function audio_tapp_freq analyzes the external audio signal
% , which is used in paced tapping, after the pre-processing steps
% ( resampling and the moving average. It determins the frequency 
% of the tones in the different sequences and gives back a plot 
% vector of these frequencies to be shown in the paced tapping 
% analysis windows for comparision with the tapping of the subject.

% Program :  Repetitive Movement Analysis 
% Version :  1.2
% Function:  audio_tapp_freq
% Authors  : Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic

function [imx2d2,T_plot,freq_ton_plot,freq_ton, audio_plot]=audio_tapp_freq(varargin)

%% importing the original Audio signal
%             M=importdata( 'originalaudio.txt');
% 
%             T=M.data(:,1);       
%             S=M.data(:,2); 
%             S=abs(S);

%             T1=resample(T,1,640);
%             S1=resample(S,1,640);

%             AudioSignal=[T1 S1];

%% loading and preparing audio signal

M=load('AudioSignal');
T1=M.AudioSignal(:,1);
S1=M.AudioSignal(:,2);

%running average -> Tiefpass-filter.
for i=2:length(S1)-1
    y(i)=(S1(i-1)+S1(i)+S1(i+1))/3;  
end
y=y';

Fs=50;                      % Sampling rate

% Determining the maxima
sg_std=std(y);              % standard diviation
s=diff(y);
s1=s(2:end);
s2=s(1:end-1);
imx2=find(s1.*s2<0 & s1-s2<0)+1;   % indizes of maxima in the signal.

d2=y(imx2)>2*sg_std;        % threshold for maxima.
imx2d2=nonzeros(imx2.*d2);  % indizes maxima lower than the threshold.
  

%% Determining the frequency

RealFreqTon=Fs./diff(imx2d2);  % Frequency of tons
freq_ton_plot=y;

% Preparing frequency vector for plot
for i=1:21;    
Intervall_start(i)=50+300*(i-1);    
Intervall_end(i)=50+300*i;

freq_ton(i)=length(nonzeros(imx2d2<=Intervall_end(i) & imx2d2>Intervall_start(i) )); % how many maxima in each intervall, 21 values
freq_ton_plot(Intervall_start(i):Intervall_end(i))=freq_ton(i);
end
freq_ton_plot(1:49)=0;
freq_ton_plot(6351:end)=0;

%% Determing the time 

Time_Ton=imx2d2/Fs;            % time of Ton in sec 
Time_diff=diff(imx2d2)/Fs;     % time differenz between Tons in  sec

T_plot=T1(1:end-1);            % Time vector for plot.

%% to plot the tones  as lines in the axes
audio_plot=ones(1,length(S1)).*(-10);
audio_plot(Intervall_start)=10;
audio_plot=audio_plot;


