function [i, j] = barycenter(i, j, v)
   i = sum(i(:) .* v(:)) / sum(v(:));  
   j = sum(j(:) .* v(:)) / sum(v(:));  
end