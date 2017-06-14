function varargout = SmileGirls(varargin)
% SMILEGIRLS MATLAB code for SmileGirls.fig
%      SMILEGIRLS, by itself, creates a new SMILEGIRLS or raises the existing
%      singleton*.
%
%      H = SMILEGIRLS returns the handle to a new SMILEGIRLS or the handle to
%      the existing singleton*.
%
%      SMILEGIRLS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SMILEGIRLS.M with the given input arguments.
%
%      SMILEGIRLS('Property','Value',...) creates a new SMILEGIRLS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SmileGirls_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SmileGirls_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SmileGirls

% Last Modified by GUIDE v2.5 29-Apr-2017 18:53:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SmileGirls_OpeningFcn, ...
                   'gui_OutputFcn',  @SmileGirls_OutputFcn, ...
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


% --- Executes just before SmileGirls is made visible.
function SmileGirls_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SmileGirls (see VARARGIN)

% Choose default command line output for SmileGirls
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SmileGirls wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SmileGirls_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename1,filepath1]=uigetfile({'*.tiff','All Files'},...
'File Selector');
img = strcat(filepath1, filename1) ;
class = meanDistanceClassifier( img );
axes(handles.axes1);
imshow(img);
set(handles.text1, 'String',class );
%handles.rawdata1=load([filepath1 filename1]);
