function [image]=vect2Im(vect,n1,n2);

m=min(vect);
M=max(vect);
amplitude=M-m;
a=255/amplitude;
b=-a*m;

image=uint8(reshape(a*vect+b,n1,n2));
end

