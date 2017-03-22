clear all
clc
cd 'C:\Users\extra\OneDrive\Etudes\Projet Tut - Reconnaissance Faciale\Images\images'
%I1=imread('mandril_color.tif');
%I1=imread('o-png24.png');
I1=imread('lena_color_512.tif');
P1=I1(:,:,1);
P2=I1(:,:,2);
P3=I1(:,:,3);
[n1,n2]=size(P1);
% imshow(P1);figure;imshow(P2);figure;imshow(P3);figure;imshow(I1);
W1=double(P1(:));
W2=double(P2(:));
W3=double(P3(:));
X=[W1 W2 W3];
m=mean(X);
n=size(P2,2);
Y=X-ones(n,1)*m;
V=(1/n)*Y'*Y;

[U,vp1]=eig(V);




vp=diag(vp1);
[vpo,I]=sort(vp,'descend'); 
P(:,:)=U(:,I(:)); 
Intot=sum(vpo);
taux=vp/Intot;
tauxO=vpo/Intot;

C=Y*P;
%Ct=C';

Ynew=C(:,1); 
m=min(Ynew);
M=max(Ynew);
amplitude=M-m;
a=255/amplitude;
b=-a*m;
Xnew=a*Ynew+b;
newIm1=uint8(zeros(n1,n2));
for (i=1:n1)
 newIm1(:,i)=uint8(Xnew((i-1)*n2+1:i*n2)');
end

Xnew2=X*[1/3;1/3;1/3];
for (i=1:n1)
 newIm2(:,i)=uint8(Xnew2((i-1)*n2+1:i*n2)');
end

close all
imshow(P1);figure;imshow(P2);figure;imshow(P3);figure;imshow(I1);
figure;imshow(newIm1);figure;imshow(newIm2);
