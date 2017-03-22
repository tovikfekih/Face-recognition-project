function gallerieBIS(donnees,n1,n2,nb1,nb2,titre);

figure;
%image=uint8(zeros(nb1*n1,nb2*n2));
no2=norm(donnees(:,40),2)^2;
for (compteur=1:nb1*nb2)
   newIm=vect2Im(donnees(:,compteur),n1,n2);
   no=norm(donnees(:,compteur),2)^2;
   subplot(nb1,nb2,compteur);
   imshow(newIm);
   title(titre(:,:,compteur));
end

end