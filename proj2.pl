:- ensure_loaded(library(clpfd)).

puzzle_solution(Solution) :-
    diagonal(Solution),
    digits(Solution),
    transpose(Solution, Transposed_Solution),
    repeats_puzzle(Solution),
    repeats_puzzle(Transposed_Solution),
    valid_puzzle(Solution),
    valid_puzzle(Transposed_Solution),
    maplist(labeling([]), Solution).

diagonal([_, Row|Rows]) :-
    nth0(1, Row, X),
    diagonal(Rows, 2, X).

diagonal([], _, _).
diagonal([Row|Rows], I, X) :-
    nth0(I, Row, X),
    I1 #= I+1,
    diagonal(Rows, I1, X).

digits([_|Rows]) :-
    maplist(digit, Rows).

digit([_|Rows]) :-
    Rows ins 1..9.

repeats_puzzle([_|Rows]) :-
    maplist(repeats, Rows).

repeats([_|Rows]) :-
    is_set(Rows).

valid_puzzle([_|Rows]) :- maplist(valid_row, Rows).

valid_row(Row) :-
    product_row(Row);
    sum_row(Row).

product_row([Row|Rows]) :-
    product_list(Rows, 1, Row).

sum_row([Row|Rows]) :-
    my_sum_list(Rows, Row).

my_sum_list(List, Sum) :-
    my_sum_list(List, 0, Sum).

my_sum_list([],Sum,Sum).
my_sum_list([X|Xs], A, Sum):-
    A1 #= A+X,
    my_sum_list(Xs, A1, Sum).

product_list(List, Product):-
    product_list(List, 1, Product).

product_list([], Product, Product).
product_list([X|Xs], A, Product) :-
    A1 #= X*A,
    product_list(Xs, A1, Product).
