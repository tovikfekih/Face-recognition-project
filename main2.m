clear all; close all;
% lecture de la base de visages
% X=matrice de donn�es 1 colonne = 1 visage = 1 image r�arrang�e en vecteur

[X, y, width, height, names] = lire_base('images');

X=X';
% pour un visage
n1=height; %nb pixels hauteur
n2=width; %nb pixels largeur
n=width*height; %nb pixels image = nb individus
nvar=size(X,2); %nb images = nb variable


g=mean(X);
ecart=std(X);
Y=X-repmat(g,400,1); % matrice des donn�es centr�es
Yt=Y';
V=(1/n)*Y*Yt; % matrice des variances-covariances
[U0,vp1]=eig(V); % diagonalisation de V
U=Yt*U0; % relation vectP
for i=1:400
    U(:,i)=U(:,i)/norm(U(:,i),2);
end
vp=diag(vp1);
[vpo,I]=sort(vp,'descend'); % valeurs propres ordonn�es 
P(:,:)=U(:,I(:)); % permutation vecteurs propres selon ordre
Intot=sum(vpo); % inertie totale
taux=vp/Intot; 
tauxO=vpo/Intot; % part d'inertie pour axes principaux

% calcul de la part d'inertie cummul�e 
tmp=0;
for i=1:size(tauxO,1)
    tmp=tmp+tauxO(i);
    cum(i)=tmp;
end

nb1=4;
nb2=10;
titre=cell(2,1,nb1*nb2);
% % close all
% % gallerieBIS(P,n1,n2,nb1,nb2,titre);

image1 = imread('images/s4/3.pgm');
G=image1(:,:,1);
G=double(G(:));
% G=Y(1,:); % visage 1 complet (en ligne)
H=(G'-g)*P;

MH=repmat(H',1,40); %40 copies du visage

for j=1:40
    MH(j*10+1:end,j)=0;
end

R=P*MH; % (reconstitution wdes images � partir coefs sur faces propres 
R=R+repmat(g',1,40);

% tableau de cellules pour les titres des graphiques
% calcul des cos2
titre=cell(2,1,40);
no2=norm(R(:,40),2)^2;
% for (j=1:39)
%     no=norm(R(:,j),2)^2;
%     ti={['dim', num2str(*j),' : ',num2str(100*cum(10*j),'%.1f'),'%'];['cos2 : ',num2str(100*no/no2,'%.1f'),'%']};
%     titre(:,:,j)=ti;
% end

close all
gallerieBIS(R,n1,n2,4,10,titre);
