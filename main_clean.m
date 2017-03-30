clear all; close all;

[X, y, width, height, names, npers] = lire_base('images');

X=X'; 

n1=height; %nb pixels hauteur
n2=width; %nb pixels largeur
n=width*height; %nb pixels image = nb individus
nvar=size(X,1); %nb images = nb variable
nimpers=nvar/npers;

g=mean(X);
ecart=std(X);
Y=X-repmat(g,nvar,1); % matrice des donn�es centr�es
Yt=Y';
V=(1/n)*Y*Yt; % matrice des variances-covariances
[U0,vp1]=eig(V); % diagonalisation de V
U=Yt*U0; % relation vectP
for i=1:nvar
    U(:,i)=U(:,i)/norm(U(:,i),2);
end
vp=diag(vp1);
[vpo,I]=sort(vp,'descend'); % valeurs propres ordonn�es 
P(:,:)=U(:,I(:)); % permutation vecteurs propres selon ordre
Intot=sum(vpo); % inertie totale
taux=vp/Intot; 
tauxO=vpo/Intot; % part d'inertie pour axes principaux

%====================PROJECTION DE L'IMAGE TEST===========================
image1 = imread('images/s1/1.pgm');
G=image1(:,:,1);
G=double(G(:));
% G=Y(1,:); % visage 1 complet (en ligne)
projtestimg=(G'-g)*P; %projection dans la base des eigenfaces

%====================PROJECTION DE LA BASE D'IMAGES=========================

projectimg = [ ];  % projected image vector matrix
for i = 1 : size(P,2)
    temp = (X(i,:)-g)*P;
    projectimg = [projectimg; temp];
end
%====================CALCULE DES BARYCENTRES===============================

barycenters=[];
temp=0;
for i = 1 : npers
  temp = sum (projectimg((i-1)*nimpers+1:(i-1)*nimpers+nimpers,:))/nimpers;
  barycenters = [barycenters ; temp];
end

%====================DISTANCE IMAGE ET PROJECTION========================
% Convertion de la projection en image



%====================DISTANCE MAX ENTRE BARYCENTRES========================
bary_dist = [];

for i=1 : npers
    for j=i:npers
        temp = (norm(projectimg(i,:)-projectimg(j,:)))^2;
        bary_dist(i,j)=temp;
    end
end

D=max(bary_dist);
D=max(D);

%====================CALCUL DES DISTANCES EUCLUDIENNE AU BARYCENTRE========

euclide_dist_bary = [];
for i=1 : size(barycenters,1)
    temp = (norm(projtestimg-barycenters(i,:)))^2;
    euclide_dist_bary = [euclide_dist_bary temp];
end
[distances_bary distances_index_bary] = sort(euclide_dist_bary);
