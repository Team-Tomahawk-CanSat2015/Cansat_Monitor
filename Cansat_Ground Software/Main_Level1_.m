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

% Last Modified by GUIDE v2.5 10-Jun-2015 09:44:32

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
handles.voltage(1) = 0;
handles.timesincelaunch = 0;
handles.initialtable = get (handles.uitable3, 'Data');
global timesincelaunch; global flag;
timesincelaunch = 1;
axes (handles.logo);
imshow ('Team_Tomahawk_logo.JPG');
flag = 1; 

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
global runner;global timesincelaunch; global expected_packets;  expected_packets = 0;
[waittime, ard,statusbar] = arduinoserialconnect(get(handles.comport, 'string'),1); % Used this to offset  the time
set (ard, 'Timeout', 1.4);
uiwait (statusbar);
launchtime = clock;
set (handles.time_delay, 'String',['Initial Time Delay:' num2str(waittime) ' sec']);

runner = timer('TimerFcn',{@arduinoserialreader, ard, handles, timesincelaunch}, 'ExecutionMode','fixedRate',...
               'Period', 1);
start(timer('TimerFcn',{@checker, handles,runner, ard}, 'ExecutionMode','fixedRate', 'Period', 1));
           
start (runner);


function reestablishconnection (hObject, eventdata, handles)
delete (instrfind);
instrreset;
pause (5);

Connect_Callback(hObject, eventdata, handles);
    


%ARDUINO SERIAL READER and printer
function arduinoserialreader( hObject, eventdata, ard, handles, launchtime)
%INITILIZATION
          global timesincelaunch; global flag;
          ard.ReadAsyncMode = 'continuous';
          %readasync (ard);
        %DATA READ
        if (ard.BytesAvailable > str2double (get(handles.Freq, 'String')))
        initialtable = get (handles.uitable3, 'Data');% initial table
        string_array = str2num (fscanf (ard, '%s'));
        num_of_var = numel(string_array);
         timesincelaunch = string_array (1, 1);
%          timesincelaunch = floor(timesincelaunch);
         for b = 1:1:numel(string_array)
            newtable (b,timesincelaunch) = string_array (1, b);
         end
      
  initialtable(1:num_of_var,timesincelaunch) = num2cell(newtable (1:num_of_var,timesincelaunch));
  set ( handles.uitable3, 'Data', initialtable);
  Table = get (handles.uitable3, 'Data')
  
  set ( handles.text67, 'string', num2str ( Table {1, timesincelaunch}) );
  set ( handles.mtime, 'string', num2str ( Table {2, timesincelaunch}) );
  set ( handles.state, 'string', num2str ( Table {3, timesincelaunch}) );
  set ( handles.Temp, 'string', num2str ( Table {4, timesincelaunch}) );
  set ( handles.text55, 'string', num2str ( Table {5, timesincelaunch}) );
  set ( handles.text57, 'string', num2str ( Table {6, timesincelaunch}) );
  set ( handles.alt, 'string', num2str ( Table {7, timesincelaunch}) );
  set ( handles.drate, 'string', num2str ( Table {8, timesincelaunch}) );
  set ( handles.voltahe, 'string', num2str ( Table {9, timesincelaunch}) );
  set ( handles.x_d, 'string', num2str ( Table {10, timesincelaunch}) );% x alpha
  set ( handles.text49, 'string', num2str ( Table {11, timesincelaunch}) ); %y alpha
  set ( handles.text51, 'string', num2str ( Table {12, timesincelaunch}) ); %Z ALPHA
  set ( handles.text53, 'string', num2str ( Table {13, timesincelaunch}) );% Z_roll rate
  
  
 
  
  if (flag == 0 ) %Start variable plot
  plotdata = str2double (get(handles.wd2p, 'String'));
 datamat = cell2mat ( Table (plotdata,:)); 
  plot (datamat, 'Parent', handles.plot);
  set (handles.plot , 'XGrid', 'on');
  set (handles.plot , 'YGrid', 'on');
  end
        elseif (ard.BytesAvailable <= 0)
            pause (2);
        end
        
        
        
        
               
               
function checker ( hObject, eventdata, handles, run, ard)
    global timesincelaunch; global flag;
                 % Active CHECKER
                  display (get (run, 'Running'));
              if     (strcmp (get (run, 'Running'), 'on'))
              set(handles.Status, 'BackgroundColor', 'green');  
             else
              set(handles.Status, 'BackgroundColor', 'red');
              end   
    set (handles.time, 'String',['Unrecovered bytes:' num2str(ard.BytesAvailable) ' bytes']);
    set (handles.d_bytes, 'String',['Downloaded characters:' num2str(ard.ValuesReceived) ' char']);
    
         
          
