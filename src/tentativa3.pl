:-use_module(library(clpfd)).
:-use_module(library(lists)).


horario_func([]).
horario_func([H|T]):-
	H = [H1,H2,H3,H4,H5,H6,H7,H8],
	domain(H,0,1),
	sum(H,#=,Sum),
	(Sum #= 7 #/\ (H4 #= 0 #\/ H5 #= 0) ) #\/
		 Sum #= 8 #\/ 
		 Sum #= 3 #\/ Sum #= 4 #\/ Sum #= 0,
	horario_func(T).

validate_func([],N,N).
validate_func(L,P,N):-
        P1 is P + 1,
        element(P,L,E),
        element(P1,L,E1),
        E #= E1,
        validate_func(L,P1,N).

        
validate_horario([]).
validate_horario([H|T],N):-
        validate_func(H,1,N),
        validate_horario(T,N).

        
        
        
    


get_Nth_list([],_, []).
get_Nth_list([H|T], N , [H1|T1]):-
	element(N,H,H1),
	get_Nth_list(T,N,T1).

set_min_func([],_,_,_).		
set_min_func(_,NMax,NMax,_).	
set_min_func([H|T],N,NMax,Horario):-
	get_Nth_list(Horario,N,Nelem),
	sum(Nelem,#>=,H),
	N1 is N+1,
	set_min_func(T,N1,NMax,Horario).

min_func(Horario,Vars):-
	length(Vars,N),
	set_min_func(Vars,1,N,Horario).
	

wre([]).
wre([H1,H2,H3,H4,H5,H6,H7,H8|T]):-

	write(H1),write(H2),write(H3),write(H4),write(H5),write(H6),write(H7),write(H8),nl,
	wre(T).	



funcionario(Horario):-
	Vars = [4,3,3,6,5,6,8,8],
%	domain([H1],4,1000000),
%	domain([H2],3,1000000),
%	domain([H3],3,1000000),
%	domain([H4],6,1000000),
%	domain([H5],5,1000000),
%	domain([H6],6,1000000),
%	domain([H7],8,1000000),
%	domain([H8],8,1000000),
%	domain([Parciais],0,5),
%	domain([Dinheiro],0,1000000),
%	(Parciais/Normais)*100 #< 30,
	length(Hor,10),
	horario_func(Hor),
        length(Vars,N),
        validate_horario(Hor,N),
	min_func(Hor,Vars),
	append(Hor,Horario),
	labeling([],Horario),
	wre(Horario).
		
   
      