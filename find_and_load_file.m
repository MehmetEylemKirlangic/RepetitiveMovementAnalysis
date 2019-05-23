% The function find_and_load_file looks for a specific filename in a folder.
% It is a general function that is used in each analysis window in
% Repetitive Movement Analysis. It becomes the name of the desired file from the active window,
% looks for the file in the selected folder and gives back the location of
% the folder and the subject ID.

% Program : % Repetitive Movement Analysis
% Version :  1.2
% Function:  find_and_load_file
% Authors  :  Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic


function [directory_name,N,Patient_ID_file]=find_and_load_file(look_for_this_file)

directory_name = uigetdir();

if isequal(directory_name ,0)
   errordlg('Ordner is not selected','Error');
   disp('User selected Cancel');
   N='';
   Patient_ID_file='';
   directory_name='';
   return;
else
   
idn = ls(directory_name );

for i=1:size(idn,1)

filename=regexp(idn(i,:),look_for_this_file,'ignorecase', 'match');

if ~isempty(filename)
    
    file_is=idn(i,:);
    Patient_ID_file=file_is(1:16);
    file_to_analyse=strcat(directory_name,'\',file_is);
    N=file_to_analyse;
    
    break;
end
end

if isempty(filename)
    
    tmp = strfind(look_for_this_file,'.txt');
    tmp = look_for_this_file(1:tmp+3);
    ERROR_message=strcat(' The file for ',' " ',tmp,' " ', 'could not be found');
    N='';
    Patient_ID_file='';
    uiwait(warndlg(ERROR_message))
    return;
end

end
