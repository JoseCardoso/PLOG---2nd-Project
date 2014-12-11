:-use_module(library(clpfd)).


atribuiHorario([],E,D,P,N[0,0,0,0,0,0,0,0],E,D,P,N,0,0,0,0,0,0,0,0).

atribuiHorario([H|T],E,D,P,N,[[Hr1,Hr2,Hr3,Hr4,Hr5,Hr6,Hr7,Hr8]	|T1],EF,DF,PF,NF,
	Hor1,Hor2,Hor3,Hor4,Hor5,Hor6,Hor7,Hor8
	):-
	H = [0,0,0,0,0,0,0,0],
	atribuiHorario(T,E,D,P,N,T1,E1,D1,P1,N1,
		Ho1,Ho2,Ho3,Ho4,Ho5,Ho6,Hor,Ho8),
	adic_func(H,E1,D1,P1,N1,
		[Hr1,Hr2,Hr3,Hr4,Hr5,Hr6,Hr7,Hr8]	,EF,DF,PF,NF),
		Hor1 is Ho1 + Hr1,
		Hor2 is Ho2 + Hr2,
		Hor3 is Ho3 + Hr3,
		Hor4 is Ho4 + Hr4,
		Hor5 is Ho5 + Hr5,
		Hor6 is Ho6 + Hr6,
		Hor7 is Ho7 + Hr7,
		Hor8 is Ho8 + Hr8.



funcionario(TodosF):-
        Extras  #<= 2,
        H1 #> 3,
        H2 #> 2,
        H3 #> 2,
        H4 #> 5,
        H5 #> 4,
        H6 #> 5,
        H7 #> 7,
        H8 #> 7,
      	Parciais #< 6,
       	Parciais #<= 0.3 * Normais,
       	length(TodosF,N),
        labeling([],TodosF),
        atribuiHorario(TodosF,0,0,0,0,VarsF,Extras,Dinheiro,Parciais,Normais,
        	H1,H2,H3,H4,H5,H6,H7,H8),
        labeling([minimize(Dinheiro)],TodosF).





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
        adic_func_parcial(Vars,Vars1), 
        P1 is P + 1,
        D1 is D + 3*50.

adic_func(Vars,E,D,P,N,Vars1,E1,D1,P1,N):-
        adic_func_parcial_extra(Vars,Vars1), 
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
