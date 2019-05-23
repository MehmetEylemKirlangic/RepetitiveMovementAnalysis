% The function file_control controls if the file which is loaded
% with impotdata could be analaized or not. It chicks out how many columns
% and how many "nan-value" vectors are there and gives 
% at the end a result as a value assign to "ok". ok=1:the file can be 
% analized, ok=0: there is a problem with the ascii file.

% Program :  % Repetitive Movement Analysis
% Version :  1.2
% Function:  file_control
% Authors  :  Safwan Al-Qadhi, Dr. Mehmet Eylem Kirlangic

function [ok]=file_control(varargin)

file=varargin{1};
b=isstruct(file);

if b   
a=size(file.data,2);

for i=1:a
    lenght_vector=length(file.data(:,i));
    lenght_nan=length(nonzeros(isnan(file.data(:,i))));
    porce=lenght_nan/lenght_vector;
    if porce > 0.5 
        G=0;
    else
        G=1;
    end
    b(i)=G;
end

cond=all(b);

if (~cond && a>3) || (~cond && a==2) || a==1 || (a==3 && b(2)==0) || (a==3 && b(1)==0)
    uiwait(errordlg('There is a problem with the ASCII-file, please chick it!','Error'));
    ok=0;
    return;
else
    ok=1;
end  % end if cond

else % if ~b
   uiwait(errordlg('There is a problem with the ASCII-file, please chick it!','Error'));
   ok=0;
   return; 
end  % end if b
