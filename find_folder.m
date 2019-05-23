% The function find_folder asks the user to select a folder, from which 
% the data are to be loaded and  gives back the location of the folder 
% and the ID of the subject.

% Program :  % Repetitive Movement Analysis
% Version :  1.2
% Function:  find_folder
% Authors  :  Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic


function [directory_name,Patient_ID_file]=find_folder()

% This function gets the folder of the patient and turns back its name to
% be used by the other functions

directory_name = uigetdir();

if isequal(directory_name ,0)
   errordlg('Folder is not selected','Error');
   disp('User selected Cancel');
   Patient_ID_file='';
   directory_name='';
   return;
else
     directory_name=directory_name;
     Patient_ID_file=directory_name(1:16);
end
     
     
     