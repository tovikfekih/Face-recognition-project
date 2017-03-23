clc
close all
clear all

% datapath = uigetdir('C:\Documents and Settings\KsDash\My Documents\MATLAB','Selectionnez le dossier de base de données d'images');
% [baseName, folder] = uigetfile('*.jpg');
% TestImage = fullfile(folder, baseName)
datapath='C:\Users\extra\OneDrive\Etudes\Projet Tut - Reconnaissance Faciale\Images\att_face';
        if (exist('eigenfaces')==0)
            mkdir('eigenfaces');
        end
for i=1:40
    im_eig=eigenface(strcat(datapath,'\s',int2str(i),'\'));
    imwrite(im_eig,strcat('eigenfaces/',int2str(i),'.jpg'));
    disp(strcat('eigenfaces/',int2str(i),'.jpg', ' a été crée'));
end
  addpath(strcat(pwd,'\eigenfaces'));
  fileFolder = 'eigenfaces/';
   dirOutput = dir(fullfile(fileFolder,'*.jpg')); % *.jpg indicates 
          %only jpg files. this can be changed to anything you like.

   fileNames = {dirOutput.name};
   montage(fileNames);

