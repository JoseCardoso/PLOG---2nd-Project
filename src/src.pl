:-use_module(library(clpfd)).
:-use_module(library(lists)).

horario_func([],_).
horario_func([H|T],N):-
	length(H,N),
	domain(H,0,1),
	sum(H,#=,Sum),
	Sum #= 7  #\/
	Sum #= 8 #\/ 
	Sum #= 3 #\/ 
        Sum #= 4 #\/ 
        Sum #= 0,
	horario_func(T,N).

num_func([],Parcial,Inteiro):- Parcial #= 0, Inteiro#= 0.
num_func([H|T],Parcial,Inteiro):- 
	num_func(T,Parcial1,Inteiro1),
	sum(H,#=,Sum),
	 (( Sum #<7 #/\ Sum #>0) #/\ (Parcial #= Parcial1 + 1  #/\ Inteiro #= Inteiro1)) #\/  %funcionario parcial
	 ((Sum #>6)  #/\ (Parcial #= Parcial1  #/\ Inteiro #= Inteiro1 + 1)) #\/   %funcionario a tempo Inteiro
	 ((Sum #=0 ) #/\ (Parcial #= Parcial1  #/\ Inteiro #= Inteiro1) ). % funcionario vazio

num_extras([],Extras):-Extras #=0.
num_extras([H|T],Extras):-
        num_extras(T,Extras1),
        sum(H,#=,Sum),
        ((Sum#=8 #\/ Sum#=4) #/\ Extras #= Extras1 + 1) #\/
        ((Sum#\=8 #/\ Sum #\=4) #/\ Extras #= Extras1).
        

dinheiro([],Dinheiro):- Dinheiro #= 0.
dinheiro([H|T],Dinheiro):-
	dinheiro(T,Dinheiro1),
	sum(H,#=,Sum),
	((Sum #< 7 #/\Sum#>0) #/\ Dinheiro #= (Sum-3)*60 + 3*50 + Dinheiro1) #\/  %funcionario parcial  (Sum-3, o Número de horas extra)
	((Sum #> 6) #/\	Dinheiro #= (Sum-7)*40 + 7*80 + Dinheiro1) #\/   %funcionario a tempo Inteiro (Sum-7, o númeor de horas extra)
        ((Sum #= 0) #/\ Dinheiro1 #= Dinheiro).

validate_func([_,_|[]],_).
validate_func([Y,Z,W |[]],_):-
         Y#\=0 #\/ Z#\=1 #\/ W#\=0.
validate_func([X,Y,Z,W|[]],Sum):-
         (X#\=0 #\/ Y#\=1 #\/ Z#\=0) #/\ 
         (X#\=1 #\/ Y#\=0 #\/ Z#\=0 #\/ W#\= 1) #/\
         (X#\=0 #\/ Y#\=1 #\/ Z#\=1 #\/ W#\=0),
         validate_func([Y,Z,W],Sum).
validate_func([X,Y,Z,W,U|T],Sum):-
        ((Sum #\=7) #\/ ((X #\= 1) #\/(Y #\= 1) #\/(Z #\= 1) #\/(W #\= 1) #\/(U #\= 1))) #/\
        (X#\=0 #\/ Y#\=1 #\/ Z#\=0) #/\ 
        (X#\=1 #\/ Y#\=0 #\/ Z#\=0 #\/ W#\= 1) #/\
        (X#\=0 #\/ Y#\=1 #\/ Z#\=1 #\/ W#\=0),
        validate_func([Y,Z,W,U|T],Sum).
         
validate_horario([],_).
validate_horario([H|T],N):-
        sum(H,#=,Sum),
        validate_func(H,Sum),
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
                        
escrever([]).
escrever([X|T]):-
        write(X), write('  ') , escrever(T).
        
escreverHorario([]).
escreverHorario([H|T]):-
        escrever(H),nl,nl,escreverHorario(T).	

funcionario(Vars,MaxFunc,MaxPart,MaxExtra,MaxCost,Horario):-        
	(Parciais*100 #=< 30*Normais),% #/\ (Parciais + Normais #=< MaxFunc), % +10 espaço de reserva
        length(Vars,N),
	domain([Parciais],0,MaxPart),
	domain([Normais],1,MaxFunc),
        domain([Extras],0,MaxExtra),
	domain([Dinheiro],1,MaxCost),
	length(Hor,MaxFunc),
	horario_func(Hor,N),
        validate_horario(Hor,N),
	min_func(Hor,Vars),
	num_func(Hor,Parciais,Normais),
        num_extras(Hor,Extras),
	dinheiro(Hor,Dinheiro),
	append(Hor,Horario),
	labeling([minimize(Dinheiro),time_out(60000,_)],Horario),
        escreverHorario(Hor),nl,nl,
        escrever(Vars),nl,
        write('Cost: '),write(Dinheiro),nl,
        write('Number of Part-time workers: '), write(Parciais),nl,
        write('Number of Full-time workers: '), write(Normais),nl,
        write('Number of workers doing extra hours: '),write(Extras).
		