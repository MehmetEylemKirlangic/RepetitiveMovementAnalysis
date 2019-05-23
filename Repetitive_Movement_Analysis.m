% The function Repetitive_Movement_Analysis is the main GUI window in the toolbox.
% In this window the desired analysis window(s):    
%                               Synchronisation & Gait Analysis - Left
%                               Synchronisation & Gait Analysis - Right
%                               Self-paced Tapping - Forefoot
%                               Self-paced Tapping - Heel
%                               Self-paced Tapping - Hand
%                               Cued Tapping - Left
%                               Cued Tapping - Right
% can be selected and started. 


% Program :  Repetitive Movement Analysis
% Version :  1.2
% Function:  Repetitive_Movement_Analysis
% Authors :  Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic

%%
function varargout = Repetitive_Movement_Analysis(varargin)
% REPETITIVE_MOVEMENT_ANALYSIS M-file for Repetitive_Movement_Analysis.fig
%      REPETITIVE_MOVEMENT_ANALYSIS, by itself, creates a new REPETITIVE_MOVEMENT_ANALYSIS or raises the existing
%      singleton*.
%
%      H = REPETITIVE_MOVEMENT_ANALYSIS returns the handle to a new REPETITIVE_MOVEMENT_ANALYSIS or the handle to
%      the existing singleton*.
%
%      REPETITIVE_MOVEMENT_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REPETITIVE_MOVEMENT_ANALYSIS.M with the given input arguments.
%
%      REPETITIVE_MOVEMENT_ANALYSIS('Property','Value',...) creates a new REPETITIVE_MOVEMENT_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Repetitive_Movement_Analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Repetitive_Movement_Analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Repetitive_Movement_Analysis

% Last Modified by GUIDE v2.5 17-May-2019 11:29:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Repetitive_Movement_Analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @Repetitive_Movement_Analysis_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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


%% --- Executes just before Repetitive_Movement_Analysis is made visible.
function Repetitive_Movement_Analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Repetitive_Movement_Analysis (see VARARGIN)

% Choose default command line output for Repetitive_Movement_Analysis
handles.output = hObject;


% Parameter initialisaion:
handles.exit = 0;
handles.start = 0;
handles.analysisChanged = 0;


imgFile = 'logo_juelich_300x60.jpg';
img=imread(imgFile);
image(img,'parent',handles.LogoJuelich);
set(handles.LogoJuelich,'XTick',[],'YTick',[]);
set(handles.LogoJuelich,'box','off');
set(handles.LogoJuelich,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Repetitive_Movement_Analysis wait for user response (see UIRESUME)
% uiwait(handles.Repetitive_Movement_Analysis_figure);


%% --- Outputs from this function are returned to the command line.
function varargout = Repetitive_Movement_Analysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% --- Executes on selection change in Analysis_Selection_List.
function Analysis_Selection_List_Callback(hObject, eventdata, handles)
% hObject    handle to Analysis_Selection_List (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.analysisChanged = 1;

% Update handles structure
guidata(hObject, handles);

% Hints: contents = get(hObject,'String') returns Analysis_Selection_List contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Analysis_Selection_List


% --- Executes during object creation, after setting all properties.
function Analysis_Selection_List_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Analysis_Selection_List (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'Synchronisation and Gait Analysis - Left',...
          'Synchronisation and Gait Analysis - Right',...
          'Self-paced Tapping - Forefoot',...
          'Self-paced Tapping - Heel',...
          'Self-paced Tapping - Hand',...
          'Cued Tapping - Left',...
          'Cued Tapping - Right'});


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.start=1;

         str=get(handles.Analysis_Selection_List, 'String');
         val=get(handles.Analysis_Selection_List, 'value');
            
         switch str{val}
       
         case 'Synchronisation and Gait Analysis - Left' % User select.
             disp('Starting Synchronisation and Gait Analysis - Left GUI')
             disp('   ')
             Synchronisation_Gait_Analysis_Left();
         case 'Synchronisation and Gait Analysis - Right' % User select.
             disp('Starting Synchronisation and Gait Analysis - Right GUI')
             disp('   ')
             Synchronisation_Gait_Analysis_Right();    
         case 'Self-paced Tapping - Forefoot' % User select.
             disp( 'Starting Self-paced Tapping - Forefoot GUI')
             disp('   ')
             Self_paced_Tapping_Forefoot();
         case 'Self-paced Tapping - Heel' % User select.
             disp('Starting Self-paced Tapping - Heel GUI')
             disp('   ')
             Self_paced_Tapping_Heel();
         case 'Self-paced Tapping - Hand' % User select.
             disp('Starting Self-paced Tapping - Hand GUI')
             disp('   ')
             Self_paced_Tapping_Hand();
         case 'Cued Tapping - Left' % User select.
             disp('Starting Cued Tapping - Left GUI')
             disp('   ')
             Cued_Tapping_Left();
         case 'Cued Tapping - Right' % User select.
             disp('Starting Cued Tapping - Right GUI')
             disp('   ')
             Cued_Tapping_Right();
             otherwise
                 
         end

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.exit=1;

str1='Yes';
str2='No';

Qd=questdlg('do you realy want to exit','',str1,str2,str2);
if (strcmp(Qd,str1)==1)
try      
close(Repetitivement_Movement_Analysis);
catch
end
close all


clc
fclose('all');
disp('***** END Repetitive Movement Analysis GUI *****');
disp(' ');
disp(' ');
clear all;

elseif (strcmp(Qd,str1)==0)
    
end