function DisConnect_Callback(hObject, eventdata, handles)
global runner; global timesincelaunch; global flag;
timesincelaunch = 1;
stop (runner); 
delete (instrfind);
handles.timesincelaunch = 0;
 set (handles.time, 'String','Unrecovered bytes: 0 bytes');
 set (handles.d_bytes, 'String','Downloaded characters: 0 char');
 set (handles.time_delay, 'String','Initial Time Delay: N/A');
 flag = 1; %stop variable plot
 

  
   
    
function comport_Callback(hObject, eventdata, handles)
function comport_CreateFcn(hObject, eventdata, handles)
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
    
     if (selection == 3)
        %oVerview(handles);
    end
   
   if (selection == 4)
   Three_D_Orientation_graph(handles);
   end
   
   if (selection == 5)
   GPS ();  
   end
   
   if (selection == 8)
   open ('About.pdf');  
   end
   
   if (selection == 9)
   Settings_level_1(); 
   end
   
   
function [] = Three_D_Orientation_graph(handles)
global timesincelaunch;
threeD__s_graph = figure;  axe = 25;
fig_ax = axes ('XLim', [-axe, axe], 'YLim', [-axe, axe], 'ZLim', [-axe+20, axe+10]);
% axis ([-axe, axe,-axflage, axe, -axe+10, axe+10]); 

hold on;
%Next----create shape
lenght = 4; teta = pi/6; k =0; height = 30;
 x_pts_bplate = [lenght*cos(teta), lenght*cos(teta), 0, -lenght*cos(teta), -lenght*cos(teta), 0];
 y_pts_bplate = [lenght*sin(teta), -lenght*sin(teta), -lenght, -lenght*sin(teta), lenght*sin(teta), lenght];
 z_pts_bplate = [0, 00, 00, 00, 00, 00] ;
 k (1) = fill3 (x_pts_bplate, y_pts_bplate, z_pts_bplate, [0 0 0.5]);
 %tOP PLATE
 x_pts_Tplate = [lenght*cos(teta), lenght*cos(teta), 0, -lenght*cos(teta), -lenght*cos(teta), 0];
 y_pts_Tplate = [lenght*sin(teta), -lenght*sin(teta), -lenght, -lenght*sin(teta), lenght*sin(teta), lenght];
 z_pts_Tplate = [0+height, 00+height, 00+height, 00+height, 00+height, 00+height] ;
 k(2) = fill3 (x_pts_Tplate, y_pts_Tplate, z_pts_Tplate, [0 0 0.5]);

 for i = 2:1:numel(x_pts_Tplate)
side_x = [x_pts_bplate(i-1), x_pts_Tplate(i-1), x_pts_Tplate(i), x_pts_bplate(i)];
side_y = [y_pts_bplate(i-1),y_pts_Tplate(i-1), y_pts_Tplate(i),  y_pts_bplate(i)];               
side_z = [z_pts_bplate(i-1),z_pts_Tplate(i-1), z_pts_Tplate(i), z_pts_bplate(i)]; 
k(i+1) = fill3 (side_x, side_y, side_z, [0 1 0]);
 end   
 line ([0, 0], [0, 0], [-100, 100]); line ([0, 0], [-100, 100], [height/2,height/2]); line ([-100, 100], [0, 0], [height/2,height/2]);
 camproj ('perspective');  grid;  view (3); threeD__s_graph.Renderer = 'opengl';
 zlabel('<---  Direction of Descent'); ylabel('y axis'); xlabel('X axis'); title('Angle of descent is the angle between CANSAT"s Zaxis and descent direction.')
 hold off;
 cansat = hgtransform ('Parent',fig_ax);
 set ( k, 'Parent', cansat );drawnow;

  while (ishandle(fig_ax) == 1)
 %       actualXrotate= makehgtform ('xrotate', Xrotate(end)*0.1);
 %       set (hgTransform, 'Matrix', actualXrotate);%Xtransform here  %drawnow ();
        Table = get (handles.uitable3, 'Data');
        degtorad = 3.142/180;
        Xrotate = Table {10, timesincelaunch} * degtorad;
        Yrotate = Table {11, timesincelaunch} * degtorad;
        Zrotate =  Table {12, timesincelaunch} * degtorad;
        actualrotate= makehgtform ('xrotate',Xrotate(end),'yrotate',Yrotate(end),'zrotate',Zrotate(end));
        set (cansat, 'Matrix', actualrotate);  
        drawnow();
  end
  
  
function [] = VOT_figure (handles)
vot_figure = figure;
set (vot_figure, 'Tag', 'Vot_figure');
set (vot_figure, 'Name', 'Voltage/Outside Temperature/Inside Temperature');
set (vot_figure, 'NumberTitle', 'off');
     ALT_plot = subplot (4,1,1);      xlabel (ALT_plot, 'Time (sec)');        ylabel (ALT_plot, 'Altitude (m)');
     OTemp_plot = subplot (4,1,2);    xlabel (OTemp_plot, 'Time (sec)');      ylabel (OTemp_plot, 'Outside Temp.(*C)');
     ITemp_plot = subplot (4,1,3 );   xlabel (ITemp_plot, 'Time (sec)');      ylabel (ITemp_plot, 'Inside Temp. (*C)');
     voltage_plot = subplot (4,1,4);  xlabel (voltage_plot, 'Time (sec)');    ylabel (voltage_plot, 'Voltage (v)');
