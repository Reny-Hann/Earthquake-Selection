%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edited by Han Renjie 2023/05/18 at Tongji
% Code for reading .AT2 files form Peer Ground Motion Database

% Inouts: filename
% Outputs:
%   -Acceleration time history (Ag)
%   -Time step used for recording (dt)        
%   -Number of recorded points (NPTS)
%   -error code to indicate if the file was not present (errCode)
%       --errCode = 0 if successful, -1 if File not found
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Ag,dt,NPTS,errCode]=readAT2(filename)

fileID=fopen(filename); 
if(fileID == -1)
    Ag = -1;
    dt = -1;
    errCode = -1;
    NPTS = -1;
else
C= textscan(fileID,'%*s %*f %*s %*s %f',1,'headerlines',3);
a1=textscan(fileID,'%f','headerlines',1);
Ag=cell2mat(a1);
dt=cell2mat(C);

errCode = 0;
NPTS=length(Ag);
fclose(fileID);
end
