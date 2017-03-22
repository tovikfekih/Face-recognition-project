% Z=Y'*C;
% F=diago*Z/n;

%---------------------------------------------------------------
% F = matrice des visages dans la base des facteurs principaux
% F(:,j) = vect. colonne du jème visage dans base principale
F=Y'*D;
F=F/n;

%--------------------------------------------------------------
% reconstruction complète de tous les visages
% R=D*F';
% im_rec=vect2Im(R(:,1),n1,n2); % essai sur le premier
% imshow(im_rec);

%------------------------------------
% reconstructions partielles visage 1

G=F';
H=G(:,1); % visage 1 complet (tous les coefs sur base faces propres)
MH=repmat(H,1,40); %40 copies du visage
%MH=zeros(n,40);

% MH(j,:) contient les j*10 premières coordonnées et 0 ensuite 
%titre=cell(3,1,40);
for (j=1:39)
    MH(j*10+1:end,j)=0;
end

R=D*MH; % (reconstitution des images à partir coefs sur faces propres 

% tableau de cellules pour les titres des graphiques
% calcul des cos2
titre=cell(2,1,40);
no2=norm(R(:,40),2)^2;
for (j=1:40)
    no=norm(R(:,j),2)^2;
    ti={['dim', num2str(10*j),' : ',num2str(100*cum(10*j),'%.1f'),'%'];['cos2 : ',num2str(100*no/no2,'%.1f'),'%']};
    titre(:,:,j)=ti;
end

close all
gallerieBIS(R,n1,n2,4,10,titre);

%----------------------- Fin étape 2 --------------------------