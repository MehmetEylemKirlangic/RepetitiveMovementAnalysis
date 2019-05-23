% Program :  Repetitive Movement Analysis
% Version :  1.2
% Function:  Self_paced_Tapping_Forefoot GUI
% Author  :  Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic

function varargout = Self_paced_Tapping_Forefoot(varargin)
%SELF_PACED_TAPPING_FOREFOOT M-file for Self_paced_Tapping_Forefoot.fig
%      SELF_PACED_TAPPING_FOREFOOT, by itself, creates a new SELF_PACED_TAPPING_FOREFOOT or raises the existing
%      singleton*.
%
%      H = SELF_PACED_TAPPING_FOREFOOT returns the handle to a new SELF_PACED_TAPPING_FOREFOOT or the handle to
%      the existing singleton*.
%
%      SELF_PACED_TAPPING_FOREFOOT('Property','Value',...) creates a new SELF_PACED_TAPPING_FOREFOOT using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Self_paced_Tapping_Forefoot_OpeningFcn.  This calling syntax produces a
%
%      SELF_PACED_TAPPING_FOREFOOT('CALLBACK') and SELF_PACED_TAPPING_FOREFOOT('CALLBACK',hObject,...) call the
%      local function named CALLBACK in SELF_PACED_TAPPING_FOREFOOT.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Self_paced_Tapping_Forefoot

% Last Modified by GUIDE v2.5 17-May-2019 14:57:00

% ---------Autors:   Al-Qadhi  Safwan, Dr. Mehmet Eylem Kirlangic

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Self_paced_Tapping_Forefoot_OpeningFcn, ...
                   'gui_OutputFcn',  @Self_paced_Tapping_Forefoot_OutputFcn, ...
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

%% --- Executes just before Self_paced_Tapping_Forefoot is made visible.
function Self_paced_Tapping_Forefoot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for Self_paced_Tapping_Forefoot
handles.output = hObject;

global d; d=0;

