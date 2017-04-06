function varargout = App(varargin)
% APP MATLAB code for App.fig
%      APP, by itself, creates a new APP or raises the existing
%      singleton*.
%
%      H = APP returns the handle to a new APP or the handle to
%      the existing singleton*.
%
%      APP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APP.M with the given input arguments.
%
%      APP('Property','Value',...) creates a new APP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before App_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to App_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help App

% Last Modified by GUIDE v2.5 05-Apr-2017 13:51:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @App_OpeningFcn, ...
                   'gui_OutputFcn',  @App_OutputFcn, ...
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


% --- Executes just before App is made visible.
function App_OpeningFcn(hObject, eventdata, handles, varargin)

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to App (see VARARGIN)

% Choose default command line output for App
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes App wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = App_OutputFcn(hObject, eventdata, handles) 
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

[baseName, folder]= uigetfile({'*.jpg;*.pgm'},'Choisir une image');
if isequal(baseName,0)
    return 
end
set(handles.parent_reconnu_path, 'String', '');
cla(handles.imageTest,'reset');
cla(handles.imageReconnu,'reset');
cla(handles.proche_2,'reset');
cla(handles.proche_3,'reset');
cla(handles.proche_4,'reset');


im_path=strcat(folder,baseName);
 imshow(im_path,'Parent',handles.imageTest); 
testing_image=imread(im_path);
faceDetector = vision.CascadeObjectDetector;
bboxes = step(faceDetector,testing_image);
    if isempty(bboxes)
        warndlg('L''image que vous avez rentré n''est pas un visage humain','!! Alerte !!')
    return
    end
    
  
% disp('Pause de 2 secondes');
pause(1);
% disp('Fin de pause');
% lecture de la base de visages
% X = matrice de donnï¿½es 1 colonne  =  1 visage  =  1 image rï¿½arrangï¿½e en vecteur
fichiers=getAllFiles('images');
[X, y, width, height, names, npers]  =  lire_base( 'images' );

X = X';
% pour un visage
n1 = height; %nb pixels hauteur
n2 = width; %nb pixels largeur
n = width * height; %nb pixels image  =  nb individus
nvar = size( X,1 ); %nb images  =  nb variable
nimpers = nvar / npers;

g = mean( X );
ecart = std( X );

Y = X - repmat( g,nvar,1 ); % matrice des donnï¿½es centrï¿½es
Yt = Y';
V = ( 1 / n ) * Y * Yt; % matrice des variances - covariances
[U0,vp1]  = eig( V ); % diagonalisation de V
U = Yt * U0; % relation vectP

for i = 1:nvar
    U( :,i ) = U( :,i ) / norm( U( :,i ),2 );
end
vp = diag( vp1 );
[vpo,I] = sort( vp,'descend' ); % valeurs propres ordonnï¿½es
P( :,: ) = U( :,I( : ) ); % permutation vecteurs propres selon ordre
Intot = sum( vpo ); % inertie totale
taux = vp / Intot;
tauxO = vpo / Intot; % part d'inertie pour axes principaux

% calcul de la part d'inertie cummulï¿½e
tmp = 0;
for i = 1:size( tauxO,1 )
    tmp = tmp + tauxO( i );
    cum( i ) = tmp;
end

nb1 = 4;
nb2 = 10;
titre = cell( 2,1,nb1 * nb2 );
% % close all
% % gallerieBIS( P,n1,n2,nb1,nb2,titre );

% =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  = TRAITEMENT DE L'IMAGE TEST =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  = 
image  =  imresize(imread(im_path),[92 112]);
image = image( :,:,1 );
image = double( image( : ) );
imagetest = image' - g;
% G = Y( 1,: ); % visage 1 complet ( en ligne )
projtestimg = ( imagetest ) * P; %projection dans la base des eigenfaces

projectimg  =  [ ]; % projected image vector matrix

% sa utilise les vecteurs Projtestimg et le vecteur Projectimg
euclide_dist  =  [];
for i = 1 : size( fichiers,1)
        imTemp=imresize(imread(fichiers{i}),[92 112]);
    imTemp=double(imTemp(:,:,1));
    imTemp=imTemp(:);
    imTemp = imTemp' - g;
    ProjTemp  =  imTemp * P;
    
    
    temp  =  ( norm( projtestimg - ProjTemp ) )^2;
    euclide_dist  =  [euclide_dist temp];
end

disp(min(euclide_dist));
if(min(euclide_dist)>1.3911e+06)
    warndlg('Le visage test est un visage humain, mais il parait qu''il est inconnu');
end
[distances distances_index]  =  sort( euclide_dist );
disp(distances(1:10));
disp(mean(distances(1:2)));
imshow(fichiers{distances_index(1)},'Parent',handles.imageReconnu);
imshow(fichiers{distances_index(2)},'Parent',handles.proche_2);
imshow(fichiers{distances_index(3)},'Parent',handles.proche_3);
imshow(fichiers{distances_index(4)},'Parent',handles.proche_4);

e=strsplit(fichiers{distances_index(1)},'\');
parent_path=strcat('Le dossier de l''image reconnu : ',e(1),'\',e(2));
set(handles.parent_reconnu_path, 'String', parent_path);





% --- Executes on button press in boutonFermer.
function boutonFermer_Callback(hObject, eventdata, handles)
% hObject    handle to boutonFermer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


close all;
