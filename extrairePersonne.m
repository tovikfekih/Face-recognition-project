function [X image] = extraireImage(matrice,index)

% Cette fonction consiste a extraire une personne de la matrice X
% de taille n (images) et m (pixels). Aprés avoir extrait les 10 images on
% doit les garder dans une matrice B. 

% Les données d'entrée sont :
%   matrice - La matrice X initiale (complete)
%   index - L'index de la personne qu'ont veut extraire

% Les données de sorties sont :
%   X - La matrice X sans l'index "index" (l'image concerné)
%   image - L'image extraite préte a étre affiché 
% ----------------------------------------------------------------------

% On récupére l'image 
% Pour mon cas les images sont en colonne dans X
% il suffit d'inverser l'index
    n=(10*(index-1))+1;
    image = matrice(:,n:(n+9));
% On enleve l'image récupéré de la matrice X
% -------On pourrait mettre X en tant que parametre d'entrée et encore X en
% tant que paramétre de sortie ce qui nous fait écrire une ligne en moins.
    matrice(:,n:(n+9))=[];
    X=matrice;
% reconstuire une image a partir d'un vecteur qu'on pourrait afficher
% Cette étape est juste présente pour le test
% image_real est l'image qu'on peut afficher
% image est la colonne de l'image

% image_real=reshape(image,[92 112]);
% % l'Image apparait pivoté de -90°, ce qui m'a amené a afficher la transposé
% imshow(image_real');

% Exemple d'utilisation
% [X1 image]= extraireImage(X,3); -- Cette ci extrait l'image a l'index 3
% [X2 images] = extraireImage(X,[4,11,21,34,41]) -- Cette ci extrait les
%   images d'index (4,11,21,34,41)


end
