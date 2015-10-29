function varargout = Settings_level_1(varargin)
% SETTINGS_LEVEL_1 MATLAB code for Settings_level_1.fig
%      SETTINGS_LEVEL_1, by itself, creates a new SETTINGS_LEVEL_1 or raises the existing
%      singleton*.
%
%      H = SETTINGS_LEVEL_1 returns the handle to a new SETTINGS_LEVEL_1 or the handle to
%      the existing singleton*.
%
%      SETTINGS_LEVEL_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETTINGS_LEVEL_1.M with the given input arguments.
%
%      SETTINGS_LEVEL_1('Property','Value',...) creates a new SETTINGS_LEVEL_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Settings_level_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Settings_level_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Settings_level_1

% Last Modified by GUIDE v2.5 07-Mar-2015 12:05:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Settings_level_1_OpeningFcn, ...
                   'gui_OutputFcn',  @Settings_level_1_OutputFcn, ...
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


% --- Executes just before Settings_level_1 is made visible.
function Settings_level_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Settings_level_1 (see VARARGIN)

% Choose default command line output for Settings_level_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Settings_level_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Settings_level_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
