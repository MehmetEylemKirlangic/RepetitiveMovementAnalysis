% Program :  Repetitive Movement Analysis
% Version :  1.2
% Function:  Synchronisation_Gait_Analysis_Right GUI
% Authors  :  Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic

function varargout = Synchronisation_Gait_Analysis_Right(varargin)
%SYNCHRONISATION_GAIT_ANALYSIS_RIGHT M-file for Synchronisation_Gait_Analysis_Right.fig
%      SYNCHRONISATION_GAIT_ANALYSIS_RIGHT, by itself, creates a new SYNCHRONISATION_GAIT_ANALYSIS_RIGHT or raises the existing
%      singleton*.
%
%      H = SYNCHRONISATION_GAIT_ANALYSIS_RIGHT returns the handle to a new SYNCHRONISATION_GAIT_ANALYSIS_RIGHT or the handle to
%      the existing singleton*.
%
%      SYNCHRONISATION_GAIT_ANALYSIS_RIGHT('Property','Value',...) creates a new SYNCHRONISATION_GAIT_ANALYSIS_RIGHT using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Synchronisation_Gait_Analysis_Right_OpeningFcn.  This calling syntax produces a
%
%      SYNCHRONISATION_GAIT_ANALYSIS_RIGHT('CALLBACK') and SYNCHRONISATION_GAIT_ANALYSIS_RIGHT('CALLBACK',hObject,...) call the
%      local function named CALLBACK in SYNCHRONISATION_GAIT_ANALYSIS_RIGHT.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Synchronisation_Gait_Analysis_Right

% Last Modified by GUIDE v2.5 17-May-2019 14:50:37

% ---------Autors:   Al-Qadhi  Safwan, Dr. Mehmet Eylem Kirlangic

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Synchronisation_Gait_Analysis_Right_OpeningFcn, ...
                   'gui_OutputFcn',  @Synchronisation_Gait_Analysis_Right_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

%% --- Executes just before Synchronisation_Gait_Analysis_Right is made visible.
function Synchronisation_Gait_Analysis_Right_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for Synchronisation_Gait_Analysis_Right
handles.output = hObject;


