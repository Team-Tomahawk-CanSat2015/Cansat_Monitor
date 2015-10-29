function varargout = export_level(varargin)
% global table; global teamid;
% teamid = teamID;table = data;
% EXPORT_LEVEL MATLAB code for export_level.fig
%      EXPORT_LEVEL, by itself, creates a new EXPORT_LEVEL or raises the existing
%      singleton*.
%
%      H = EXPORT_LEVEL returns the handle to a new EXPORT_LEVEL or the handle to
%      the existing singleton*.
%
%      EXPORT_LEVEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPORT_LEVEL.M with the given input arguments.
%
%      EXPORT_LEVEL('Property','Value',...) creates a new EXPORT_LEVEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before export_level_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to export_level_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help export_level

% Last Modified by GUIDE v2.5 07-Mar-2015 12:09:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @export_level_OpeningFcn, ...
                   'gui_OutputFcn',  @export_level_OutputFcn, ...
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


% --- Executes just before export_level is made visible.
function export_level_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to export_level (see VARARGIN)

% Choose default command line output for export_level
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes export_level wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = export_level_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function rows_to_exp_Callback(hObject, eventdata, handles)
% hObject    handle to rows_to_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rows_to_exp as text
%        str2double(get(hObject,'String')) returns contents of rows_to_exp as a double


% --- Executes during object creation, after setting all properties.
function rows_to_exp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rows_to_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in export.
function export_Callback(hObject, eventdata, handles)
data = getappdata(0,'data');
teamid = getappdata(0,'teamid');
[row col] = size (data);
chosen_rows = str2num (get(handles.rows_to_exp, 'String')); 
 for i=1:1:numel(chosen_rows)
     final_data(i, :) = data(chosen_rows(i), :);
 end
 for i=1:1:col
   timermatrix(i) = i;
 end
 csvFileexporter (final_data, teamid, timermatrix, numel(chosen_rows));
pause (0.01);
export_level = gcf;
delete (export_level)
