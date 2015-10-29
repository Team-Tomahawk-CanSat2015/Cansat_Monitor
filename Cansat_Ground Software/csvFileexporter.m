function [] = csvFileexporter(Data, teamID, timermat, row )
%UNTITLED Summary of this function goes here
   [file path] =  uigetfile ({'*.csv'}, 'Select File');
   filepath = strcat (path, file);
   Data = cell2mat (Data);
   %[row, col] = size (Data);
   dataUpdate (1, 1:1:timermat(end)) = teamID;
 
   
   %team Id data including Algorithm
    for i=1:1:row
   dataUpdate(i+1, :) = Data(i, :);
    end 

    if (filepath ~= 0)
    csvwrite (filepath , transpose(dataUpdate));
    end
end

