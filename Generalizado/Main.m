%% Algoritmo Gen�tico
% Jonas Muller
% Algoritmos de Otimiza��o
% Programa para MAXIMIZAR
clear all; clc;

%% Fun��o principal
% Vari�veis Auxiliares
istop = 0;  % Auxiliar de parada =0
ngen = 0; % N�mero de Gera��es
rng(6);

% Vari�veis de Input
nvar = 2;   % N�mero de Vari�veis
npop = 7;   % N�mero de Indiv�duos na Popula��o (�MPAR)
nbits(1,1) = 4;          % N�mero de bits no gen�tipo da vari�vel (PARES)
nbits(2,1) = 6;          % N�mero de bits no gen�tipo da vari�vel (PARES)
nbits(3,1) = 6;          % N�mero de bits no gen�tipo da vari�vel (PARES)
dominio(1,:) = [0 31];   % Dom�nio das vari�veis
dominio(2,:) = [0 31];   % Dom�nio das vari�veis
dominio(3,:) = [0 31];   % Dom�nio das vari�veis
pcross = 0.95;  % Probabilidade de cruzamento
pmut = 0.1;     % Probabilidade de muta��o
f = @(x) x(1).^2 + x(2);  % Fun��o de otimiza��o
ncount = 20;    % Limite de repeti��es para a condi��o
counter = 0;

for ivar = 1:nvar
    %% Cria��o da Popula��o Inicial de Indiv�duos bin�rios e decimais
    pop_bin_actual = [];
    [pop_bin_actual,pop_dec_actual] = init_gen(ngen,npop,nbits,dominio,pop_bin_actual,ivar);
    pop_bin{ivar} = num2str(pop_bin_actual);
    pop_dec(:,ivar) = pop_dec_actual;
end

%% Evolu��o das Esp�cimes
while istop == 0
    ngen = ngen+1;    % Atualiza o Contador de Gera��es
    [parcruzar,iparcruzar,resp_pop,elite,ielite] = selection(pop_bin_actual,pop_dec_actual,f,pop_bin,pop_dec,nvar); % Seleciona os indiv�duos   % Seleciona os ind�viduos a partir da aptid�o
    
    if pcross > rand
        [filhos] = crossover(parcruzar,nbits,nvar);  % Realiza o crossover a partir da probabilidade
        if pmut > rand
            [filhosm] = mutate(filhos,nbits,nvar); % Realiza muta��o a partir da probabilidade
            filhos = filhosm;
        end
        
        [pop_bin_new] = evolve(filhos,pop_bin,parcruzar,iparcruzar,resp_pop,elite,ielite,f,pop_dec,nvar,nbits); % Evolui a esp�cie
        
    else
        pop_bin_new = pop_bin_actual;   % Se o crossover n�o � realizado, mant�m a esp�cie
    end
    
    pop_bin_actual = pop_bin_new;   % Atualiza a popula��o bin�ria
    [~,pop_dec_actual] = init_gen(ngen,npop,nbits,dominio,pop_bin_actual);  % Inicializa a popula��o decimal
    
    %% Condi��o de Parada
    if ngen > 1
        valormax(ngen,1) = max(resp_pop);
        vmax(ngen,1) = mode(valormax);
        if vmax(ngen-1)==vmax(ngen)
            counter = counter + 1;
        else
            counter = 0;
        end
    end
    
    if counter == ncount
        istop=1;
    end
    
end

disp(['O valor da fun��o �: ',num2str(vmax(end,1))]);