while (ishandle(vot_figure) == 1)
    Table = get (handles.uitable3, 'Data');
   if(gcf == vot_figure)
  ALT_plot = subplot (4,1,1 );
  set (ALT_plot, 'Parent', vot_figure);
  subplot (ALT_plot);
  grid;
  end
  Altitude = cell2mat (Table (7,:));
  plot (Altitude,'Parent', ALT_plot);
  xlabel (ALT_plot, 'Time (sec)');
  ylabel (ALT_plot, 'Altitude (m)');
  drawnow ();
  %OUTSIDE TEMPERATURE
   if(gcf == vot_figure)
  OTemp_plot = subplot (4,1,2 );
  set (OTemp_plot, 'Parent', vot_figure);
  subplot (OTemp_plot);
  grid;
  end
  OTemp = cell2mat (Table (4,:));
  plot (OTemp,'Parent', OTemp_plot);
  xlabel (OTemp_plot, 'Time (sec)');
  ylabel (OTemp_plot, 'Temperature(*C)');
  drawnow ();
  %INSIDE TEMPERATURE
   if (gcf == vot_figure)
  ITemp_plot = subplot (4,1,3 );
  set (ITemp_plot, 'Parent', vot_figure);
  subplot (ITemp_plot);
  grid;
  end
  ITemp = cell2mat (Table (12,:)); 
  plot (ITemp, 'Parent', ITemp_plot)
  xlabel (ITemp_plot, 'Time (sec)');
  ylabel (ITemp_plot, 'Z_alpha (degrees)');
  drawnow ();
  % VOLTAGE
if (gcf == vot_figure)
 voltage_plot = subplot (4,1,4);
 set (voltage_plot, 'Parent', vot_figure);
 grid;
  subplot (voltage_plot);
end
  voltage = cell2mat (Table (9,:));
  plot (voltage,'Parent', voltage_plot);
  xlabel (voltage_plot, 'Time (sec)');
  ylabel (voltage_plot, 'Voltage (v)');
  drawnow ();

end

function cleartable_Callback(hObject, eventdata, handles)
global expected_packets; expected_packets = 0; 
set (handles.time, 'String',['Expected data packets ' num2str(expected_packets)]);
AllTimer = timerfindall;
set ( handles.uitable3, 'Data', handles.initialtable);
delete(AllTimer);
clc
clear all;


function Export_Callback(hObject, eventdata, handles)
data = get (handles.uitable3, 'Data');
teamID = str2double (get(handles.teamID, 'String')); 
setappdata(0,'data',data );
setappdata(0,'teamid',teamID );
export_level();
% [what_to_exp] = Variable_to_export_selection(); what_to_exp
% [row col] = size (data)
% % for i=1:1:col
% %     timermatrix(i) = i;
% % end
% % teamID = str2double (get(handles.teamID, 'String')); 
% % csvFileexporter (data, teamID, timermatrix);



function Freq_Callback(hObject, eventdata, handles)

function Freq_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function teamID_Callback(hObject, eventdata, handles)
% hObject    handle to teamID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of teamID as text
%   str2double(get(hObject,'String')) returns contents of teamID as a double
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


% --- Executes on button press in gps_finder.
function gps_finder_Callback(hObject, eventdata, handles)
% hObject    handle to gps_finder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function uitable3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Zeroer.
function Zeroer_Callback(hObject, eventdata, handles)
global flag;
flag = 0;
 table = get (handles.uitable3, 'Data');
 newtable = table;
 logicalarray = ~cellfun(@isempty,newtable);
 emptyIndex = cellfun(@isempty,newtable);
 newtable(emptyIndex) = {0};
 set (handles.uitable3, 'Data', newtable);
 
 %cell2mat(table)
   %TF = ismissing(cell2mat(table),{'' '.' 'NA' NaN});
   %T(any(TF,2),:);
   %T = standardizeMissing(TF,'');
   %set( handles.uitable3, 'Data', initialtable);



function wd2p_Callback(hObject, eventdata, handles)
% hObject    handle to wd2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wd2p as text
%        str2double(get(hObject,'String')) returns contents of wd2p as a double


% --- Executes during object creation, after setting all properties.
function wd2p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wd2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on wd2p and none of its controls.
function wd2p_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to wd2p (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
global flag; 
 if (strcmp (eventdata.Key,'control') )
 plotdata = str2double (get(handles.wd2p, 'String'));
 Table = get (handles.uitable3, 'Data');
 datamat = cell2mat ( Table (plotdata,:));
 plot (datamat, 'Parent', handles.plot);
 set (handles.plot , 'XGrid', 'on');
 set (handles.plot , 'YGrid', 'on');
 display (eventdata.Key);
  end
