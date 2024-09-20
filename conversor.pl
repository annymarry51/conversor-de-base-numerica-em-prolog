
%Para converte da base 10, para outras bases (2, 8, 16, 10).

base16([0,1,2,3,4,5,6,7,8,9,'A','B','C','D','E','F']).

numero(0,[X|_],X).
numero(Num,[_|Xs],Elemento):-
    Indice is Num-1,
    numero(Indice,Xs,Elemento).

converter(Num, Base, [X]):-
    Num < Base,
    base16(Base16List),
    numero(Num,Base16List,X).

converter(Num,Base,[X|Xs]) :-
    Auxiliar is Num mod Base,
    base16(Base16List),
    numero(Auxiliar,Base16List,X),
    Quociente is  Num//Base,
    converter(Quociente,Base,Xs).

converte(Num,Base,Resul) :-
    (Base=:=10;
    Base=:=16;
    Base=:=2;
    Base=:=8),
    converter(Num, Base, R),
    reverse(R,Aux),atomic_list_concat(Aux,'',Resul).

%converter para decimal
pecorreLista(_, [], _, _) :- fail.
pecorreLista(Letra, [Letra|_], C, C) :- !.
pecorreLista(Letra, [_|Xs], C, Num) :-
    C1 is C + 1,
    pecorreLista(Letra, Xs, C1, Num).

converterDecimal([], _, _, 0).
converterDecimal([X|Xs], Base, Exp, Num) :-
    Exp1 is Exp + 1,
    base16(Hexa),
    pecorreLista(X,Hexa,0,Alg),
    converterDecimal(Xs, Base, Exp1, Num1),
    Num is Num1 + Alg * Base^Exp.

converteParaDecimal([X|Xs],Base,Resul) :-
    (Base=:=10;
    Base=:=16;
    Base=:=2;
    Base=:=8),
    reverse([X|Xs],Lista),
    converterDecimal(Lista, Base,0,Resul).

%para calcular o complemento de 1

reverso(0,1).
reverso(1,0).

compAux([],[]).
compAux([X|Xs],[Y|Ys]):-
    reverso(X,Y),
    compAux(Xs,Ys).

complemento1A([X|Xs],[X|Resul]):-
    compAux(Xs,Resul).

complemento1([0|Xs],[Resul]):-
    atomic_list_concat([0|Xs],'',Resul).
complemento1([1|Xs],[Resul]):-  complemento1A([1|Xs],Aux), atomic_list_concat(Aux,'',Resul).

%para calcular o complemento de 2

compAux2([], []).
compAux2([0|Xs],[1|Xs]).
compAux2([1|Xs],[0|Ys]):-
   compAux2(Xs,Ys) .

complemento2([0|Xs],[Resul]):-
    atomic_list_concat([0|Xs],'',Resul).
complemento2([1|Xs],[Resul]):-
    complemento1A([1|Xs],Temp),
    reverse(R,Temp),
    compAux2(R,Aux),
    reverse(Comp,Aux),
    atomic_list_concat(Comp,'',Resul).
