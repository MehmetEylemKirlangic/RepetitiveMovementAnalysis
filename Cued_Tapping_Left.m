% Program :  Repetitive Movement Analysis
% Version :  1.2
% Function:  Cued_Tapping_Left GUI
% Authors  :  Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic

%%
function varargout = Cued_Tapping_Left(varargin)
%CUED_TAPPING_LEFT M-file for Cued_Tapping_Left.fig
%      CUED_TAPPING_LEFT, by itself, creates a new CUED_TAPPING_LEFT or raises the existing
%      singleton*.
%
%      H = CUED_TAPPING_LEFT returns the handle to a new CUED_TAPPING_LEFT or the handle to
%      the existing singleton*.
%
%      CUED_TAPPING_LEFT('Property','Value',...) creates a new CUED_TAPPING_LEFT using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Cued_Tapping_Left_OpeningFcn.  This calling syntax produces a
%
%      CUED_TAPPING_LEFT('CALLBACK') and CUED_TAPPING_LEFT('CALLBACK',hObject,...) call the
%      local function named CALLBACK in CUED_TAPPING_LEFT.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Cued_Tapping_Left

% Last Modified by GUIDE v2.5 18-May-2019 12:13:58

% ---------Autors:   Al-Qadhi  Safwan, Dr. Mehmet Eylem Kirlangic

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Cued_Tapping_Left_OpeningFcn, ...
                   'gui_OutputFcn',  @Cued_Tapping_Left_OutputFcn, ...
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

% --- Executes just before Cued_Tapping_Left is made visible.
function Cued_Tapping_Left_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for Cued_Tapping_Left
handles.output = hObject;
global d;
d=0;

