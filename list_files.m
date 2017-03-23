

function L = list_files(path)
% lecture des noms de fichiers dans un répertoire retour en cell array
	
	%%
	%% Example:
	%% 	L = list_files("./data/yalefaces")
	L = dir(path); % fonction Matlab : retour d'un 3x1 struct array (n elems) with fields:
                    % name date bytes isdir datenum
                    % taille n = nb fichiers et répertoires
	L = L(3:length(L)); % element 1 ='.' élément2='..' on commence au 3ème
	L = struct2cell(L); % conversion en cell array
	L = L(1,:); % on ne retient que les noms (attention : considérés ensuite comme seuls répertoires
end
