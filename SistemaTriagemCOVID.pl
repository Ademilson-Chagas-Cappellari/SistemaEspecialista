:- dynamic criterio/3.

criterios :- carrega('./criterio.bd'),
    format('~n*** Critérios ***~n~n'),
    repeat,
    nome(Nome),
    temperatura(Nome),
    freqCardiaca(Nome),
    freqResp(Nome),
    paSisto(Nome),
    saO2(Nome),
    dispineia(Nome),
    idade(Nome),
    comorbi(Nome),
    responde(Nome),
    salva(criterio,'./criterio.bd').

carrega(A) :-
    exists_file(A),
    consult(A)
    ;
    true.

%=====Perguntas para triagem=======
nome(Nome) :-
    format('~nQual o nome do paciente? '),
    gets(Nome).

temperatura(Nome) :-
    format('~nQual é temperatura? '),
    gets(Temp),
    asserta(criterio(Nome,temperatura,Temp)).

freqCardiaca(Nome) :-
    format('~nQual é a frequência cardíaca? '),
    gets(FrCard),
    asserta(criterio(Nome,freqCardiaca,FrCard)).

freqResp(Nome) :-
    format('~nQual é a frequência respiratória? '),
    gets(FrResp),
    asserta(criterio(Nome,freqResp,FrResp)).

paSisto(Nome) :-
    format('~nQual é o PA sistólica? '),
    gets(PaSis),
    asserta(criterio(Nome,paSisto,PaSis)).

saO2(Nome) :-
    format('~nQual é o SaO2? '),
    gets(SaO2),
    asserta(criterio(Nome,saO2,SaO2)).

dispineia(Nome) :-
    format('~nTem dispnéia? (s/n) '),
    gets(Disp),
    asserta(criterio(Nome,dispineia,Disp)).

idade(Nome) :-
    format('~nQual é a Idade? '),
    gets(Idad),
    asserta(criterio(Nome,idade,Idad)).

comorbi(Nome) :-
    format('~nQuantas comorbidades tem? '),
    gets(Como),
    asserta(criterio(Nome,comorbi,Como)).

salva(P,A) :-
    tell(A),
    listing(P),
    told.

gets(S) :-
    read_line_to_codes(user_input,C),
    name(S,C).

responde(Nome) :-
    condicao(Nome, C),
    !,
    format('A condição de ~w é ~w.~n',[Nome,C]).


%===========**CONDIÇÕES**==============

%**Gravissimo**
condicao(Pct, gravissimo) :-
    criterio(Pct,freqResp,Valor), Valor > 30;
    criterio(Pct,paSisto,Valor), Valor < 90;
    criterio(Pct,saO2,Valor), Valor < 95;
    criterio(Pct,dispineia,Valor), Valor = "s".

%**Grave**
condicao(Pct, grave) :-
    criterio(Pct,temperatura,Valor), Valor > 39;
    criterio(Pct,paSisto,Valor), Valor >= 90, Valor =< 100;
    criterio(Pct,idade,Valor), Valor >= 80;
    criterio(Pct,comorbi,Valor), Valor >= 2.

%**Médio**
condicao(Pct, medio) :-
    criterio(Pct,temperatura,Valor), (Valor < 35; (Valor > 37, Valor =< 39));
    criterio(Pct,freqCardiaca,Valor), Valor >= 100;
    criterio(Pct,freqResp,Valor), Valor >= 19, Valor =< 30;
    criterio(Pct,idade,Valor), Valor >= 60, Valor =< 79;
    criterio(Pct,comorbi,Valor), Valor = 1.


%**Leve**
condicao(Pct, leve) :-
    criterio(Pct,temperatura,Valor), Valor >= 35, Valor =< 37;
    criterio(Pct,freqCardiaca,Valor), Valor < 100;
    criterio(Pct,freqResp,Valor), Valor =< 18;
    criterio(Pct,paSisto,Valor), Valor > 100;
    criterio(Pct,saO2,Valor), Valor >= 95;
    criterio(Pct,dispineia,Valor), Valor = "n";
    criterio(Pct,idade,Valor), Valor < 60;
    criterio(Pct,comorbi,Valor), Valor = 0.