imgFile = 'logo_juelich_300x60.jpg';
img=imread(imgFile);
image(img,'parent',handles.LogoJuelich);
set(handles.LogoJuelich,'XTick',[],'YTick',[]);
set(handles.LogoJuelich,'box','off');
set(handles.LogoJuelich,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Cued_Tapping_Left wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Cued_Tapping_Left_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% --- Executes on button press in browes1.
function browes1_Callback(hObject, eventdata, handles)
% hObject    handle to browes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Time_paced_tapp_Left sg_paced_tapp_Left;
global Patient_ID_file d;


hand_paced_tapp_left_axes(1)=handles.axes1;
hand_paced_tapp_left_axes(2)=handles.axes2;
hand_paced_tapp_left_axes(3)=handles.axes3;
hand_paced_tapp_left_axes(4)=handles.axes4;
hand_paced_tapp_left_axes(5)=handles.axes5;

[directory_name,Patient_ID_file]=find_folder();

if isdir(directory_name) && ~isequal(directory_name,'');

look_for_this_file_paced_tapp_left='Left_paced_y_baseline.txt';
[Patient_Paced_Tapp_Left,Patient_ID_file]=find_and_load_file_alone(look_for_this_file_paced_tapp_left,directory_name);
    
if ~isempty(Patient_Paced_Tapp_Left) 
    
h = waitbar(0,'load data...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h) 
d=0;
    
[Time_paced_tapp_Left,sg_paced_tapp_Left]=paced_tapping_function(Patient_Paced_Tapp_Left);

if isempty(sg_paced_tapp_Left)
    return;
end

cla(hand_paced_tapp_left_axes(1),'reset')
axes(hand_paced_tapp_left_axes(1));
set(hand_paced_tapp_left_axes(1),'XMinorTick','on')
plot(Time_paced_tapp_Left,sg_paced_tapp_Left)
grid on

set(handles.patient_number,'String',Patient_ID_file,'Fontsize',8);

else
      cla(hand_paced_tapp_left_axes(1))
      set(hand_paced_tapp_left_axes(1),'XGrid','on','YGrid','on')
      cla(hand_paced_tapp_left_axes(2))
      set(hand_paced_tapp_left_axes(2),'XGrid','on','YGrid','on')
      cla(hand_paced_tapp_left_axes(3))
      set(hand_paced_tapp_left_axes(3),'XGrid','on','YGrid','on')
      cla(hand_paced_tapp_left_axes(4))
      set(hand_paced_tapp_left_axes(4),'XGrid','on','YGrid','on')
      cla(hand_paced_tapp_left_axes(5))
      set(hand_paced_tapp_left_axes(5),'XGrid','on','YGrid','on')
      Time_paced_tapp_Left='';
      sg_paced_tapp_Left='';
end 

look_for_this_file_paced_tapp_left_vilocity='Left_paced_y_velocity.txt';
[Patient_Paced_Tapp_Left_velocity,Patient_ID_file]=find_and_load_file_alone(look_for_this_file_paced_tapp_left_vilocity,directory_name);

if ~isempty(Patient_Paced_Tapp_Left_velocity) 
    
h = waitbar(0,'load data...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h) 
    
[Time_Paced_Tapp_Left_velocity,sg_Paced_Tapp_Left_velocity]=paced_tapping_vilocity(Patient_Paced_Tapp_Left_velocity);

cla(hand_paced_tapp_left_axes(4),'reset')
axes(hand_paced_tapp_left_axes(4));
set(hand_paced_tapp_left_axes(4),'XMinorTick','on')
plot(sg_paced_tapp_Left,sg_Paced_Tapp_Left_velocity)
grid on

elseif ~isempty(Patient_Paced_Tapp_Left) 
    
      cla(hand_paced_tapp_left_axes(4),'reset')
      axes(hand_paced_tapp_left_axes(4));
      set(hand_paced_tapp_left_axes(4),'XMinorTick','on')
      plot(sg_paced_tapp_Left(1:end-1),diff(sg_paced_tapp_Left))
      grid on

end

set(handles.Filepath_Patient_text, 'String', Patient_Paced_Tapp_Left,'Fontsize',7);
set(handles.Filepath_Vilocity_text, 'String', Patient_Paced_Tapp_Left_velocity,'Fontsize',7);
else
end

% Update handles structure
guidata(hObject, handles);

%% --- Executes on button press in browse2.
function browse2_Callback(hObject, eventdata, handles)
% hObject    handle to browse2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Time_paced_tapp_Left sg_paced_tapp_Left d;

hand_paced_tapp_left_axes(1)=handles.axes1;
hand_paced_tapp_left_axes(4)=handles.axes4;

[Patient_Paced_Tapp_Left] = Load_file();

if ~isempty(Patient_Paced_Tapp_Left) 
h = waitbar(0,'load data...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h)
d=0;
    
[Time_paced_tapp_Left,sg_paced_tapp_Left]=paced_tapping_function(Patient_Paced_Tapp_Left);

if ~isempty(sg_paced_tapp_Left)

cla(hand_paced_tapp_left_axes(1),'reset')
axes(hand_paced_tapp_left_axes(1));
set(hand_paced_tapp_left_axes(1),'XMinorTick','on')
plot(Time_paced_tapp_Left,sg_paced_tapp_Left)
grid on

set(handles.patient_number,'String','');
set(handles.Filepath_Patient_text, 'String', Patient_Paced_Tapp_Left,'Fontsize',7);
else 
    return;
end
else
end 

%%
if ~isempty(Patient_Paced_Tapp_Left) 
pause(0.3)
uiwait(helpdlg('please select "Velocity-Left" file of the same person!','Select Velocity file'));
pause(0.3)
else 
    return;
end

[Patient_Paced_Tapp_Left_vilocity] = Load_file();

if ~isempty(Patient_Paced_Tapp_Left_vilocity) 
h = waitbar(0,'load data...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h) 
    
[Time_paced_tapp_Left_vilocity,sg_paced_tapp_Left_vilocity]=paced_tapping_function(Patient_Paced_Tapp_Left_vilocity);

if numel(sg_paced_tapp_Left)~=numel(sg_paced_tapp_Left_vilocity)
    uiwait(errordlg('There is a problem with the ASCII-file or you have selected the wrong one!','Error'));
    
elseif ~isempty(sg_paced_tapp_Left) 

cla(hand_paced_tapp_left_axes(4),'reset')
axes(hand_paced_tapp_left_axes(4));
set(hand_paced_tapp_left_axes(4),'XMinorTick','on')
plot(sg_paced_tapp_Left,sg_paced_tapp_Left_vilocity)
grid on

set(handles.patient_number,'String','');
set(handles.Filepath_Vilocity_text, 'String', Patient_Paced_Tapp_Left_vilocity,'Fontsize',7);
else 
    return;
end
else
end 

% Update handles structure
guidata(hObject, handles);


%% --- Executes on button press in analyse.
function analyse_Callback(hObject, eventdata, handles)
% hObject    handle to analyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Time_paced_tapp_Left sg_paced_tapp_Left duration;
global VarNam_Paced_Left Valu_Paced_Left;

hand_paced_tapp_left_axes(2)=handles.axes2; 
hand_paced_tapp_left_axes(3)=handles.axes3; 
hand_paced_tapp_left_axes(4)=handles.axes4; 
hand_paced_tapp_left_axes(5)=handles.axes5; 

if  ~isempty(Time_paced_tapp_Left) && ~isempty(sg_paced_tapp_Left)

% set(handles.x_start,'String',0);
% set(handles.x_end,'String',130);

duration=Time_paced_tapp_Left(end);

 [imx2d2,T_plot,freq_ton_plot,freq_ton, audio_plot]=audio_tapp_freq();
 
 [freq_patie,freq_patie_plot,imx2d3]=patient_tapping_frequency(sg_paced_tapp_Left);
[Ton_Phase,Tapp_Phase,RMS,m_falling,m_reising,max_falling,max_reising,freq_falling,freq_reising,T_diff,F_]=...
    pace_tapp_analyse(imx2d2,imx2d3,freq_ton,freq_patie,Time_paced_tapp_Left);


VarNam_Paced_Left={'RMS','Error falling','Error rising',...
       'Max. error falling in Hz','Max. error rising in Hz','Max. error falling by the frequency: in Hz',...
       'Max. error rising by the frequency: in Hz','Duration in sec'};
  
Valu_Paced_Left=cell2mat({RMS,m_falling,m_reising, max_falling/6,...
            abs(max_reising)/6,freq_falling(1),freq_reising(1),duration});

%% Preparation of Data to plot

h = waitbar(0,'Processing Data...');
for i=1:100, % computation here %
waitbar(i/100)
end
close(h)

cla(hand_paced_tapp_left_axes(2))
axes(hand_paced_tapp_left_axes(2));
plot(Time_paced_tapp_Left,freq_patie_plot(1:length(Time_paced_tapp_Left))./12,'r')
% title('Comparing rate of Tones and Tapping','Fontsize',8)
hold on
plot(T_plot,freq_ton_plot./6,':','Markersize',15.0)
% 'Color',[0.7 0.7 0.7]
axis([0 130 0 7])
h=legend('Tapping','Tones');
set(hand_paced_tapp_left_axes(2),'XMinorTick','on')
set(h,'Location','South','Orientation','horizontal','Interpreter','none','Fontsize',7)
legend(hand_paced_tapp_left_axes(2),'boxoff')
grid off

cla(hand_paced_tapp_left_axes(3))
axes(hand_paced_tapp_left_axes(3));
plot(imx2d3(1:end-1)./50,Tapp_Phase,'r.')
title('\Deltat of tones and \Deltat of tapping','Fontsize',8)
% title('Tones rate','Fontsize',8)
 axis([0 130 0 1.4])
hold on
plot(imx2d2(1:end-1)./50,Ton_Phase,'b')
set(hand_paced_tapp_left_axes(3),'XMinorTick','on')
h1=legend('Tapping','Tones');
set(h1,'Location','North','Orientation','horizontal','Interpreter','none','Fontsize',7)
legend(hand_paced_tapp_left_axes(3),'boxoff')
grid on

cla(hand_paced_tapp_left_axes(5))
axes(hand_paced_tapp_left_axes(5));
plot(F_,T_diff,'.','Color',[0.3,0.4,0.2])
axis([0 F_(end)+5 -0.5 1.5])
title('\Deltat between tone and tapping','Fontsize',8)
set(hand_paced_tapp_left_axes(5),'XMinorTick','on')
grid on

set(handles.rms,'String',Valu_Paced_Left(1),'Fontsize',8,'fontweight','b');
set(handles.falling,'String',Valu_Paced_Left(2),'Fontsize',8,'fontweight','b');
set(handles.rising,'String',Valu_Paced_Left(3),'Fontsize',8,'fontweight','b');
set(handles.max_falling,'String',strcat(num2str(Valu_Paced_Left(4)) ,'Hz','@',num2str(freq_falling(1)),'Hz'),'Fontsize',8,'fontweight','b');
set(handles.max_rising,'String',strcat(num2str(abs(Valu_Paced_Left(5))),'Hz','@',num2str(freq_reising(1)),'Hz'),'Fontsize',8,'fontweight','b');
set(handles.duration,'String',strcat(num2str(duration),'sec'),'Fontsize',8,'fontweight','b');

else 
    set(handles.rising,'String','');
    set(handles.falling,'String','');
    set(handles.rms,'String','');  
    set(handles.max_falling,'String','');
    set(handles.max_rising,'String','');
    set(handles.duration,'String','');
    errordlg('Please load file first ...','Error');
    return;
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

         hand_paced_tapp_left_axes(1)=handles.axes1;
         hand_paced_tapp_left_axes(2)=handles.axes2;
         hand_paced_tapp_left_axes(3)=handles.axes3;
         hand_paced_tapp_left_axes(4)=handles.axes4;
         hand_paced_tapp_left_axes(5)=handles.axes5;

         str=get(handles.select_graph, 'String');
         val=str2double(str{get(handles.select_graph, 'value')});
       
if isnan(val) 
    errordlg('please select graph first','Error');
    return;
elseif isequal(val,4) 
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

set(hand_paced_tapp_left_axes(val),'Xlim',[X_start X_end]);
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

         hand_paced_tapp_left_axes(1)=handles.axes1;
         hand_paced_tapp_left_axes(2)=handles.axes2;
         hand_paced_tapp_left_axes(3)=handles.axes3;
         hand_paced_tapp_left_axes(4)=handles.axes4;
         hand_paced_tapp_left_axes(5)=handles.axes5;

         str=get(handles.select_graph, 'String');
         val=str2double(str{get(handles.select_graph, 'value')});
       
if isnan(val) 
    errordlg('please select graph first','Error');
    return;
elseif isequal(val,4) 
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

set(hand_paced_tapp_left_axes(val),'Xlim',[X_start X_end]);
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
function patient_number_Callback(hObject, eventdata, handles)
% hObject    handle to patient_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of patient_number as text
%        str2double(get(hObject,'String')) returns contents of patient_number as a double

global Patient_ID;

Patient_ID=get(hObject,'String');

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

global Patient_ID ;
global VarNam_Paced_Left Valu_Paced_Left;

try
Patient_ID=get(handles.patient_number,'String');
catch
end
  
if isempty(Patient_ID),
     pause(0.2);
     uiwait(errordlg('Please enter Patient ID and press save ...', 'Error', 'modal'))
     return;
     
else

%         set(handles.browes1, 'Visible', 'off');       
%         set(handles.browse2, 'Visible', 'off');
%         set(handles.analyse, 'Visible', 'off');
%         set(handles.home, 'Visible', 'off');
%         set(handles.print, 'Visible', 'off');
%         set(handles.save, 'Visible', 'off');
%         set(handles.exit, 'Visible', 'off');
%         set(handles.axes_tools, 'Visible', 'off');
%         set(handles.forward, 'Visible', 'off');
%         set(handles.backward, 'Visible', 'off');

        
frame = getframe( Cued_Tapping_Left);

% 
%         set(handles.browes1, 'Visible', 'on');       
%         set(handles.browse2, 'Visible', 'on');
%         set(handles.analyse, 'Visible', 'on');
%         set(handles.home, 'Visible', 'on');
%         set(handles.print, 'Visible', 'on');
%         set(handles.save, 'Visible', 'on');
%         set(handles.exit, 'Visible', 'on');
%         set(handles.axes_tools, 'Visible', 'on');
%         set(handles.forward, 'Visible', 'on');
%         set(handles.backward, 'Visible', 'on');

Name=Patient_ID;

            [saveFileName, saveFilePath] = uiputfile({...
 '*.bmp','bmp-Image(*.bmp)';...
%  '*.txt','txt-Files (*.txt)';...
%  '*.*',  'All Files (*.*)...
},... 
 'Save data as', Name);

            if isequal(saveFileName,0) || isequal(saveFilePath,0)
                uiwait(warndlg('No data was saved','filename error'));
                
            else
                try
%                     mkdir(saveFilePath,Name); Newpath=strcat(saveFilePath,Name)
                    fid = fopen(strcat(saveFilePath,Name,'_PacedTappingLeft.txt'), 'wt');
                    for i=1:numel(Valu_Paced_Left);
                    fprintf(fid,'%-40s\t    % 5.3f\n',VarNam_Paced_Left{i},Valu_Paced_Left(i));
                    end
                    fprintf(fid,'\n','');
                    
                    fprintf(fid,'\n\n\n\n\n%-40s\t','RMS: Root Mean Square');
                    fclose(fid)
                    
                    imwrite(frame.cdata,strcat(saveFilePath,Name,'_PacedTappingLeft.bmp'));
                    uiwait(msgbox('Data was saved successfully: ', 'Data saved', 'modal'));
                    
                catch
                    warndlg('Could not save data', 'Data error', 'modal')
                    rethrow(lasterror);
                end;
            end;
            
            handles.save = 0;
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
GUI_HANDLE=Cued_Tapping_Left();

        set(handles.browes1, 'Visible', 'off');       
        set(handles.browse2, 'Visible', 'off');
        set(handles.analyse, 'Visible', 'off');
        set(handles.home, 'Visible', 'off');
        set(handles.print, 'Visible', 'off');
        set(handles.save, 'Visible', 'off');
        set(handles.exit, 'Visible', 'off');
        set(handles.axes_tools, 'Visible', 'off');
        set(handles.forward, 'Visible', 'off');
        set(handles.backward, 'Visible', 'off');

            set(GUI_HANDLE, 'PaperType', 'A4');
            set(GUI_HANDLE, 'PaperOrientation', 'landscape');
            set(GUI_HANDLE, 'PaperPositionMode','auto');
            set(GUI_HANDLE, 'InvertHardCopy', 'off');
            set(GUI_HANDLE, 'InvertHardCopy', 'off');
            
            print(GUI_HANDLE);
            
        set(handles.browes1, 'Visible', 'on');       
        set(handles.browse2, 'Visible', 'on');
        set(handles.analyse, 'Visible', 'on');
        set(handles.home, 'Visible', 'on');
        set(handles.print, 'Visible', 'on');
        set(handles.save, 'Visible', 'on');
        set(handles.exit, 'Visible', 'on');
        set(handles.axes_tools, 'Visible', 'on');
        set(handles.forward, 'Visible', 'on');
        set(handles.backward, 'Visible', 'on');

           
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

% if isequal(handles.home,1)
Repetitive_Movement_Analysis()
% else
% end


%% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% handles.exit=1;
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
        close(Cued_Tapping_Left)
        
%         close force      
clear all
clc
fclose('all');
disp(' ');
disp('***** END Cued Tapping Left GUI *****');
disp(' ');
disp(' ');
clear all;

end

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
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on selection change in select_graph.
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
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

set(hObject, 'String', {'',...
          '1',...
          '2',...
          '3',...
          '4',...
          '5'});


% --- Executes on button press in forward.
function forward_Callback(hObject, eventdata, handles)
% hObject    handle to forward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

       global d  duration;
      
        a=get(hObject,'value');
        d=a+d;
         
         hand_paced_tapp_left_axes(1)=handles.axes1;
         hand_paced_tapp_left_axes(2)=handles.axes2;
         hand_paced_tapp_left_axes(3)=handles.axes3;
         hand_paced_tapp_left_axes(4)=handles.axes4;
         hand_paced_tapp_left_axes(5)=handles.axes5;
         
         intervall=str2double(get(handles.show,'String'));
         if intervall==0
             intervall=1;
         end
         
         str=get(handles.select_graph, 'String');
         val=str2double(str{get(handles.select_graph, 'value')});
         
if isnan(val) 
errordlg('please select graph first','Error');
return;
elseif isequal(val,4) 
return;
end
         
         cond=round(duration/intervall);
         
         if d*intervall>0 && d*intervall<=round(duration)+intervall
         
         set(hand_paced_tapp_left_axes(val),'Xlim',[ (d-1)*intervall  (d-1)*intervall+intervall]); 
         
         end
         
         if d<0 
           d=0;
         end
         if d>=cond
           d=cond;
         end
         
         % Update handles structure
         guidata(hObject, handles);
         
% --- Executes on button press in backward.
function backward_Callback(hObject, eventdata, handles)
% hObject    handle to backward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

      global d  duration;
      
        a=get(hObject,'value');
        d=d-a;
        
        if sign(d)==-1
            d=0;
        end
       
         hand_paced_tapp_left_axes(1)=handles.axes1;
         hand_paced_tapp_left_axes(2)=handles.axes2;
         hand_paced_tapp_left_axes(3)=handles.axes3;
         hand_paced_tapp_left_axes(4)=handles.axes4;
         hand_paced_tapp_left_axes(5)=handles.axes5;
         
         intervall=str2double(get(handles.show,'String'));
         if intervall==0
             intervall=1;
         end
         
         str=get(handles.select_graph, 'String');
         val=str2double(str{get(handles.select_graph, 'value')});
         
         if isnan(val) 
         errordlg('please select graph first','Error');
         return;
         elseif isequal(val,4) 
         return;
         end
         
         cond=round( duration/intervall);
         
         if d*intervall>=0 && d*intervall<=round( duration)+intervall
         set(hand_paced_tapp_left_axes(val),'Xlim',[ (d+1)*intervall-intervall  (d+1)*intervall]); 
         end

         if d<0 
            d=0;
         end
         if d>cond
            d=cond;
         end
       
         % Update handles structure
         guidata(hObject, handles);




