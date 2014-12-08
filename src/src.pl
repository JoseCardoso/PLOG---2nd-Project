:-use_module(library(clpfd)).


func(Horario,Salario):- Salario  #<= 7*80, Horario #<= 7.

horario_func([0,0,0,0,0,0,0,0]).

%adic_func(Vars,Func em Extra,Dinheiro a gastar ,func Parciais  , func Normais,
%Vars de Retorno,Extra de Retorno,Dinheiro e Retorno,Parciais de Retornom Normais de Retorno):-

%adicina um funcionário normal
adic_func(Vars,E,D,P,N,Vars1,E,D1,P,N1):-
        adic_func_normal(Vars,Vars1), 
        D1 is D + 7*80,
        N1 is N + 1.

%adicina um funcionário normal com hora extra
adic_func(Vars,E,D,P,N,Vars1,E1,D1,P,N1):-
        adic_func_normal_extra(Vars,Vars1), 
        N1 is N + 1,
        E1 is E + 1,
        D1 is D + 7*80 + 40.
        
%adiciona um funcionário parcial
adic_func(Vars,E,D,P,N,Vars1,E,D1,P1,N):-
        adic_func_normal_extra(Vars,Vars1), 
        P1 is P + 1,
        D1 is D + 3*50.

adic_func(Vars,E,D,P,N,Vars1,E1,D1,P1,N):-
        adic_func_normal_extra(Vars,Vars1), 
        P1 is P + 1,
        E1 is E + 1,
        D1 is D + 3*50 + 60.


%funcionário parcial nas primeira 3 horas
adic_func_parcial([H1,H2,H3,H4,H5,H6,H7,H8],V1):-
       H1R is H1 + 1,
       H2R is H2 + 1,
       H3R is H3 + 1,
       V1 = [H1R,H2R,H3R,H4,H5,H6,H7,H8].


adic_func_parcial([H1,H2,H3,H4,H5,H6,H7,H8],V1):-
       H2R is H2 + 1,
       H3R is H3 + 1,
       H4R is H4 + 1,
       V1 = [H1,H2R,H3R,H4R,H5,H6,H7,H8].

adic_func_parcial([H1,H2,H3,H4,H5,H6,H7,H8],V1):-
       H3R is H3 + 1,
       H4R is H4 + 1,
       H5R is H5 + 1,
       V1 = [H1,H2,H3R,H4R,H5R,H6,H7,H8].

adic_func_parcial([H1,H2,H3,H4,H5,H6,H7,H8],V1):-
       H4R is H4 + 1,
       H5R is H5 + 1,
       H6R is H6 + 1,
       V1 = [H1,H2,H3,H4R,H5R,H6R,H7,H8].

adic_func_parcial([H1,H2,H3,H4,H5,H6,H7,H8],V1):-
       H5R is H5 + 1,
       H6R is H6 + 1,
       H7R is H7 + 1,
       V1 = [H1,H2,H3,H4,H5R,H6R,H7R,H8].

adic_func_parcial([H1,H2,H3,H4,H5,H6,H7,H8],V1):-
       H6R is H6 + 1,
       H7R is H7 + 1,
       H8R is H8 + 1,
       V1 = [H1,H2,H3,H4,H5,H6R,H7R,H8R].



adic_func_parcial_extra([H1,H2,H3,H4,H5,H6,H7,H8],V1):-
       H1R is H1 + 1,
       H2R is H2 + 1,
       H3R is H3 + 1,
       H4R is H4 + 1,
       V1 = [H1R,H2R,H3R,H4R,H5,H6,H7,H8].

adic_func_parcial_extra([H1,H2,H3,H4,H5,H6,H7,H8],V1):-
       H2R is H2 + 1,
       H3R is H3 + 1,
       H4R is H4 + 1,
       H5R is H5 + 1,
       V1 = [H1,H2R,H3R,H4R,H5R,H6,H7,H8].

adic_func_parcial_extra([H1,H2,H3,H4,H5,H6,H7,H8],V1):-
       H3R is H3 + 1,
       H4R is H4 + 1,
       H5R is H5 + 1,
       H6R is H6 + 1,
       V1 = [H1,H2,H3R,H4R,H5R,H6R,H7,H8].

adic_func_parcial_extra([H1,H2,H3,H4,H5,H6,H7,H8],V1):-        
       H4R is H4 + 1,
       H5R is H5 + 1,
       H6R is H6 + 1,
       H7R is H7 + 1,
       V1 = [H1,H2,H3,H4R,H5R,H6R,H7R,H8].

adic_func_parcial_extra([H1,H2,H3,H4,H5,H6,H7,H8],V1):-
       H5R is H5 + 1,
       H6R is H6 + 1,
       H7R is H7 + 1,
       H8R is H8 + 1,
       V1 = [H1,H2,H3,H4,H5R,H6R,H7R,H8R].


%adicionar funcionários normais
adic_func_normal([H1,H2,H3,H4,H5,H6,H7,H8],V1):-
       H1R is H1 + 1,
       H2R is H2 + 1,
       H3R is H3 + 1,
       H5R is H5 + 1,
       H6R is H6 + 1,
       H7R is H7 + 1,
       H8R is H8 + 1,
       V1 = [H1R,H2R,H3R,H4,H5R,H6R,H7R,H8R].

adic_func_normal([H1,H2,H3,H4,H5,H6,H7,H8],V1):-
       H1R is H1 + 1,
       H2R is H2 + 1,
       H3R is H3 + 1,
       H4R is H4 + 1,
       H6R is H6 + 1,
       H7R is H7 + 1,
       H8R is H8 + 1,
       V1 = [H1R,H2R,H3R,H4R,H5,H6R,H7R,H8R].
       
       
adic_func_normal_extra([H1,H2,H3,H4,H5,H6,H7,H8],V1):-
       H1R is H1 + 1,
       H2R is H2 + 1,
       H3R is H3 + 1,
       H4R is H4 + 1,
       H5R is H5 + 1,
       H6R is H6 + 1,
       H7R is H7 + 1,
       H8R is H8 + 1,
       V1 = [H1R,H2R,H3R,H4R,H5R,H6R,H7R,H8R].




dist_func(Vars):-
       % Extras  #<= 2,
       % Dinheiro,
        Vars=[H1,H2,H3,H4,H5,H6,H7,H8],
        H1 #> 3,
        H2 #> 2,
        H3 #> 2,
        H4 #> 5,
        H5 #> 4,
        H6 #> 5,
        H7 #> 7,
        H8 #> 7,
        H1 + H2 + H3 + H4 + H5 + H6 + H7 + H8 #= 50,
       % Parciais #< 6,
       % Parciais #<= 0.3 * Normais,
        labeling([],Vars).
        












