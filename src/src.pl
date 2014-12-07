:-use_module(library(clpfd)).


func(Horario,Salario):- Salario  #<= 7*80, Horario #<= 7.

horario_func([0,0,0,0,0,0,0,0]).

adic_func_parcial.

adic_func_normal.

adic_func_normal_extra.

adic_func_parcil_extra.


dist_func:-
        Extras  #<= 2,
        Dinheiro,
        Vars=[H1,H2,H3,H4,H5,H6,H7,H8],
        H1 #> 3,
        H2 #> 2,
        H3 #> 2,
        H4 #> 5,
        H5 #> 4,
        H6 #> 5,
        H7 #> 7,
        H8 #> 7,
        Parciais #< 6,
        Parciais/(Parciais+Normais) #<= 0.3,
        












