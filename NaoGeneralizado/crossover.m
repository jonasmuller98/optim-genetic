function [filhos] = crossover(parcruzar,nbits)
% Realiza o cruzamento entre as esp�cies de acordo com a sele��o realizada
% cruzamento gera dois filhos

% for ipar=1:size(parcruzar,1)
filhos = [parcruzar(1,1:nbits/2) parcruzar(2,nbits/2+1:nbits)
          parcruzar(1,nbits/2+1:nbits) parcruzar(2,1:nbits/2)];     
% end

end