imgFile = 'logo_juelich_300x60.jpg';
img=imread(imgFile);
image(img,'parent',handles.LogoJuelich);
set(handles.LogoJuelich,'XTick',[],'YTick',[]);
set(handles.LogoJuelich,'box','off');
set(handles.LogoJuelich,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Self_paced_Tapping_Forefoot wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%% --- Outputs from this function are returned to the command line.
function varargout = Self_paced_Tapping_Forefoot_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% --- Executes on button press in load_all_data.
function load_all_data_Callback(hObject, eventdata, handles)
% hObject    handle to load_all_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Patient_ID_file d;
global Patient_Forefoot_Left Time_Forefoot_Tapping_Left sg_Forefoot_Tapping_HPF_left;
global Patient_Forefoot_Right Time_Forefoot_Tapping_Right sg_Forefoot_Tapping_HPF_Right;

forefoot_tapping_axes(1)=handles.axes1; 
forefoot_tapping_axes(2)=handles.axes2; 
forefoot_tapping_axes(3)=handles.axes3; 
forefoot_tapping_axes(4)=handles.axes4; 

[directory_name,Patient_ID_file]=find_folder();

if isdir(directory_name) && ~isequal(directory_name,'');

look_for_this_file_Forefoot_Tapping_Left='Left_Forefoot_y_baseline.txt';
[Patient_Forefoot_Left,Patient_ID_file]=find_and_load_file_alone(look_for_this_file_Forefoot_Tapping_Left,directory_name);
    
if ~isempty(Patient_Forefoot_Left) 
    
h = waitbar(0,'load data...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h) 

d=0;
    
[Time_Forefoot_Tapping_Left,sg_Forefoot_Tapping_left,sg_Forefoot_Tapping_HPF_left]=forefoot_tapping_function(Patient_Forefoot_Left);

cla(forefoot_tapping_axes(1),'reset')
axes(forefoot_tapping_axes(1));
set(forefoot_tapping_axes(1),'XMinorTick','on')
plot(Time_Forefoot_Tapping_Left,sg_Forefoot_Tapping_left)
hold on
plot(Time_Forefoot_Tapping_Left,sg_Forefoot_Tapping_HPF_left,'r')
h=legend('Signal','BPF');
set(h,'Location','NorthEast','Orientation','vertical','Fontsize',7)
legend(forefoot_tapping_axes(1),'boxoff')
grid on

set(handles.filepath_left_tapping, 'String', Patient_Forefoot_Left,'Fontsize',7);

else
      cla(forefoot_tapping_axes(1))
      set(forefoot_tapping_axes(1),'XGrid','on','YGrid','on')
      cla(forefoot_tapping_axes(3))
      set(forefoot_tapping_axes(3),'XGrid','on','YGrid','on')
      Time_Forefoot_Tapping_Left='';
      sg_Forefoot_Tapping_HPF_left='';
end 

look_for_this_file_Forefoot_Tapping_Right='Right_Forefoot_y_baseline.txt';
[Patient_Forefoot_Right,Patient_ID_file]=find_and_load_file_alone(look_for_this_file_Forefoot_Tapping_Right,directory_name);
    
if ~isempty(Patient_Forefoot_Right) 
h = waitbar(0,'load data...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h) 
    
[Time_Forefoot_Tapping_Right,sg_Forefoot_Tapping_Right,sg_Forefoot_Tapping_HPF_Right]=forefoot_tapping_function(Patient_Forefoot_Right);

cla(forefoot_tapping_axes(2),'reset')
axes(forefoot_tapping_axes(2));
set(forefoot_tapping_axes(2),'XMinorTick','on')
plot(Time_Forefoot_Tapping_Right,sg_Forefoot_Tapping_Right)
hold on
plot(Time_Forefoot_Tapping_Right,sg_Forefoot_Tapping_HPF_Right,'r')
h=legend('Signal','BPF');
set(h,'Location','NorthEast','Orientation','vertical','Fontsize',7)
legend(forefoot_tapping_axes(2),'boxoff')
grid on

set(handles.filepath_right_tapping, 'String', Patient_Forefoot_Right,'Fontsize',7);

else
      cla(forefoot_tapping_axes(2))
      set(forefoot_tapping_axes(2),'XGrid','on','YGrid','on')
      cla(forefoot_tapping_axes(4))
      set(forefoot_tapping_axes(4),'XGrid','on','YGrid','on')
      Time_Forefoot_Tapping_Right='';
      sg_Forefoot_Tapping_HPF_Right='';
end 

set(handles.patient_number_forefoot_tapping,'String',Patient_ID_file)

end % if isdir

% Update handles structure
guidata(hObject, handles);

%% --- Executes on button press in load_file_left_Forefoot.
function load_file_left_Forefoot_Callback(hObject, eventdata, handles)
% hObject    handle to load_file_left_Forefoot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Patient_Forefoot_Left Time_Forefoot_Tapping_Left sg_Forefoot_Tapping_HPF_left d;

forefoot_tapping_axes(1)=handles.axes1;

[Patient_Forefoot_Left] = Load_file();

if ~isempty(Patient_Forefoot_Left) 
h = waitbar(0,'load data...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h) 

d=0;
    
[Time_Forefoot_Tapping_Left,sg_Forefoot_Tapping_left,sg_Forefoot_Tapping_HPF_left]=forefoot_tapping_function(Patient_Forefoot_Left);

if ~isempty(sg_Forefoot_Tapping_left)

cla(forefoot_tapping_axes(1),'reset')
axes(forefoot_tapping_axes(1));
set(forefoot_tapping_axes(1),'XMinorTick','on')
plot(Time_Forefoot_Tapping_Left,sg_Forefoot_Tapping_left)
hold on
plot(Time_Forefoot_Tapping_Left,sg_Forefoot_Tapping_HPF_left,'r')
h=legend('Signal','HPF');
set(h,'Location','NorthEast','Orientation','vertical','Fontsize',7)
legend(forefoot_tapping_axes(1),'boxoff')
grid on

set(handles.patient_number_forefoot_tapping,'String','');
set(handles.filepath_left_tapping, 'String', Patient_Forefoot_Left,'Fontsize',7);
else 
    return;
end
else
end 

% Update handles structure
guidata(hObject, handles);

%% --- Executes on button press in pushbutton18.
function load_file_right_Forefoot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Patient_Forefoot_Right Time_Forefoot_Tapping_Right sg_Forefoot_Tapping_Right sg_Forefoot_Tapping_HPF_Right d;

forefoot_tapping_axes(2)=handles.axes2;

[Patient_Forefoot_Right] = Load_file();

if ~isempty(Patient_Forefoot_Right) 
h = waitbar(0,'load data...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h) 

d=0;
    
[Time_Forefoot_Tapping_Right,sg_Forefoot_Tapping_Right,sg_Forefoot_Tapping_HPF_Right]=forefoot_tapping_function(Patient_Forefoot_Right);

if ~isempty(sg_Forefoot_Tapping_Right)
    
cla(forefoot_tapping_axes(2),'reset')
axes(forefoot_tapping_axes(2));
set(forefoot_tapping_axes(2),'XMinorTick','on')
plot(Time_Forefoot_Tapping_Right,sg_Forefoot_Tapping_Right)
hold on
plot(Time_Forefoot_Tapping_Right,sg_Forefoot_Tapping_HPF_Right,'r')
h=legend('Signal','HPF');
set(h,'Location','NorthEast','Orientation','vertical','Fontsize',7)
legend(forefoot_tapping_axes(2),'boxoff')
grid on

set(handles.patient_number_forefoot_tapping,'String','');
set(handles.filepath_right_tapping, 'String', Patient_Forefoot_Right,'Fontsize',7);

else
    return;
end 

else     
end   % if ~isempty(Patient_Forefoot_Right)

% Update handles structure
guidata(hObject, handles);

%% --- Executes on button press in analyse.
function analyse_Callback(hObject, eventdata, handles)
% hObject    handle to analyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Patient_Forefoot_Left Time_Forefoot_Tapping_Left sg_Forefoot_Tapping_HPF_left;
global Patient_Forefoot_Right Time_Forefoot_Tapping_Right sg_Forefoot_Tapping_HPF_Right;
global Left_measure_Time Right_measure_Time;
global VarNam_Left Valu_Left VarNam_Right Valu_Right;

forefoot_tapping_axes(3)=handles.axes3;
forefoot_tapping_axes(4)=handles.axes4;

% if  isempty(Patient_Forefoot_Left) & isempty( sg_Forefoot_Tapping_HPF_left)
%     errordlg('Please load data first ...','Error');
%     return;
% end   

if  ~isempty(Time_Forefoot_Tapping_Left) && ~isempty(sg_Forefoot_Tapping_HPF_left)

[Tippingrate_Left_max,Tippingrate_Left_min,Left_mean_max,Left_mean_min,...
    Left_std_max,Left_std_min,Time_ind_Left_max,Time_ind_Left_min,...
    Left_mean_max_min,Left_std_min_max,Left_measure_Time,Time_plot1_Left,Time_plot2_Left]=...
    forefoot_tapping_analys(Time_Forefoot_Tapping_Left,sg_Forefoot_Tapping_HPF_left);

   VarNam_Left={'Mean maxima Tappingrate Forefoot Left in Hz','Mean minima Tappingrate Forefoot Left in Hz','Mean maxima Amplitude Forefoot Left in cm ',...
       'Mean minima Amplitude Forefoot Left in cm ','std. maxima Tappingrate Forefoot Left','std. minima Tappingrate Forefoot Left',...
       'Mean max and min Tappingrate Forefoot Left in Hz','std. max and min Tappingrate Forefoot Left','Duration in sec                         '};
  
   Valu_Left=cell2mat({Tippingrate_Left_max,Tippingrate_Left_min,Left_mean_max, Left_mean_min,...
            Left_std_max,Left_std_min,Left_mean_max_min, Left_std_min_max, Left_measure_Time});

cla(forefoot_tapping_axes(3))
axes(forefoot_tapping_axes(3));
set(forefoot_tapping_axes(3),'XMinorTick','on')
plot(Time_plot1_Left(1:end-1),Time_ind_Left_max,'r.','Markersize',15.0)
hold on
plot(Time_plot2_Left(1:end-1),Time_ind_Left_min,'.','Markersize',15.0)
h=legend('Max','Min');
set(h,'Location','NorthEast','Orientation','vertical','Fontsize',8)
legend(forefoot_tapping_axes(3),'boxoff')
grid on

set(handles.Tippingrate_Left_max,'String',Valu_Left(1),'Fontsize',8,'fontweight','b');
set(handles.Tippingrate_Left_min,'String',Valu_Left(2),'Fontsize',8,'fontweight','b');
set(handles.Left_mean_max,'String',Valu_Left(3),'Fontsize',8,'fontweight','b');
set(handles.Left_mean_min,'String',Valu_Left(4),'Fontsize',8,'fontweight','b');
set(handles.Left_std_max,'String',Valu_Left(5),'Fontsize',8,'fontweight','b');
set(handles.Left_std_min,'String',Valu_Left(6),'Fontsize',8,'fontweight','b');
set(handles.Left_mean_max_min,'String',Valu_Left(7),'Fontsize',8,'fontweight','b');
set(handles.Left_std_min_max,'String',Valu_Left(8),'Fontsize',8,'fontweight','b');
set(handles.Left_measure_Time,'String',Valu_Left(9),'Fontsize',8,'fontweight','b');

else
set(handles.Tippingrate_Left_max,'String','');
set(handles.Tippingrate_Left_min,'String','');
set(handles.Left_mean_max,'String','');
set(handles.Left_mean_min,'String','');
set(handles.Left_std_max,'String','');
set(handles.Left_std_min,'String','');
set(handles.Left_mean_max_min,'String','');
set(handles.Left_std_min_max,'String','');
set(handles.Left_measure_Time,'String','');    
end


if  ~isempty(Time_Forefoot_Tapping_Right)&& ~isempty(sg_Forefoot_Tapping_HPF_Right)
    
[Tippingrate_Right_max,Tippingrate_Right_min,Right_mean_max,Right_mean_min,...
    Right_std_max,Right_std_min,Time_ind_Right_max,Time_ind_Right_min,...
    Right_mean_max_min,Right_std_min_max,Right_measure_Time,Time_plot1_Right,Time_plot2_Right]=...
    forefoot_tapping_analys(Time_Forefoot_Tapping_Right,sg_Forefoot_Tapping_HPF_Right);

VarNam_Right={'Mean maxima Tappingrate Forefoot Right in Hz','Mean minima Tappingrate Forefoot Right in Hz','Mean maxima Amplitude Forefoot Right in cm ',...
       'Mean minima Amplitude Forefoot Right in cm  ','std. maxima Tappingrate Forefoot Right','std. minima Tappingrate Forefoot Right',...
       'Mean max and min Tappingrate Forefoot Right in Hz','std. max and min Tappingrate Forefoot Right','Duration  in sec                        '};
  
   Valu_Right=cell2mat({Tippingrate_Right_max,Tippingrate_Right_min,Right_mean_max,Right_mean_min,...
            Right_std_max,Right_std_min,Right_mean_max_min, Right_std_min_max,Right_measure_Time});

cla(forefoot_tapping_axes(4))
axes(forefoot_tapping_axes(4));
set(forefoot_tapping_axes(4),'XMinorTick','on')
plot(Time_plot1_Right(1:end-1),Time_ind_Right_max,'r.','Markersize',15.0)
hold on
plot(Time_plot2_Right(1:end-1),Time_ind_Right_min,'.','Markersize',15.0)
h=legend('Max','Min');
set(h,'Location','NorthEast','Orientation','vertical','Fontsize',8)
legend(forefoot_tapping_axes(4),'boxoff')
grid on

set(handles.Tippingrate_Right_max,'String',Valu_Right(1),'Fontsize',8,'fontweight','b');
set(handles.Tippingrate_Right_min,'String',Valu_Right(2),'Fontsize',8,'fontweight','b');
set(handles.Right_mean_max,'String',Valu_Right(3),'Fontsize',8,'fontweight','b');
set(handles.Right_mean_min,'String',Valu_Right(4),'Fontsize',8,'fontweight','b');
set(handles.Right_std_max,'String',Valu_Right(5),'Fontsize',8,'fontweight','b');
set(handles.Right_std_min,'String',Valu_Right(6),'Fontsize',8,'fontweight','b');
set(handles.Right_mean_max_min,'String',Valu_Right(7),'Fontsize',8,'fontweight','b');
set(handles.Right_std_min_max,'String',Valu_Right(8),'Fontsize',8,'fontweight','b');
set(handles.Right_measure_Time,'String',Valu_Right(9),'Fontsize',8,'fontweight','b');

else
set(handles.Tippingrate_Right_max,'String','');
set(handles.Tippingrate_Right_min,'String','');
set(handles.Right_mean_max,'String','');
set(handles.Right_mean_min,'String','');
set(handles.Right_std_max,'String','');
set(handles.Right_std_min,'String','');
set(handles.Right_mean_max_min,'String','');
set(handles.Right_std_min_max,'String','');
set(handles.Right_measure_Time,'String','');    
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

         forefoot_tapping_axes(1)=handles.axes1;
         forefoot_tapping_axes(2)=handles.axes2;
         forefoot_tapping_axes(3)=handles.axes3;
         forefoot_tapping_axes(4)=handles.axes4;

         str=get(handles.select_graph, 'String');
         val=str2double(str{get(handles.select_graph, 'value')});
       
if isnan(val) 
errordlg('please select graph first','Error');
return;
end
             
if X_start >= X_end
    errordlg('Input must be smaller than end','Error');
    set(hObject, 'String', 0);
    X_start=str2double(get(hObject,'String'));
    set(handles.axes1,'Xlim',[X_start X_end]);
    
elseif isnan(X_start)
    errordlg('Input must be a number','Error');
    set(hObject, 'String', 0);
    X_start=str2double(get(hObject,'String'));
    set(handles.axes1,'Xlim',[X_start X_end]);
else

set(forefoot_tapping_axes(val),'Xlim',[X_start X_end]);
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
global Left_measure_Time Right_measure_Time;

X_end=str2double(get(handles.x_end,'String'));
X_start=str2double(get(handles.x_start,'String'));

         forefoot_tapping_axes(1)=handles.axes1;
         forefoot_tapping_axes(2)=handles.axes2;
         forefoot_tapping_axes(3)=handles.axes3;
         forefoot_tapping_axes(4)=handles.axes4;

         str=get(handles.select_graph, 'String');
         val=str2double(str{get(handles.select_graph, 'value')});

if isnan(val) 
errordlg('please select graph first','Error');
return;
end

if X_end <= X_start
    errordlg('Input must be bigger than start','Error');
    set(hObject, 'String', 25);
    X_end=str2double(get(hObject,'String'));
    set(forefoot_tapping_axes(val),'Xlim',[X_start Right_measure_Time+2]);
    
elseif isnan(X_end)
    set(hObject, 'String', 25);
    errordlg('Input must be a number','Error');
    X_end=str2double(get(hObject,'String'));
    set(forefoot_tapping_axes(val),'Xlim',[X_start X_end]);

else
set(forefoot_tapping_axes(val),'Xlim',[X_start X_end]);
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
%%
function patient_number_forefoot_tapping_Callback(hObject, eventdata, handles)
% hObject    handle to patient_number_forefoot_tapping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of patient_number_forefoot_tapping as text
%        str2double(get(hObject,'String')) returns contents of patient_number_forefoot_tapping as a double

global Patient_ID Patient_ID_file;

Patient_ID=get(hObject,'String');

% if ~isempty(Patient_ID)
%     Patient_ID='';    
% else
%     Patient_ID=Patient;
% end
% --- Executes during object creation, after setting all properties.
function patient_number_forefoot_tapping_CreateFcn(hObject, eventdata, handles)
% hObject    handle to patient_number_forefoot_tapping (see GCBO)
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

global Patient_ID Patient_ID_file;
global VarNam_Left Valu_Left VarNam_Right Valu_Right;;

try
Patient_ID=get(handles.patient_number_forefoot_tapping,'String');
catch
end
  
if isempty(Patient_ID),
     pause(0.2);
     uiwait(errordlg('Please enter Patient ID and press save ...', 'Error', 'modal'))
     return;     
else
%         set(handles.load_all_data, 'Visible', 'off');       
%         set(handles.load_file_left_Forefoot, 'Visible', 'off');
%         set(handles.pushbutton18, 'Visible', 'off');
%         set(handles.axes_tools, 'Visible', 'off');
%         set(handles.forward, 'Visible', 'off');
%         set(handles.backward, 'Visible', 'off');
%         set(handles.analyse, 'Visible', 'off');
%         set(handles.home, 'Visible', 'off');
%         set(handles.print, 'Visible', 'off');
%         set(handles.save, 'Visible', 'off');
%         set(handles.exit, 'Visible', 'off');
        
frame = getframe(Self_paced_Tapping_Forefoot);

%         set(handles.load_all_data, 'Visible', 'on');       
%         set(handles.load_file_left_Forefoot, 'Visible', 'on');
%         set(handles.pushbutton18, 'Visible', 'on');
%         set(handles.axes_tools, 'Visible', 'on');
%         set(handles.forward, 'Visible', 'on');
%         set(handles.backward, 'Visible', 'on');
%         set(handles.analyse, 'Visible', 'on');
%         set(handles.home, 'Visible', 'on');
%         set(handles.print, 'Visible', 'on');
%         set(handles.save, 'Visible', 'on');
%         set(handles.exit, 'Visible', 'on');

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
                    fid = fopen(strcat(saveFilePath,Name,'_ForefootTappingLeft.txt'), 'wt');
                    for i=1:numel(Valu_Left);
                    fprintf(fid,'%-50s\t    % 5.3f\n',VarNam_Left{i},Valu_Left(i));
                    end
                    fclose(fid)
%                     fid = fopen(strcat(saveFilePath,Name,'_ForefootTappingLeft.csv'), 'wt');
%                     for i=1:numel(Valu_Left);
%                     fprintf(fid,'%s         %10.4f\n',VarNam_Left{i},Valu_Left(i));
%                     end
%                     fclose(fid)
                    fid = fopen(strcat(saveFilePath,Name,'_ForefootTappingRight.txt'), 'wt');
                    for i=1:numel(Valu_Right);
                    fprintf(fid,'%-50s\t    % 5.3f\n',VarNam_Right{i},Valu_Right(i));
                    end
                    fclose(fid)
                    
                    imwrite(frame.cdata,strcat(saveFilePath,Name,'_Forefoot_Tapping.bmp'));
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

GUI_HANDLE=Self_paced_Tapping_Forefoot();

        set(handles.load_all_data, 'Visible', 'off');       
        set(handles.load_file_left_Forefoot, 'Visible', 'off');
        set(handles.pushbutton18, 'Visible', 'off');
        set(handles.axes_tools, 'Visible', 'off');
        set(handles.forward, 'Visible', 'off');
        set(handles.backward, 'Visible', 'off');
        set(handles.analyse, 'Visible', 'off');
        set(handles.home, 'Visible', 'off');
        set(handles.print, 'Visible', 'off');
        set(handles.save, 'Visible', 'off');
        set(handles.exit, 'Visible', 'off');
        
            set(GUI_HANDLE, 'PaperType', 'A4');
            set(GUI_HANDLE, 'PaperOrientation', 'landscape');
            set(GUI_HANDLE, 'PaperPositionMode','auto');
            set(GUI_HANDLE, 'InvertHardCopy', 'off');
            set(GUI_HANDLE, 'InvertHardCopy', 'off');
            
            print(GUI_HANDLE);
            
        set(handles.load_all_data, 'Visible', 'on');       
        set(handles.load_file_left_Forefoot, 'Visible', 'on');
        set(handles.pushbutton18, 'Visible', 'on');
        set(handles.axes_tools, 'Visible', 'on');
        set(handles.forward, 'Visible', 'on');
        set(handles.backward, 'Visible', 'on');
        set(handles.analyse, 'Visible', 'on');
        set(handles.home, 'Visible', 'on');
        set(handles.print, 'Visible', 'on');
        set(handles.save, 'Visible', 'on');
        set(handles.exit, 'Visible', 'on');
           
            gui_data.print = 0;
            try
              % Update handles structure
                guidata(hObject, handles);

            catch
                return;
            end;
            
%% --- Executes on button press in home.
function home_Callback(hObject, eventdata, handles)
% hObject    handle to home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Repetitive_Movement_Analysis()

%% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Patient_ID Patient_ID_file;
Patient_ID=get(handles.patient_number_forefoot_tapping,'String');

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
        close(Self_paced_Tapping_Forefoot)
        
clear all
clc
fclose('all');
disp(' ');
disp('***** END Self-paced Tapping Analysis - Forefoot GUI *****');
disp(' ');
disp(' ');
clear all;

end

%% --- Executes on selection change in select_graph.
function select_graph_Callback(hObject, eventdata, handles)
% hObject    handle to select_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns select_graph contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select_graph

global d;
d=0;

         str=get(handles.select_graph, 'String');
         val=get(handles.select_graph, 'value');
            
         switch str{val}
             
         case '' % User select.
             
         case '1' % User select.
             
         case '2' % User select.
             
         case '3' % User select.
             
         case '4' % User select.
             
         end

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
          '4'});
      
          
%%
function show_Callback(hObject, eventdata, handles)
% hObject    handle to show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of show as text
%        str2double(get(hObject,'String')) returns contents of show as a double

global d;
d=0;

% --- Executes during object creation, after setting all properties.
function show_CreateFcn(hObject, eventdata, handles)
% hObject    handle to show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% --- Executes on button press in forward.
function forward_Callback(hObject, eventdata, handles)
% hObject    handle to forward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
         
         
       global d;
       global Left_measure_Time Right_measure_Time;

        a=get(hObject,'value');
        d=a+d;
     
       
         forefoot_tapping_axes(1)=handles.axes1;
         forefoot_tapping_axes(2)=handles.axes2;
         forefoot_tapping_axes(3)=handles.axes3;
         forefoot_tapping_axes(4)=handles.axes4;
         
         intervall=str2double(get(handles.show,'String'));
         if intervall==0
             intervall=1;
         end
         
         str=get(handles.select_graph, 'String');
         val=str2double(str{get(handles.select_graph, 'value')});
         
if isnan(val) 
errordlg('please select graph first','Error');
return;
elseif isequal(val,3) || isequal(val,4)
return;
end
         
         switch val
             case 1
             dauer=Left_measure_Time;
             case 2
             dauer=Right_measure_Time; 
         end
         
         cond=round(dauer/intervall);
         
         
         if d*intervall>0 & d*intervall<=round(dauer)+intervall
         
         set(forefoot_tapping_axes(val),'Xlim',[ (d-1)*intervall  (d-1)*intervall+intervall]); 
         
         end
         
         if d<0 
           d=0;
         end
         if d>=cond
           d=cond;
         end
         
         % Update handles structure
         guidata(hObject, handles);

%% --- Executes on button press in backward.
function backward_Callback(hObject, eventdata, handles)
% hObject    handle to backward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

       global d;
       global Left_measure_Time Right_measure_Time;
       
        a=get(hObject,'value');
        d=d-a;
        
        if sign(d)==-1
            d=0;
        end
       
         forefoot_tapping_axes(1)=handles.axes1;
         forefoot_tapping_axes(2)=handles.axes2;
         forefoot_tapping_axes(3)=handles.axes3;
         forefoot_tapping_axes(4)=handles.axes4;
         
         intervall=str2double(get(handles.show,'String'));
         if intervall==0
             intervall=1;
         end
         
         str=get(handles.select_graph, 'String');
         val=str2double(str{get(handles.select_graph, 'value')});
         
         if isnan(val) 
         errordlg('please select graph first','Error');
         return;
         elseif isequal(val,3) || isequal(val,4)
         return;
         end
         
         switch val
             case 1
             dauer=Left_measure_Time;
             case 2
             dauer=Right_measure_Time; 
         end
         
         cond=round(dauer/intervall);
         
         if d*intervall>=0 & d*intervall<=round(dauer)+intervall
         set(forefoot_tapping_axes(val),'Xlim',[ (d+1)*intervall-intervall  (d+1)*intervall]); 
         end

         if d<0 
            d=0;
         end
         if d>cond
            d=cond;
         end
       
         % Update handles structure
         guidata(hObject, handles);



function patient_number_Forefoot_tapping_Callback(hObject, eventdata, handles)
% hObject    handle to patient_number_Forefoot_tapping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of patient_number_Forefoot_tapping as text
%        str2double(get(hObject,'String')) returns contents of patient_number_Forefoot_tapping as a double


% --- Executes during object creation, after setting all properties.
function patient_number_Forefoot_tapping_CreateFcn(hObject, eventdata, handles)
% hObject    handle to patient_number_Forefoot_tapping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



