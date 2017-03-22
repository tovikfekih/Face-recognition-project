cd C:\Users\Pierre\Desktop\IUT\16-17\STID\ProjetTut\etape2
I1=imread('mandril_color.tif');
P1=I1(:,:,1);
P2=I1(:,:,2);
P3=I1(:,:,3);
[n1,n2]=size(P1);
close all
imshow(P1);figure;imshow(P2);figure;imshow(P3);figure;imshow(I1);
V1(:)=P1(:,:);
V2(:)=P2(:,:);
V3(:)=P3(:,:);
n=size(V1,2);
W1=double(V1');
W2=double(V2');
W3=double(V3');
X=[W1 W2 W3];
g=mean(X);
Y=X-ones(n,1)*g;
Yt=Y';
V=(1/n)*Yt*Y;
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

Xnew2=X*tauxO;
for (i=1:n1)
 newIm2(:,i)=uint8(Xnew2((i-1)*n2+1:i*n2)');
end

close all
imshow(P1);figure;imshow(P2);figure;imshow(P3);figure;imshow(I1);
figure;imshow(newIm1);figure;imshow(newIm2);
