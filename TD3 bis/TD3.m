


clc
close all
clear all

% datapath = uigetdir('C:\Documents and Settings\KsDash\My Documents\MATLAB','Selectionnez le dossier de base de données d'images');
% [baseName, folder] = uigetfile('*.jpg');
% TestImage = fullfile(folder, baseName)
datapath='C:\Users\extra\OneDrive\Etudes\Projet Tut - Reconnaissance Faciale\Images\att_face';
X=[];
for i=1:40
    disp(strcat('dossier : s',int2str(i)));
    for j=1 : 10 
        temp=imread(strcat(datapath,'\s',int2str(i),'\',int2str(j),'.pgm'));
        X=[double(temp(:)) X];
        disp(strcat('      image : ',int2str(j)));
    end

end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[n1,n2]=size(imread('C:\Users\extra\OneDrive\Etudes\Projet Tut - Reconnaissance Faciale\Images\att_face\s1\1.pgm'));
n=size(X,1);
m=mean(X);
n=size(X,1);
Y=X-ones(n,1)*m;
V=(1/n)*Y'*Y;
[U,vp1]=eig(V);
vp=diag(vp1);

[vpo,I]=sort(vp,'descend'); % On range les valeurs propores selon l'ordre décroissant
P(:,:)=U(:,I(:)); % On range dans P les vecteurs propores suivant l'ordre des valeurs propres associés
Intot=sum(vpo); % Intot est l'inertie totale
tauxO=vpo/Intot; % Taux d'inertie de chaque axe

C=Y*P;

Ynew=C(:,1); 

m=min(Ynew);
M=max(Ynew);
amplitude=M-m;
a=255/amplitude;
b=-a*m;
Xnew=a*Ynew+b;

newIm1=uint8(zeros(n1,n2));
for (i=1:n2)
 newIm1(:,i)=uint8( Xnew( (i-1)*n1+1 : i*n1 ) );

end

imshow(newIm1);