% imgFile = 'logo_juelich_300x60.jpg';
% img=imread(imgFile);
% image(img,'parent',handles.LogoJuelich);
% set(handles.LogoJuelich,'XTick',[],'YTick',[]);
% set(handles.LogoJuelich,'box','off');
% set(handles.LogoJuelich,'Visible','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Synchronisation_Gait_Analysis_Right wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%% --- Outputs from this function are returned to the command line.
function varargout = Synchronisation_Gait_Analysis_Right_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in load_all_data.
function load_all_data_Callback(hObject, eventdata, handles)
% hObject    handle to load_all_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Time_steplength sg_steplength;
global Time_Ankle sg_Ankle diff_sg_Ankle; 
global Time_Knee_Angle sg_Knee_Angle; 
global sg_Hip_Knee_Angle; 
global sg_Knee_Ankle_Angle;
global Patient_ID_file;


Gait2_axes(1)=handles.axes1;
Gait2_axes(2)=handles.axes2;
Gait2_axes(3)=handles.axes3;
Gait2_axes(4)=handles.axes4;
Gait2_axes(5)=handles.axes5;
Gait2_axes(6)=handles.axes6;
Gait2_axes(7)=handles.axes7;
Gait2_axes(8)=handles.axes8;

[directory_name,Patient_ID_file]=find_folder();

if isdir(directory_name) && ~isequal(directory_name,'')
    
look_for_this_file_steplength='Step_Length_2.txt';
[Patient_steplength,Patient_ID_file]=find_and_load_file_alone(look_for_this_file_steplength,directory_name);
    
if ~isempty(Patient_steplength) 
h = waitbar(0,'Load file...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h) 
    
[Time_steplength,sg_steplength]=steplength_function(Patient_steplength);

cla(Gait2_axes(1),'reset')
axes(Gait2_axes(1));
set(Gait2_axes(1),'XMinorTick','on')
plot(Time_steplength,sg_steplength)
grid on

else
cla(Gait2_axes(1),'reset')
set(Gait2_axes(1),'XGrid','on','YGrid','on')
Time_steplength='';
sg_steplength='';
end 

look_for_this_file_Ankel='Ankle_right.txt';
[Patient_Ankle,Patient_ID_file] =find_and_load_file_alone(look_for_this_file_Ankel,directory_name);

if ~isempty(Patient_Ankle)  
h = waitbar(0,'Load file...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h) 

[Time_Ankle,X1,Y1]=ankle(Patient_Ankle);

if ~isempty(X1) && ~isempty(Y1)
cla(Gait2_axes(2),'reset')
axes(Gait2_axes(2));
set(Gait2_axes(2),'XMinorTick','on')
plot(Y1(1:end-1),diff(Y1))
grid off
else
cla(Gait2_axes(2),'reset')
set(Gait2_axes(2),'XGrid','on','YGrid','on')
end


else
cla(Gait2_axes(2),'reset')
set(Gait2_axes(2),'XGrid','on','YGrid','on')
end 

look_for_this_file_Knee_Angle='Knee_Angle_right.txt';
[Patient_Knee_Angle,Patient_ID_file] =find_and_load_file_alone(look_for_this_file_Knee_Angle,directory_name);

if ~isempty(Patient_Knee_Angle)  
h = waitbar(0,'Load file...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h) 

[Time_Knee_Angle,sg_Knee_Angle]=knee_angle(Patient_Knee_Angle); 

cla(Gait2_axes(3),'reset')
axes(Gait2_axes(3));
set(Gait2_axes(3),'XMinorTick','on')
plot(Time_Knee_Angle,sg_Knee_Angle)
grid on

else
    cla(Gait2_axes(3),'reset')
    set(Gait2_axes(3),'XGrid','on','YGrid','on')
    cla(Gait2_axes(6),'reset')
    set(Gait2_axes(6),'XGrid','on','YGrid','on')
    sg_Knee_Angle='';
end 

look_for_this_file_Hip_Knee_Angle='Hip_right.txt';
[Patient_Hip_Knee_Angle,Patient_ID_file] =find_and_load_file_alone(look_for_this_file_Hip_Knee_Angle,directory_name);

if ~isempty(Patient_Hip_Knee_Angle)  
h = waitbar(0,'Load file...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h) 

[Time_Hip_Knee_Angle,sg_Hip_Knee_Angle]=Hip_angle(Patient_Hip_Knee_Angle); 

cla(Gait2_axes(4),'reset')
axes(Gait2_axes(4));
set(Gait2_axes(4),'XMinorTick','on')
plot(Time_Hip_Knee_Angle,sg_Hip_Knee_Angle)
grid on

else
    cla(Gait2_axes(4),'reset')
    set(Gait2_axes(4),'XGrid','on','YGrid','on')
    cla(Gait2_axes(7),'reset')
    set(Gait2_axes(7),'XGrid','on','YGrid','on')
    sg_Hip_Knee_Angle='';
end 

look_for_this_file_Knee_Ankle_Angle='Knee_Ankle_Angle_right.txt';
[Patient_Knee_Ankle_Angle,Patient_ID_file] =find_and_load_file_alone(look_for_this_file_Knee_Ankle_Angle,directory_name);

if ~isempty(Patient_Knee_Ankle_Angle)  
h = waitbar(0,'Load file...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h) 
 
[Time_Knee_Ankle_Angle,sg_Knee_Ankle_Angle]=Knee_Ankle_Angle(Patient_Knee_Ankle_Angle);

cla(Gait2_axes(5),'reset')
axes(Gait2_axes(5));
set(Gait2_axes(5),'XMinorTick','on')
plot(Time_Knee_Ankle_Angle,sg_Knee_Ankle_Angle)
grid on

% set(handles.patient_number,'String','');

else 
    cla(Gait2_axes(5),'reset')
    set(Gait2_axes(5),'XGrid','on','YGrid','on')
    cla(Gait2_axes(8),'reset')
    set(Gait2_axes(8),'XGrid','on','YGrid','on')
    sg_Knee_Ankle_Angle='';
end 

set(handles.patient_number,'String',Patient_ID_file)

else
end  % if isdir

% Update handles structure
guidata(hObject, handles);

%% --- Executes on button press in browse1.
function browse1_Callback(hObject, eventdata, handles)
% hObject    handle to browse1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Time_steplength sg_steplength 
Gait2_axes(1)=handles.axes1; 

[Patient_steplength] = Load_file();

if ~isempty(Patient_steplength)  
h = waitbar(0,'Load file...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h) 

[Time_steplength,sg_steplength]=steplength_function(Patient_steplength);

if  ~isempty(Time_steplength) &&  ~isempty(sg_steplength)
cla(Gait2_axes(1),'reset')
axes(Gait2_axes(1));
set(Gait2_axes(1),'XMinorTick','on')
plot(Time_steplength,sg_steplength)
grid on

set(handles.patient_number,'String','');

else
%   cla(Gait2_axes(1),'reset')
    Time_steplength='';
    sg_steplength='';
    return;
end 
end
% Update handles structure
guidata(hObject, handles);

%% --- Executes on button press in browse2.
function browse2_Callback(hObject, eventdata, handles)
% hObject    handle to browse2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% global Time_Ankle sg_Ankle diff_sg_Ankle;

Gait2_axes(2)=handles.axes2; 

[Patient_Ankle] = Load_file();

if ~isempty(Patient_Ankle)  
h = waitbar(0,'Load file...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h) 

[Time_Ankle,X1,Y1]=ankle(Patient_Ankle);

if  ~isempty(X1) &&  ~isempty(Y1)   
cla(Gait2_axes(2),'reset')
axes(Gait2_axes(2));
set(Gait2_axes(2),'XMinorTick','on')
plot(X1,Y1)
grid off

set(handles.patient_number,'String','');

else
%     cla(Gait2_axes(2),'reset')
    return;
end 
end

% Update handles structure
guidata(hObject, handles);

%% --- Executes on button press in browse3.
function browse3_Callback(hObject, eventdata, handles)
% hObject    handle to browse3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Time_Knee_Angle sg_Knee_Angle; 
Gait2_axes(3)=handles.axes3;
Gait2_axes(6)=handles.axes6;

[Patient_Knee_Angle] = Load_file();

if ~isempty(Patient_Knee_Angle)  
h = waitbar(0,'Load file...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h) 

[Time_Knee_Angle,sg_Knee_Angle]=knee_angle(Patient_Knee_Angle); 

if  ~isempty(Time_Knee_Angle) &&  ~isempty(Time_Knee_Angle)
cla(Gait2_axes(3),'reset')
axes(Gait2_axes(3));
set(Gait2_axes(3),'XMinorTick','on')
plot(Time_Knee_Angle,sg_Knee_Angle)
grid on

set(handles.patient_number,'String','');

else
%     cla(Gait2_axes(3),'reset')
%     cla(Gait2_axes(6),'reset')
      sg_Knee_Angle='';
    return;
end 
end

% Update handles structure
guidata(hObject, handles);

%% --- Executes on button press in browse4.
function browse4_Callback(hObject, eventdata, handles)
% hObject    handle to browse4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA

global sg_Hip_Knee_Angle; 
Gait2_axes(4)=handles.axes4; 
Gait2_axes(7)=handles.axes7; 

[Patient_Hip_Knee_Angle] = Load_file();

if ~isempty(Patient_Hip_Knee_Angle)  
h = waitbar(0,'Load file...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h) 

[Time_Hip_Knee_Angle,sg_Hip_Knee_Angle]=Hip_angle(Patient_Hip_Knee_Angle); 

if  ~isempty(Time_Hip_Knee_Angle) &&  ~isempty(sg_Hip_Knee_Angle)
cla(Gait2_axes(4),'reset')
axes(Gait2_axes(4));
set(Gait2_axes(4),'XMinorTick','on')
plot(Time_Hip_Knee_Angle,sg_Hip_Knee_Angle)
grid on

set(handles.patient_number,'String','');

else
%     cla(Gait2_axes(4),'reset')
%     cla(Gait2_axes(7),'reset') 
      sg_Hip_Knee_Angle='';
    return;
end 
end

% Update handles structure
guidata(hObject, handles);

%% --- Executes on button press in browse5.
function browse5_Callback(hObject, eventdata, handles)
% hObject    handle to browse5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global sg_Knee_Ankle_Angle; 
Gait2_axes(5)=handles.axes5; 
Gait2_axes(8)=handles.axes8; 

[Patient_Knee_Ankle_Angle] = Load_file();

if ~isempty(Patient_Knee_Ankle_Angle)  
h = waitbar(0,'Load file...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h) 
 
[Time_Knee_Ankle_Angle,sg_Knee_Ankle_Angle]=Knee_Ankle_Angle(Patient_Knee_Ankle_Angle);

if  ~isempty(Time_Knee_Ankle_Angle) &&  ~isempty(sg_Knee_Ankle_Angle)
cla(Gait2_axes(5),'reset')
axes(Gait2_axes(5));
set(Gait2_axes(5),'XMinorTick','on')
plot(Time_Knee_Ankle_Angle,sg_Knee_Ankle_Angle)
grid on

set(handles.patient_number,'String','');

else
%     cla(Gait2_axes(5),'reset');
%     cla(Gait2_axes(8),'reset');
      sg_Knee_Ankle_Angle='';
    return;
end 
end

% Update handles structure
guidata(hObject, handles);

%% --- Executes on button press in analyse.
function analyse_Callback(hObject, eventdata, handles)
% hObject    handle to analyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Time_steplength sg_steplength VarNam_Steplength Valu_Steplength  ;
global Time_Knee_Angle sg_Knee_Angle VarNam_Knee_Angle Valu_Knee_Angle;
global sg_Hip_Knee_Angle VarNam_Hip_Knee_Angle Valu_Hip_Knee_Angle;
global sg_Knee_Ankle_Angle VarNam_Knee_Ankle_Angle Valu_Knee_Ankle_Angle;
global VarNam_Phase_difference Valu_Phase_difference;

Gait2_axes(6)=handles.axes6; 
Gait2_axes(7)=handles.axes7;
Gait2_axes(8)=handles.axes8;

if ~isempty(Time_steplength) && ~isempty(sg_steplength)
    
    [cadence, Stride_mean,Stride_std, average_maxima,...
    average_minima,std_maxima,std_minima,m_min]=steplength_analyse(Time_steplength, sg_steplength);

VarNam_Steplength={'Gait Right cadence','Gait Right mean Stride in m','Gait Right std. Stride',...
       'Gait Right mean Step Left in m','Gait Right mean Step Right in m','Gait Right std. Step Left',...
       'Gait Right std. Step Right','Gait Right meter per minute'};
  
Valu_Steplength=cell2mat({cadence,Stride_mean,Stride_std, average_maxima,...
            average_minima,std_maxima,std_minima,m_min});
        
set(handles.cadence,'String',Valu_Steplength(1),'Fontsize',8,'fontweight','n');
set(handles.Stride_mean,'String',Valu_Steplength(2),'Fontsize',8,'fontweight','n');
set(handles. Stride_std,'String', Valu_Steplength(3),'Fontsize',8,'fontweight','n');
set(handles.average_maxima,'String',Valu_Steplength(4),'Fontsize',8,'fontweight','n');
set(handles.average_minima,'String',Valu_Steplength(5),'Fontsize',8,'fontweight','n');
set(handles.std_maxima,'String',Valu_Steplength(6),'Fontsize',8,'fontweight','n');
set(handles.std_minima,'String',Valu_Steplength(7),'Fontsize',8,'fontweight','n');
set(handles.m_min,'String',Valu_Steplength(8),'Fontsize',8,'fontweight','n');
else 
set(handles.cadence,'String','');
set(handles.Stride_mean,'String','');
set(handles. Stride_std,'String','');
set(handles.average_maxima,'String','');
set(handles.average_minima,'String','');
set(handles.std_maxima,'String','');
set(handles.std_minima,'String','');
set(handles.m_min,'String','');    

end

%%

Gait2_axes(9)=handles.axes9; 
Gait2_axes(10)=handles.axes10;
Gait2_axes(11)=handles.axes11;

if isempty(sg_Knee_Angle)|| isempty(sg_Hip_Knee_Angle ) || isempty(sg_Knee_Ankle_Angle)  
    cla(Gait2_axes(9),'reset')
    set(Gait2_axes(9),'XGrid','on','YGrid','on')
    cla(Gait2_axes(10),'reset')
    set(Gait2_axes(10),'XGrid','on','YGrid','on')
    cla(Gait2_axes(11),'reset')
    set(Gait2_axes(11),'XGrid','on','YGrid','on')
    
    set(handles.r_hip_knee,'String','');
    set(handles.r_hip_ankle,'String','');
    set(handles.r_knee_ankle,'String','');
else
    
[PH_DF_Hip_Knee,PH_DF_Hip_Ankle,PH_DF_Knee_Ankle,R_Hip_Knee,R_Hip_Ankle,R_Knee_Ankle] = phase_difference_gait(sg_Hip_Knee_Angle,sg_Knee_Angle,sg_Knee_Ankle_Angle);

VarNam_Phase_difference={'Synchornization index Hip Knee','Synchornization index Hip Ankle','Synchornization index Knee Ankle'};
  
Valu_Phase_difference=cell2mat({R_Hip_Knee,R_Hip_Ankle,R_Knee_Ankle});
        
cla(Gait2_axes(9),'reset')
axes(Gait2_axes(9));
set(Gait2_axes(9),'XMinorTick','on')
plot(Time_Knee_Angle,PH_DF_Hip_Knee,'g','Color',[0.3,0.4,0.2])
grid on

cla(Gait2_axes(10),'reset')
axes(Gait2_axes(10));
set(Gait2_axes(10),'XMinorTick','on')
plot(Time_Knee_Angle,PH_DF_Hip_Ankle,'g','Color',[0.3,0.4,0.2])
grid on

cla(Gait2_axes(11),'reset')
axes(Gait2_axes(11));
set(Gait2_axes(11),'XMinorTick','on')
plot(Time_Knee_Angle,PH_DF_Knee_Ankle,'g','Color',[0.3,0.4,0.2])
grid on

set(handles.r_hip_knee,'String',R_Hip_Knee,'Fontsize',9,'fontweight','b');
set(handles.r_hip_ankle,'String',R_Hip_Ankle,'Fontsize',9,'fontweight','b');
set(handles.r_knee_ankle,'String',R_Knee_Ankle,'Fontsize',9,'fontweight','b');

end


%%
find_toolbox=which('ecdf');
if isequal(find_toolbox,'')
    uiwait(errordlg('You need the Statistic-Toolbox of MATLAB to complete the analysis process!','Error'));
    return;
end

%% Statistik Knee_Angle_Right

if ~isempty(sg_Knee_Angle)    
cla(Gait2_axes(6),'reset')

% Remove missing values
t_sg_Knee_Angle = ~isnan(sg_Knee_Angle);
sg_Knee_Angle = sg_Knee_Angle(t_sg_Knee_Angle);
% Set up figure to receive datasets and fits
ax_6 = Gait2_axes(6);
set(ax_6,'Box','on');
hold on;
% --- Plot data originally in dataset "sig data"
sg_Knee_Angle = sg_Knee_Angle(:);
[F_sg_Knee_Angle,X_sg_Knee_Angle] = ecdf(sg_Knee_Angle,'Function','cdf'...
              );  % compute empirical cdf
Bin_sg_Knee_Angle.rule = 1;
[C_sg_Knee_Angle,E_sg_Knee_Angle] = dfswitchyard('dfhistbins',sg_Knee_Angle,[],[],Bin_sg_Knee_Angle,F_sg_Knee_Angle,X_sg_Knee_Angle);
[N_sg_Knee_Angle,C_sg_Knee_Angle] = ecdfhist(F_sg_Knee_Angle,X_sg_Knee_Angle,'edges',E_sg_Knee_Angle); % empirical pdf from cdf
axes(handles.axes6);
h_sg_Knee_Angle = bar(C_sg_Knee_Angle,N_sg_Knee_Angle,'hist');
set(h_sg_Knee_Angle,'FaceColor','none','EdgeColor',[0.333333 0 0.666667],...
       'LineStyle','-', 'LineWidth',1);
hold on
% Nudge axis limits beyond data limits
xlim_sg_Knee_Angle = get(ax_6,'XLim');
if all(isfinite(xlim_sg_Knee_Angle))
   xlim_sg_Knee_Angle = xlim_sg_Knee_Angle + [-1 1] * 0.01 * diff(xlim_sg_Knee_Angle);
   set(ax_6,'XLim',xlim_sg_Knee_Angle)
end

x_sg_Knee_Angle = linspace(xlim_sg_Knee_Angle(1),xlim_sg_Knee_Angle(2),100);

% Fit this distribution to get parameter values
p_Knee_Angle = evfit(sg_Knee_Angle);
y_sg_Knee_Angle = evpdf(x_sg_Knee_Angle,p_Knee_Angle(1), p_Knee_Angle(2));

[mean_Knee_Angle, var_Knee_Angle] = evstat(p_Knee_Angle(1),p_Knee_Angle(2));

VarNam_Knee_Angle={'Gait Right Knee Angle EVD mu','Gait Right Knee Angle EVD sigma',...
       'Gait Right Knee Angle EVD mean','Gait Right Knee Angle EVD variance'};
  
Valu_Knee_Angle=cell2mat({p_Knee_Angle(1),p_Knee_Angle(2),mean_Knee_Angle, var_Knee_Angle});

set(handles.mu_Knee_Angle,'String',Valu_Knee_Angle(1),'Fontsize',9,'fontweight','n');
set(handles.sigma_Knee_Angle,'String',Valu_Knee_Angle(2),'Fontsize',9,'fontweight','n');
set(handles.mean_Knee_Angle,'String',Valu_Knee_Angle(3),'Fontsize',9,'fontweight','n');
set(handles.var_Knee_Angle,'String',Valu_Knee_Angle(4),'Fontsize',9,'fontweight','n');

h_sg_Knee_Angle = plot(x_sg_Knee_Angle,y_sg_Knee_Angle,'Color',[1 0 0],...
          'LineStyle','-', 'LineWidth',2,...
          'Marker','none', 'MarkerSize',6);
% grid on;
hold off;

% clear global sg_Knee_Angle;
else
set(handles.mu_Knee_Angle,'String','');
set(handles.sigma_Knee_Angle,'String','');
set(handles.mean_Knee_Angle,'String','');
set(handles.var_Knee_Angle,'String','');
VarNam_Knee_Angle='';
Valu_Knee_Angle='';
end

%% Statistik Hip_Knee_Angle_Right

if ~isempty(sg_Hip_Knee_Angle)
    
cla(Gait2_axes(7),'reset')

% Remove missing values
t_sg_Hip_Knee_Angle = ~isnan(sg_Hip_Knee_Angle);
sg_Hip_Knee_Angle = sg_Hip_Knee_Angle(t_sg_Hip_Knee_Angle);
% Set up figure to receive datasets and fits
ax_7 = Gait2_axes(7);
set(ax_7,'Box','on');
hold on;
% --- Plot data originally in dataset "sig data"
sg_Hip_Knee_Angle = sg_Hip_Knee_Angle(:);
[F_sg_Hip_Knee_Angle,X_sg_Hip_Knee_Angle] = ecdf(sg_Hip_Knee_Angle,'Function','cdf'...
              );  % compute empirical cdf
Bin_sg_Hip_Knee_Angle.rule = 1;
[C_sg_Hip_Knee_Angle,E_sg_Hip_Knee_Angle] = dfswitchyard('dfhistbins',sg_Hip_Knee_Angle,[],[],Bin_sg_Hip_Knee_Angle,F_sg_Hip_Knee_Angle,X_sg_Hip_Knee_Angle);
[N_sg_Hip_Knee_Angle,C_sg_Hip_Knee_Angle] = ecdfhist(F_sg_Hip_Knee_Angle,X_sg_Hip_Knee_Angle,'edges',E_sg_Hip_Knee_Angle); % empirical pdf from cdf
axes(handles.axes7);
h_sg_Hip_Knee_Angle = bar(C_sg_Hip_Knee_Angle,N_sg_Hip_Knee_Angle,'hist');
set(h_sg_Hip_Knee_Angle,'FaceColor','none','EdgeColor',[0.333333 0 0.666667],...
       'LineStyle','-', 'LineWidth',1);
hold on
% Nudge axis limits beyond data limits
xlim_sg_Hip_Knee_Angle = get(ax_7,'XLim');
if all(isfinite(xlim_sg_Hip_Knee_Angle))
   xlim_sg_Hip_Knee_Angle = xlim_sg_Hip_Knee_Angle + [-1 1] * 0.01 * diff(xlim_sg_Hip_Knee_Angle);
   set(ax_7,'XLim',xlim_sg_Hip_Knee_Angle)
   set(ax_7,'XMinorTick','on')
end

x_sg_Hip_Knee_Angle = linspace(xlim_sg_Hip_Knee_Angle(1),xlim_sg_Hip_Knee_Angle(2),100);

% Fit this distribution to get parameter value
%    
p_Hip_Knee_Angle = evfit(sg_Hip_Knee_Angle);
y_sg_Hip_Knee_Angle = evpdf(x_sg_Hip_Knee_Angle,p_Hip_Knee_Angle(1), p_Hip_Knee_Angle(2));

[mean_Hip_Knee_Angle, var_Hip_Knee_Angle] = evstat(p_Hip_Knee_Angle(1),p_Hip_Knee_Angle(2));

VarNam_Hip_Knee_Angle={'Gait Right Hip Knee Angle EVD mu','Gait Right Hip Knee Angle EVD sigma',...
       'Gait Right Hip Knee Angle EVD mean','Gait Right Hip Knee Angle EVD variance'};
  
Valu_Hip_Knee_Angle=cell2mat({p_Hip_Knee_Angle(1),p_Hip_Knee_Angle(2),mean_Hip_Knee_Angle, var_Hip_Knee_Angle});

set(handles.mu_Hip_Knee_Angle,'String',Valu_Hip_Knee_Angle(1),'Fontsize',9,'fontweight','n');
set(handles.sigma_Hip_Knee_Angle,'String',Valu_Hip_Knee_Angle(2),'Fontsize',9,'fontweight','n');
set(handles.mean_Hip_Knee_Angle,'String',Valu_Hip_Knee_Angle(3),'Fontsize',9,'fontweight','n');
set(handles.var_Hip_Knee_Angle,'String',Valu_Hip_Knee_Angle(4),'Fontsize',9,'fontweight','n');

h_sg_Hip_Knee_Angle = plot(x_sg_Hip_Knee_Angle,y_sg_Hip_Knee_Angle,'Color',[1 0 0],...
          'LineStyle','-', 'LineWidth',2,...
          'Marker','none', 'MarkerSize',6);
% grid on;
hold off;

else
set(handles.mu_Hip_Knee_Angle,'String','');
set(handles.sigma_Hip_Knee_Angle,'String','');
set(handles.mean_Hip_Knee_Angle,'String','');
set(handles.var_Hip_Knee_Angle,'String','');
VarNam_Hip_Knee_Angle='';
Valu_Hip_Knee_Angle='';
end


%% Statistik Knee_Angle_Ankle_Right

if ~isempty(sg_Knee_Ankle_Angle)
    
cla(Gait2_axes(8),'reset')
    
% Remove missing values
t_ = ~isnan(sg_Knee_Ankle_Angle);
sg_Knee_Ankle_Angle = sg_Knee_Ankle_Angle(t_);
% Set up figure to receive datasets and fits
ax_8 = Gait2_axes(8); 
set(ax_8,'Box','on');
hold on;
% --- Plot data originally in dataset "sig data"
sg_Knee_Ankle_Angle = sg_Knee_Ankle_Angle(:);
[F_,X_] = ecdf(sg_Knee_Ankle_Angle,'Function','cdf'...
              );  % compute empirical cdf
Bin_.rule = 1;
[C_,E_] = dfswitchyard('dfhistbins',sg_Knee_Ankle_Angle,[],[],Bin_,F_,X_);
[N_,C_] = ecdfhist(F_,X_,'edges',E_); % empirical pdf from cdf
axes(handles.axes8);
h_ = bar(C_,N_,'hist');
set(h_,'FaceColor','none','EdgeColor',[0.333333 0 0.666667],...
       'LineStyle','-', 'LineWidth',1);
hold on
% Nudge axis limits beyond data limits
xlim_ = get(ax_8,'XLim');
if all(isfinite(xlim_))
   xlim_ = xlim_ + [-1 1] * 0.01 * diff(xlim_);
   set(ax_8,'XLim',xlim_)
end

x_ = linspace(xlim_(1),xlim_(2),100);

% Fit this distribution to get parameter values
p_Knee_Ankle_Angle = evfit(sg_Knee_Ankle_Angle);
y_ = evpdf(x_,p_Knee_Ankle_Angle(1), p_Knee_Ankle_Angle(2));

[mean_Knee_Ankle_Angle, var_Knee_Ankle_Angle] = evstat(p_Knee_Ankle_Angle(1),p_Knee_Ankle_Angle(2));

VarNam_Knee_Ankle_Angle={'Gait Right Knee Ankle Angle EVD mu','Gait Right Knee Ankle Angle EVD sigma',...
       'Gait Right Knee Ankle Angle EVD mean','Gait Right Knee Ankle Angle EVD variance'};
  
Valu_Knee_Ankle_Angle=cell2mat({p_Knee_Ankle_Angle(1),p_Knee_Ankle_Angle(2),mean_Knee_Ankle_Angle, var_Knee_Ankle_Angle});

set(handles.mu_Knee_Ankle_Angle,'String',Valu_Knee_Ankle_Angle(1),'Fontsize',9,'fontweight','n');
set(handles.sigma_Knee_Ankle_Angle,'String',Valu_Knee_Ankle_Angle(2),'Fontsize',9,'fontweight','n');
set(handles.mean_Knee_Ankle_Angle,'String',Valu_Knee_Ankle_Angle(3),'Fontsize',9,'fontweight','n');
set(handles.var_Knee_Ankle_Angle,'String',Valu_Knee_Ankle_Angle(4),'Fontsize',9,'fontweight','n');

h_ = plot(x_,y_,'Color',[1 0 0],...
          'LineStyle','-', 'LineWidth',2,...
          'Marker','none', 'MarkerSize',6);
% grid on;
hold off;

else
set(handles.mu_Knee_Ankle_Angle,'String','');
set(handles.sigma_Knee_Ankle_Angle,'String','');
set(handles.mean_Knee_Ankle_Angle,'String','');
set(handles.var_Knee_Ankle_Angle,'String','');
VarNam_Knee_Ankle_Angle='';
Valu_Knee_Ankle_Angle='';
end

% Update handles structure
guidata(hObject, handles);

%%
function x_start_Callback(hObject, eventdata, handles)
% hObject    handle to x_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_start as text
%        str2double(get(hObject,'String')) returns contents of x_start as a double

global X_start X_end;

X_end=str2double(get(handles.x_end,'String'));
X_start=str2double(get(handles.x_start,'String'));

         Gait2_axes(1)=handles.axes1;
         Gait2_axes(2)=handles.axes2;
         Gait2_axes(3)=handles.axes3;
         Gait2_axes(4)=handles.axes4;
         Gait2_axes(5)=handles.axes5;
         Gait2_axes(6)=handles.axes6;
         Gait2_axes(7)=handles.axes7;
         Gait2_axes(8)=handles.axes8;
         Gait2_axes(9)=handles.axes9;
         Gait2_axes(10)=handles.axes10;
         Gait2_axes(11)=handles.axes11;

         str=get(handles.select_graph, 'String');
         val=str2double(str{get(handles.select_graph, 'value')});

if isnan(val) 
errordlg('please select graph first','Error');
return;
end

if val==2
    return;
end

if X_end <= X_start
    errordlg('Input must be bigger than start','Error');
    set(hObject, 'String', 0);
    X_end=str2double(get(hObject,'String'));
    set(Gait2_axes(val),'Xlim',[X_start Right_measure_Time+2]);
    
elseif isnan(X_end)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
    X_end=str2double(get(hObject,'String'));
    set(Gait2_axes(val),'Xlim',[X_start X_end]);

else
set(Gait2_axes(val),'Xlim',[X_start X_end]);
end
         
% Update handles structure
guidata(hObject, handles);

%% --- Executes during object creation, after setting all properties.
function x_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
function x_end_Callback(hObject, eventdata, handles)
% hObject    handle to x_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_end as text
%        str2double(get(hObject,'String')) returns contents of x_end as a double

 
global X_start X_end;

X_end=str2double(get(handles.x_end,'String'));
X_start=str2double(get(handles.x_start,'String'));

         Gait2_axes(1)=handles.axes1;
         Gait2_axes(2)=handles.axes2;
         Gait2_axes(3)=handles.axes3;
         Gait2_axes(4)=handles.axes4;
         Gait2_axes(5)=handles.axes5;
         Gait2_axes(6)=handles.axes6;
         Gait2_axes(7)=handles.axes7;
         Gait2_axes(8)=handles.axes8;
         Gait2_axes(9)=handles.axes9;
         Gait2_axes(10)=handles.axes10;
         Gait2_axes(11)=handles.axes11;

         str=get(handles.select_graph, 'String');
         val=str2double(str{get(handles.select_graph, 'value')});

if isnan(val) 
errordlg('please select graph first','Error');
return;
end

if val==2
    return;
end

if X_end <= X_start
    errordlg('Input must be bigger than start','Error');
    set(hObject, 'String', 25);
    X_end=str2double(get(hObject,'String'));
    set(Gait2_axes(val),'Xlim',[X_start Right_measure_Time+2]);
    
elseif isnan(X_end)
    set(hObject, 'String', 25);
    errordlg('Input must be a number','Error');
    X_end=str2double(get(hObject,'String'));
    set(Gait2_axes(val),'Xlim',[X_start X_end]);

else
set(Gait2_axes(val),'Xlim',[X_start X_end]);
end
         
% Update handles structure
guidata(hObject, handles);

%% --- Executes during object creation, after setting all properties.
function x_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in select_graph.
function select_graph_Callback(hObject, eventdata, handles)
% hObject    handle to select_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns select_graph contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select_graph

global X_end  X_start;


    X_end=str2double(get(handles.x_end,'String'));
    X_start=str2double(get(handles.x_start,'String'));
    
    
         str=get(handles.select_graph, 'String');
         val=get(handles.select_graph, 'value');
            
         switch str{val}
             
         case '' % User select.
             
         case '1' % User select.
             set(handles.axes1,'Xlim',[X_start X_end]);
             
         case '2' % User select.
             
         case '3' % User select.
             set(handles.axes3,'Xlim',[X_start X_end]);
             
         case '4' % User select.
             set(handles.axes4,'Xlim',[X_start X_end]);
             
         case '5' % User select.
             set(handles.axes5,'Xlim',[X_start X_end]);
             
         case '6' % User select.
%              set(handles.axes6,'Xlim',[X_start X_end]);
             
         case '7' % User select.
%              set(handles.axes7,'Xlim',[X_start X_end]);
             
         case '8' % User select.
%              set(handles.axes8,'Xlim',[X_start X_end]);

         case '9' % User select.
             set(handles.axes9,'Xlim',[X_start X_end]);
             
         case '10' % User select.
             set(handles.axes10,'Xlim',[X_start X_end]);
             
         case '11' % User select.
             set(handles.axes11,'Xlim',[X_start X_end]);
            
             otherwise
                
         end

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function select_graph_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'',...
          '1',...
          '2',...
          '3',...
          '4',...
          '5',...
          '6',...
          '7',...
          '8',...
          '9',...
          '10',...
          '11'});

%%
function patient_number_Callback(hObject, eventdata, handles)
% hObject    handle to patient_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of patient_number as text
%        str2double(get(hObject,'String')) returns contents of patient_number as a double

global Patient_ID ;

Patient_ID=get(hObject,'String');

% if ~isempty(Patient_ID)
%     Patient_ID='';    
% else
%     Patient_ID=Patient;
% end
% --- Executes during object creation, after setting all properties.
function patient_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to patient_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% global TA SA;
% SS=[TA,SA];
% save(strcat(saveFilePath, saveFileName),'SS','-ASCII');
% SS = struct('textdata', 'x_start   Patient_Paced_Tapping', 'data', [TA,SA]);
% hier konnte struct mit save nicht gespeichert werden.

global Patient_ID ;
global VarNam_Steplength Valu_Steplength  ;
global VarNam_Knee_Angle Valu_Knee_Angle;
global VarNam_Hip_Knee_Angle Valu_Hip_Knee_Angle;
global VarNam_Knee_Ankle_Angle Valu_Knee_Ankle_Angle;
global VarNam_Phase_difference Valu_Phase_difference;

try
Patient_ID=get(handles.patient_number,'String');
catch
end
  
if isempty(Patient_ID),
     pause(0.2);
     uiwait(errordlg('Please enter Patient ID and press save ...', 'Error', 'modal'))
     return;
     
else
    

%         set(handles.browse1, 'Visible', 'off');       
%         set(handles.browse2, 'Visible', 'off');
%         set(handles.browse3, 'Visible', 'off');
%         set(handles.browse4, 'Visible', 'off');
%         set(handles.browse5, 'Visible', 'off');
%         set(handles.analyse, 'Visible', 'off');
%         set(handles.home, 'Visible', 'off');
%         set(handles.print, 'Visible', 'off');
%         set(handles.save, 'Visible', 'off');
%         set(handles.exit, 'Visible', 'off');
%         set(handles.load_all_data, 'Visible', 'off');
        
frame = getframe(Synchronisation_Gait_Analysis_Right);

%         set(handles.browse1, 'Visible', 'on');       
%         set(handles.browse2, 'Visible', 'on');
%         set(handles.browse3, 'Visible', 'on');
%         set(handles.browse4, 'Visible', 'on');
%         set(handles.browse5, 'Visible', 'on');
%         set(handles.analyse, 'Visible', 'on');
%         set(handles.home, 'Visible', 'on');
%         set(handles.print, 'Visible', 'on');
%         set(handles.save, 'Visible', 'on');
%         set(handles.exit, 'Visible', 'on');
%         set(handles.load_all_data, 'Visible', 'on');


Name=Patient_ID;

            [saveFileName, saveFilePath] = uiputfile({...
 '*.bmp','bmp-Image(*.bmp)';...
%  '*.txt','txt-Files (*.txt)';...
%  '*.*',  'All Files (*.*)'
 },...
 'Save data as', Name);

            if isequal(saveFileName,0) || isequal(saveFilePath,0)
                uiwait(warndlg('No data was saved','filename error'));
                
            else
                try
%                     mkdir(saveFilePath,Name); Newpath=strcat(saveFilePath,Name)
                    fid = fopen(strcat(saveFilePath,Name,'_GaitAnalysisRight.txt'), 'wt');
                    for i=1:numel(Valu_Steplength);
                    fprintf(fid,'%-40s\t    % 5.3f\n',VarNam_Steplength{i},Valu_Steplength(i));
                    end
                    fprintf(fid,'\n','');
                    for j=1:numel(Valu_Knee_Angle);
                    fprintf(fid,'\n%-40s\t    % 5.3f',VarNam_Knee_Angle{j},Valu_Knee_Angle(j));
                    end
                    fprintf(fid,'\n','');
                    for k=1:numel(Valu_Hip_Knee_Angle);
                    fprintf(fid,'\n%-40s\t    % 5.3f',VarNam_Hip_Knee_Angle{k},Valu_Hip_Knee_Angle(k));
                    end
                    fprintf(fid,'\n','');
                    for v=1:numel(Valu_Knee_Ankle_Angle);
                    fprintf(fid,'\n%-40s\t    % 5.3f',VarNam_Knee_Ankle_Angle{v},Valu_Knee_Ankle_Angle(v));
                    end
                    fprintf(fid,'\n','');
                    for d=1:numel(Valu_Phase_difference);
                    fprintf(fid,'\n%-40s\t    % 5.3f',VarNam_Phase_difference{d},Valu_Phase_difference(d));
                    end
                    fprintf(fid,'\n\n\n\n\n%-40s\t','EVD: Extreme Value Distribution');
                    fclose(fid)
                    
                    imwrite(frame.cdata,strcat(saveFilePath,Name,'_GaitAnalysisRight.bmp'));
                    uiwait(msgbox('Data was saved successfully: ', 'Data saved', 'modal'));
                catch
                    warndlg('Could not save data', 'Data error', 'modal')
                    rethrow(lasterror);
                end;
            end;             
                      
            try
              % Update handles structure
                guidata(hObject, handles);

            catch
                return;
            end;
end
            

%% --- Executes on button press in print.
function print_Callback(hObject, eventdata, handles)
% hObject    handle to print (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI_HANDLE=Synchronisation_Gait_Analysis_Right();


        set(handles.browse1, 'Visible', 'off');       
        set(handles.browse2, 'Visible', 'off');
        set(handles.browse3, 'Visible', 'off');
        set(handles.browse4, 'Visible', 'off');
        set(handles.browse5, 'Visible', 'off');
        set(handles.analyse, 'Visible', 'off');
        set(handles.home, 'Visible', 'off');
        set(handles.print, 'Visible', 'off');
        set(handles.save, 'Visible', 'off');
        set(handles.exit, 'Visible', 'off');
        set(handles.load_all_data, 'Visible', 'off');

            set(GUI_HANDLE, 'PaperType', 'A4');
            set(GUI_HANDLE, 'PaperOrientation', 'landscape');
            set(GUI_HANDLE, 'PaperPositionMode','auto');
            set(GUI_HANDLE, 'InvertHardCopy', 'off');
            set(GUI_HANDLE, 'InvertHardCopy', 'off');
            
            print(GUI_HANDLE);
            
        set(handles.browse1, 'Visible', 'on');       
        set(handles.browse2, 'Visible', 'on');
        set(handles.browse3, 'Visible', 'on');
        set(handles.browse4, 'Visible', 'on');
        set(handles.browse5, 'Visible', 'on');
        set(handles.analyse, 'Visible', 'on');
        set(handles.home, 'Visible', 'on');
        set(handles.print, 'Visible', 'on');
        set(handles.save, 'Visible', 'on');
        set(handles.exit, 'Visible', 'on');
        set(handles.load_all_data, 'Visible', 'on');

           
            gui_data.print = 0;
            try
              % Update handles structure
                guidata(hObject, handles);

            catch
                return;
            end;
            
% Update handles structure
guidata(hObject, handles);


%% --- Executes on button press in home.
function home_Callback(hObject, eventdata, handles)
% hObject    handle to home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% if isequal(handles.home,1)
Repetitive_Movement_Analysis()
% else
% end

% Update handles structure
guidata(hObject, handles);


%% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Patient_ID ;
Patient_ID=get(handles.patient_number,'String');

str1='Yes';
str2='No';
str3='';
Qd=questdlg('do you want to save data ','Save Date',str1,str2,str1);

switch Qd
    case str1
    save_Callback()
    pause(0.2)
    return;
    
    case str2
        close(Synchronisation_Gait_Analysis_Right)
        
%         close force

    clear all
    clc
    fclose('all');
    disp(' ');
    disp('***** END Synchronisation and Gait Analysis - Right GUI *****');
    disp(' ');
    disp(' ');
    clear all;

end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


