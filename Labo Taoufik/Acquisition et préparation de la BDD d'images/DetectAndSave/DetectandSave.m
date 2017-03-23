%%%%%%%%%
%   But du programme : 
%   Constituer notre propre base de données d'images en utilisant une
%   caméra.
%
%   Au moment ou vous allez exécuter ce code, il va vous demander
%   d'installer un plugin nommé " MATLAB Support Package for USB Webcams
%   ".
%   Pour installer le plugin vous allez avoir besoin de vous connecter sur votre compte MATLAB.
%   Je vous laisse mes identifiant Matlab.
%
%   Identifiant : tafekih@outlook.fr
%   Mot de passe : gncN3tae
%
%      
%%%%%%%%%


clc;clear all;close all;


C = webcamlist;
% on récupére la liste des caméra
cam=webcam(C{1});
% on se pointe sur la premier qu'on a trouvé
preview(cam);
% on affiche le rendu de la caméra

faceDetector = vision.CascadeObjectDetector;
% C'est un objet implémenté dans Matlab qui va nous permettre de détecter
% la présence d'un objet et plus précisemment un visage

% Cette boucle tourne a l'infini et son arrét est manuel < CTRL + C > dans
% le fenetre de commandes
while 1
    pause(2);
    % une photo est prise chaque 2 secondes.
    I = snapshot(cam);
    disp('Une photo a été prise')
    
    bboxes = step(faceDetector, I);
    % bboxes contient les coordonnées qu'on a besoin pour extraire les
    % visages detecté
    % on va extraire un seul visage pour l'instant
    if ~isempty(bboxes)
        disp('Visage trouvé !!');
        
        % Ici on prends l'image prise depuis la caméra et on la découpe pour
        % avoir un visage
        x=bboxes(1);
        y=bboxes(2);
        largeur=bboxes(3);
        hauteur=bboxes(4);
        visage=I(y:y+hauteur,x:x+largeur);

        %au cas ou le dossier n'existe pas (ce qui était votre cas).
        if (exist('images\created')==0)
            mkdir('images\created');
        end
        D = dir('images\created');
        Num = length(D(not([D.isdir])));
        % on compte combien il y a d'image dans le dossier pour savoir comment
        % nommer la nouvelle image
        % D(not([D.isdir])) signifire que les dossier présent a coté des images
        % ne sont pas pris en compte dans < Num >

        while exist(strcat('images/created/',int2str(Num+1),'.jpg'))==2
            % cette boucle évite que le numéro ne coincide avec le numéro d'une
            % autre image et l'escraser 
            % donc si une image avec le numéro Num+1 existe alors on va
            % l'incrémenter afin de trouver un numéro libre pour notre nouvelle
            % image
            Num= Num + 1;
        end 


        % Un second test provisoire pour étre sure que la variable < visage >
        % contient bien un visage
        if ~isempty(step(faceDetector, visage))
            
            imwrite(imresize(visage,[120,120]),strcat('images/created/',int2str(Num+1),'.jpg'));
            disp(strcat('images/created/',int2str(Num+1),'.jpg', ' a été crée'));
            % on fixe une taille de 120x120 pixels pour tous nos images pour
            % éviter d'avoir des problémes de taille quand il s'agit de constituer le X
            % qui va étre traité pour faire de la reconnaissance facile.
        end


        % la fonction 'getAllFiles' s'occupe de récupérer la liste de
        % noms des fichiers (images) dans le dossier images/created afin de
        % faire un montage d'images avec la fonction montage
        images = getAllFiles('images/created');
        disp('Mise a jour du montage photo');
        figure(1);montage(images);
    else
        disp('Visage introuvable, on va devoir essayer de nouveau');
    end
    disp('--------------------------------');
end

   
    


closePreview(cam);
% closePreview c'est pour fermer la caméra
clear('cam');





