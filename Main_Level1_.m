%initialization DO NO EDITING
function varargout = Main_Level1_(varargin)
% MAIN_LEVEL1_ MATLAB code for Main_Level1_.fig
%      MAIN_LEVEL1_, by itself, creates a new MAIN_LEVEL1_ or raises the existing
%      singleton*.
%
%      H = MAIN_LEVEL1_ returns the handle to a new MAIN_LEVEL1_ or the handle to
%      the existing singleton*.
%
%      MAIN_LEVEL1_('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_LEVEL1_.M with the given input arguments.
%
%      MAIN_LEVEL1_('Property','Value',...) creates a new MAIN_LEVEL1_ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_Level1__OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_Level1__OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main_Level1_

% Last Modified by GUIDE v2.5 01-Jan-2015 10:04:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_Level1__OpeningFcn, ...
                   'gui_OutputFcn',  @Main_Level1__OutputFcn, ...
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
% RUNS just before GUI is made visible.
function Main_Level1__OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main_Level1_ (see VARARGIN)
% Choose default command line output for Main_Level1_
handles.output = hObject;
% handles.OTemp (1) = 0;
% handles.ITemp(1) = 5;
% handles.Airpressure(1) = 0;
handles.voltage(1) = 0;
handles.timesincelaunch = 0;
handles.initialtable = get (handles.uitable3, 'Data');
 global timesincelaunch;
timesincelaunch = 1;
axes (handles.lo44go);
imshow ('Team_Tomahawk_logo.JPG');

% Update handles structure
% UIWAIT makes Main_Level1_ wait for user response (see UIRESUME)
% uiwait(handles.figure1);
guidata(hObject, handles);
% --- Outputs from this function are returned to the command line.
function [varargout] = Main_Level1__OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;
%--------------------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------------------




% --- Executes on selection change in listbox.
function listbox_Callback(hObject, eventdata, handles)
% hObject    handle to listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox
function listbox_CreateFcn(hObject, eventdata, handles)
    % --- Executes during object creation, after setting all properties.
% hObject    handle to listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Connect_Callback(hObject, eventdata, handles)
% disp ( str2num (get(handles.comport, 'string'))) 
global runner;global timesincelaunch;
[ard,statusbar] = arduinoserialconnect(get(handles.comport, 'string'));
set (ard, 'Timeout', 1.4);
uiwait (statusbar);
launchtime = clock;

frequancy = str2double (get(handles.Freq, 'String'));
runner = timer('TimerFcn',{@arduinoserialreader, ard, handles, timesincelaunch}, 'ExecutionMode','fixedRate', 'Period', frequancy,...
               'ErrorFcn', {@reestablishconnection, handles});
           
start (runner);
start(timer('TimerFcn',{@checker, handles,runner, ard}, 'ExecutionMode','fixedRate', 'Period', 2));

   function reestablishconnection (hObject, eventdata, handles, launchtime)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
delete (instrfind);
Connect_Callback(hObject, eventdata, handles);


  

%ARDUINO SERIAL READER and printer
function arduinoserialreader( hObject, eventdata, ard, handles, launchtime)
%INITILIZATION
          global timesincelaunch;
          ard.ReadAsyncMode = 'continuous';
          readasync (ard);
        %DATA READ
        set (handles.time, 'String',['Time Since Launch: ' num2str(timesincelaunch) ' Sec']);
        
        initialtable = get (handles.uitable3, 'Data');% initial table
       
          newtable (1,timesincelaunch)  = fscanf (ard, '%f');%new table
          newtable (2,timesincelaunch) = fscanf (ard, '%f');%new table
          newtable (3,timesincelaunch)= fscanf (ard, '%f');%new table
          newtable (4,timesincelaunch) = fscanf (ard, '%f');%new table
          newtable (5,timesincelaunch)  = fscanf (ard, '%f');%new table
          newtable (6,timesincelaunch) = fscanf (ard, '%f');%new table
          newtable (7,timesincelaunch)= fscanf (ard, '%f');%new table
          newtable (8,timesincelaunch) = fscanf (ard, '%f');%new table
          newtable (9,timesincelaunch)= fscanf (ard, '%f');%new table
          newtable (10,timesincelaunch) = fscanf (ard, '%f');%new table
      
      
  initialtable(1:10,timesincelaunch) = num2cell(newtable (1:10,timesincelaunch));
               set ( handles.uitable3, 'Data', initialtable);
               timesincelaunch = timesincelaunch+1;
function checker ( hObject, eventdata, handles, run, ard)
                 % Active CHECKER
                  display (get (run, 'Running'));
              if     (strcmp (get (run, 'Running'), 'on'));
              set(handles.Status, 'BackgroundColor', 'green'); 
              else
              set(handles.Status, 'BackgroundColor', 'red');
              end                          
function DisConnect_Callback(hObject, eventdata, handles)
global runner; global timesincelaunch;
timesincelaunch = 1;
stop (runner); 
delete (instrfind);
handles.timesincelaunch = 0;
set (handles.time, 'String',['Time Since Launch: ' num2str(handles.timesincelaunch) ' Sec']);
function comport_Callback(hObject, eventdata, handles)
function comport_CreateFcn(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
% hObject    handle to comport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = get (handles.listbox, 'Value');
   if (selection == 1)
   [file path] =  uigetfile ({'*.csv'}, 'Select File');
   filepath = strcat (path, file);
   if (filepath ~= 0)
   open (filepath);
   end
   end
   
    if (selection == 2)
    VOT_figure (handles);
    end
   
   if (selection == 4)
   Three_D_Orientation_graph(handles);
   end
   
   if (selection == 8)
   open ('About.pdf');  
   end
   
   if (selection == 9)
   open ('help.pdf');  
   end
   
   
   
   
function [] = Three_D_Orientation_graph(handles)
ThreeD__s_graph = figure;
set(ThreeD__s_graph,'Renderer','opengl')
set (ThreeD__s_graph, 'Tag', 'ThreeD_stsbility_graph');
ThreeD__s_graph =  axes ('XLim', [-2, 2], 'YLim', [-2, 2], 'ZLim', [-2, 2]);
view (3);
axis equal;  grid;  
camproj (ThreeD__s_graph, 'perspective');
%Next----create shape
[cyx, cyy, cyz] = cylinder (0.5);
[cox, coy, coz] = cylinder ([1, 0]);
hgTransformArray (1) = surface (cyx, cyy, cyz, 'FaceColor', 'green');
hgTransformArray (2) = surface (cox, coy, coz+1, 'FaceColor', 'blue');
%CREATE transform
 hgTransform = hgtransform ('Parent', ThreeD__s_graph); 
 %Parent TRANSFORM
 set (hgTransformArray, 'Parent', hgTransform);
drawnow ();
 while (1==1)
        %Basic concept for Hgtransform here
%       actualXrotate= makehgtform ('xrotate', Xrotate(end)*0.1);
%       set (hgTransform, 'Matrix', actualXrotate);%Xtransform here
%       drawnow ();
       Table = get (handles.uitable3, 'Data');
       Xrotate = cell2mat (Table (5,:));
       Yrotate = cell2mat (Table (6,:));
       Zrotate = cell2mat (Table (7,:));
       actualrotate= makehgtform ('xrotate',Xrotate(end)*0.1,'yrotate',Yrotate(end)*0.1,'zrotate',Zrotate(end)*0.1);
       set (hgTransform, 'Matrix', actualrotate);
       drawnow();
 end
function [] = VOT_figure (handles)
vot_figure = figure;
set (vot_figure, 'Tag', 'Vot_figure');
set (vot_figure, 'Name', 'Voltage/Outside Temperature/Inside Temperature');
set (vot_figure, 'NumberTitle', 'off');
while (1==1)
   Table = get (handles.uitable3, 'Data');
if (gcf == vot_figure)
 voltage_plot = subplot (3,1,1);
 set (voltage_plot, 'Parent', vot_figure);
 grid;
  subplot (voltage_plot);
end
  voltage = cell2mat (Table (1,:));
  plot (voltage,'Parent', voltage_plot);
  xlabel (voltage_plot, 'Time (sec)');
  ylabel (voltage_plot, 'Voltage');
  drawnow ();
 
  if(gcf == vot_figure)
  OTemp_plot = subplot (3,1,2 );
   set (OTemp_plot, 'Parent', vot_figure);
  subplot (OTemp_plot);
  grid;
  end
  OTemp = cell2mat (Table (2,:));
  plot (OTemp,'Parent', OTemp_plot);
  xlabel (OTemp_plot, 'Time (sec)');
  ylabel (OTemp_plot, 'Outside Temperature');
  drawnow ();
  
  if (gcf == vot_figure)
  ITemp_plot = subplot (3,1,3 );
  set (ITemp_plot, 'Parent', vot_figure);
  subplot (ITemp_plot);
  grid;
  end
  ITemp = cell2mat (Table (2,:)); 
  plot (ITemp, 'Parent', ITemp_plot)
  xlabel (ITemp_plot, 'Time (sec)');
  ylabel (ITemp_plot, 'Inside Temperature');
  drawnow ();
end
function cleartable_Callback(hObject, eventdata, handles)
AllTimer = timerfindall;
set ( handles.uitable3, 'Data', handles.initialtable);
delete(AllTimer);
clc
clear all;


function Export_Callback(hObject, eventdata, handles)
data = get (handles.uitable3, 'Data');
[row col] = size (data);
for i=1:1:col
    timermatrix(i) = i;
end
teamID = str2double (get(handles.teamID, 'String')); 
csvFileexporter (data, teamID, timermatrix);



function Freq_Callback(hObject, eventdata, handles)
% hObject    handle to Freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes during object creation, after setting all properties.
function Freq_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function teamID_Callback(hObject, eventdata, handles)
% hObject    handle to teamID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of teamID as text
%        str2double(get(hObject,'String')) returns contents of teamID as a double
% --- Executes during object creation, after setting all properties.
function teamID_CreateFcn(hObject, eventdata, handles)
% hObject    handle to teamID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

