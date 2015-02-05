function [] = csvFileexporter(Data, teamID, timermat )
%UNTITLED Summary of this function goes here
   [file path] =  uigetfile ({'*.csv'}, 'Select File');
   filepath = strcat (path, file);
   Data1 = cell2mat (Data);
   [row, col] = size (Data1);
   
   %team Id data including Algorithm
   for i=1:1:row
   for j=1:1:col
  dataUpdate(i+2, :) = Data1(i, :);
   end 
   end 
  dataUpdate (1, : ) = teamID;
  dataUpdate (2, : ) = timermat;
  
  
  
   if (filepath ~= 0)
   csvwrite (filepath , transpose(dataUpdate));
   end
end

