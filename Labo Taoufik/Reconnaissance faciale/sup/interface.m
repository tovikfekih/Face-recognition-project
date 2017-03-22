function varargout = interface(varargin)
%INTERFACE MATLAB code file for interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to interface_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      INTERFACE('CALLBACK') and INTERFACE('CALLBACK',hObject,...) call the
%      local function named CALLBACK in INTERFACE.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interface

% Last Modified by GUIDE v2.5 14-Oct-2016 19:02:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interface_OpeningFcn, ...
                   'gui_OutputFcn',  @interface_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before interface is made visible.
function interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for interface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interface_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(interface)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over start.

function start_Callback(hObject, eventdata, handles)
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
%%% face recognition by Kalyan Sourav Dash %%%
%%%%%%%  provide the data path where the training images are present  %%%%%%%
%%% if your matlab environment doesn't support 'uigetdir' function
%%% change those lines in code for datapath and testpath as :
% datapath = 'give here the path of your training images';
% testpath = 'similarly give the path for test images';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% datapath = uigetdir('C:\Documents and Settings\KsDash\My Documents\MATLAB','select path of training images');
% [baseName, folder] = uigetfile('*.jpg');
% TestImage = fullfile(folder, baseName)

datapath='C:\Users\extra\OneDrive\Etudes\Projet Tut - Reconnaissance Faciale\BDD images\BDD\images\LEARN';
TestImage='C:\Users\extra\OneDrive\Etudes\Projet Tut - Reconnaissance Faciale\BDD images\BDD\images\TEST\b.jpg';
imshow(imread(TestImage),'Parent',handles.axes1);
% [baseName, folder]= uigetfile('*.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%  calling the functions  %%%%%%%%%%%%%%%%%%%%%%%%
% TestImage=strcat(folder,baseName);
D = getAllFiles(datapath);size(D)
recog_img = facerecog(D,TestImage)
selected_img = D{recog_img};
imshow(imread(selected_img),'Parent',handles.axes2);



% UIWAIT makes myGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);




% imshow(select_img);
% title('Recognized Image');
% 
% figure,imshow(test_img);
% title('Test Image');
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
