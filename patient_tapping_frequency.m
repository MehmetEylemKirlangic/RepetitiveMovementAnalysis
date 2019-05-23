% The function patient_tapping_frequency analyzes the paced 
% tapping process of the subject after the pre-processing steps.
% It determins the frequency of paced tapping in the different sequences 
% and gives back a plot vector of these frequencies to be shown in
% the paced tapping analysis window for comparision with the tone 
% sequences. 

% Program :  Repetitive Movement Analysis
% Version :  1.2
% Function:  patient_tapping_frequency
% Authors  :  Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic 

function [freq_patie,freq_patie_plot,maxima_ind]=patient_tapping_frequency(varargin)

sig=varargin{1};

sg=sig-mean(sig);
sg_std=std(sg);

%% determining the maxima & minima 

s=diff(sg);
s1=s(2:end);
s2=s(1:end-1);
imx1=find(s1.*s2<0 & s1-s2<0)+1;  % indices of maxima in the signal
imx2=find(s1.*s2<0 & s1-s2>0)+1;  % indices of minima in the signal


%% 8 Hz max. Paced-Tapping-frequency. 125 msec
Fs=50; % Sampling rate 
Max_Paced_F=Fs/8; 

fd1=diff(imx1)>=Max_Paced_F;            
fd1=cat(1,1, fd1);
imx1d1=nonzeros(imx1.*fd1); 
sg_imx1d1=sg(imx1); 

fd2=diff(imx2)>=Max_Paced_F;            
fd2=cat(1,1,fd2);
imx2d2=nonzeros(imx2.*fd2); 
sg_imx2d2=sg(imx2); 

%% Condition: maximum between tow Minima and vice versa

minima=[];
for j=1:numel(imx1d1)-1     %maxima
    for i=1:numel(imx2d2)   %minima
        
        if imx2d2(i)>imx1d1(j) && imx2d2(i)<imx1d1(j+1) 
            minima=[minima,imx2d2(i)];
            break;
            
        end
                        
    end
end
minima=minima';

maxima=[];
for k=1:numel(imx2d2)-1     
    for n=numel(imx1d1):-1:1  
        
        if imx1d1(n)>imx2d2(k) && imx1d1(n)<imx2d2(k+1) 
            maxima=[maxima,imx1d1(n)];
            break;
            
        end
                        
    end
end
maxima=maxima';
maxima_ind=maxima;

%% Condition: Threshhold for Amplitude

MaxMin=cat(1,maxima,minima);
MaxMin=sort(MaxMin);
sig=sg(MaxMin)+10;  %% all Values should be positive

diff_sig=abs(diff(sig));

fd5=diff_sig>0.005; %% threshhold to avoid finding maxima and minima while waiting for the ton
fd5=cat(1,fd5,0);

left_MaxMin=nonzeros(fd5.*MaxMin); %% last found maxima and minima, which will determine the frequency


%% Determining the Frequency and preparing plot vector.
freq_patie_plot=sg;
for i=1:21;    
Intervall_start(i)=50+300*(i-1);    
Intervall_end(i)=50+300*i;

freq_patie(i)=length(nonzeros(left_MaxMin<=Intervall_end(i) & left_MaxMin>Intervall_start(i) )); % how many maxima in each intervall, 21 value
freq_patie_plot(Intervall_start(i):Intervall_end(i))=freq_patie(i);  % plot vektor
end
freq_patie_plot(1:49)=0;
freq_patie_plot(6351:end)=0;
freq_patie_plot=freq_patie_plot;
freq_patie=freq_patie./2;  %% divided by 2 because both maxima and minima will be recognized














