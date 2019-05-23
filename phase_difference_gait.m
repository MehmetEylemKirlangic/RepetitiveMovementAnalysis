% The function phase_difference_gait gets the loaded data of sg_Hip_Knee_Angle,
% sg_Knee_Angle and sg_Knee_Ankle_Angle after the pre-processing stage. 
% It calculates then the phase difference of the time-series of the three joints
% and gives the calculated synchornization index R back to be shown in the Synchronbisation and gait 
% analysis GUI

% Program :  Repetitive Movement Analysis
% Version :  1.2
% Function:  phase_difference_gait
% Authors  :  Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic


function [PH_DF_Hip_Knee,PH_DF_Hip_Ankle,PH_DF_Knee_Ankle,R_Hip_Knee,R_Hip_Ankle,R_Knee_Ankle] = phase_difference_gait(varargin)

H=varargin{1};  % hip knee angle
K=varargin{2};  % knee angle
A=varargin{3};  % knee ankle angle

LH=length(H);   % length
LK=length(K);
LA=length(A);

LV=[LH LK LA];

L=min(LV);

meanH=mean(H);  % mean value
meanK=mean(K);
meanA=mean(A);

HB=H-meanH;     %baseline
KB=K-meanK;
AB=A-meanA;

HH=hilbert(HB); % Hilbert-transform
KH=hilbert(KB);
AH=hilbert(AB);


PH_DF_Hip_Knee=mod(angle(HH(1:L))-angle(KH(1:L)), 2*pi);    % phase differnce hip knee
PH_DF_Hip_Ankle=mod(angle(HH(1:L))-angle(AH(1:L)), 2*pi);   % phase differnce hip ankle
PH_DF_Knee_Ankle=mod(angle(KH(1:L))-angle(AH(1:L)), 2*pi);  % phase differnce knee ankle

%% synchornization index

R_Hip_Knee=abs(sum(exp(i*PH_DF_Hip_Knee))/L);
R_Hip_Ankle=abs(sum(exp(i*PH_DF_Hip_Ankle))/L);
R_Knee_Ankle=abs(sum(exp(i*PH_DF_Knee_Ankle))/L);

%%% or

% RHK=sqrt(   (sum(cos(PH_DF_Hip_Knee))/L)  ^2  +  (sum(sin(PH_DF_Hip_Knee))/L)  ^2);
% RHA=sqrt(   (sum(cos(PH_DF_Hip_Ankle))/L)  ^2  +  (sum(sin(PH_DF_Hip_Ankle))/L)  ^2);
% RKA=sqrt(   (sum(cos(PH_DF_Knee_Ankle))/L)  ^2  +  (sum(sin(PH_DF_Knee_Ankle))/L)  ^2);



