:-use_module(library(clpfd)).
:-use_module(library(lists)).

horario_func([]).
horario_func([H|T]):-
	H = [H1,H2,H3,H4,H5,H6,H7,H8],
	domain(H,0,1),
	sum(H,#=,Sum),
        element(4,H,X),
        element(5,H,Y),
	(Sum #= 7 #/\ (X #\= Y)) #\/
		Sum #= 8 #\/ 
		Sum #= 3 #\/ Sum #= 4 #\/ Sum #= 0,
	horario_func(T).


num_func([],Parcial,Inteiro):- Parcial #= 0, Inteiro#= 0.
num_func([H|T],Parcial,Inteiro):- 
	num_func(T,Parcial1,Inteiro1),
	sum(H,#=,Sum),
	 ( Sum #<7 #/\ Sum #>0 #/\ (Parcial #= Parcial1 + 1  #/\ Inteiro #= Inteiro1) ) #\/  %funcionario parcial
	 (Sum #>6  #/\	(Parcial #= Parcial1  #/\ Inteiro #= Inteiro1 + 1)) #\/   %funcionario a tempo Inteiro
	 			(Parcial #= Parcial1  #/\ Inteiro #= Inteiro1 ). % funcionario vazio


dinheiro([],Dinheiro):- Dinheiro #= 0.
dinheiro([H|T],Dinheiro):-
	dinheiro(T,Dinheiro1),
	sum(H,#=,Sum),
	 ( Sum #<7 #/\ Sum #>0 #/\ (Dinheiro #= (Sum-3)*60 + 3*50 + Dinheiro1) ) #\/  %funcionario parcial  (Sum-3, o Número de horas extra)
	 (Sum #>5  #/\	Dinheiro #= (Sum-7)*40 + 7*80 + Dinheiro1) #\/   %funcionario a tempo Inteiro (Sum-7, o númeor de horas extra)
	 			Dinheiro #= Dinheiro1 . % funcionario vazio
	


validate_func([_,_|[]]).
validate_func([Y,Z,W |[]]):-
         Y#\=0 #\/ Z#\=1 #\/ W#\=0.
validate_func([X,Y,Z,W|T]):-
         (X#\=0 #\/ Y#\=1 #\/ Z#\=0) #/\ 
         (X#\=1 #\/ Y#\=0 #\/ Z#\=0 #\/ W#\= 1) #/\
         (X#\=0 #\/ Y#\=1 #\/ Z#\=1 #\/ W#\=0),
         validate_func([Y,Z,W|T]).
         
validate_horario([],_).
validate_horario([H|T],N):-
        validate_func(H),
        validate_horario(T,N).

get_Nth_list([],_,_).
get_Nth_list([H|T], N , [H1|T1]):-
	element(N,H,H1),
	get_Nth_list(T,N,T1).

set_min_func([],_,_,_).		
set_min_func([],NMax,NMax,_).	
set_min_func([H|T],N,NMax,Horario):-
	get_Nth_list(Horario,N,Nelem),
	sum(Nelem,#>=,H),
	N1 is N+1,
	set_min_func(T,N1,NMax,Horario).

min_func(Horario,Vars):-
	length(Vars,N),
	set_min_func(Vars,1,N,Horario).
	
%count_func_parc().

%count_func_norm([],0).
%count_func_norm([H|T],Normais):-
 %       sum(H,>=,Sum),
  %      count_func([T],N1),
   %     Normais is N1+1).
                        






wre([]).
wre([H1,H2,H3,H4,H5,H6,H7,H8|T]):-
	write(H1),write(H2),write(H3),write(H4),write(H5),write(H6),write(H7),write(H8),nl,
	wre(T).	

funcionario(Horario):-
	Vars = [4,8,2,4,8,6,2,2],
	domain([Parciais],0,5),
	domain([Normais],1,10),
	domain([D],1,100000),
	(Parciais/Normais)*100 #< 30,
	length(Hor,10),
	horario_func(Hor),
        length(Vars,N),
        validate_horario(Hor,N),
	min_func(Hor,Vars),
	num_func(Hor,Parciais,Normais),
	dinheiro(Hor,Dinheiro),
	D #= Dinheiro,
	append(Hor,Horario),
	labeling([minimize(D)],Horario),
	wre(Horario).
		
   
      