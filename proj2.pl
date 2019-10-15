:- ensure_loaded(library(clpfd)).

puzzle_solution(Solution) :-
    diagonal(Solution),
    digits(Solution),
    transpose(Solution, Transposed_Solution),
    repeats_puzzle(Solution),
    repeats_puzzle(Transposed_Solution),
    valid_puzzle(Solution),
    valid_puzzle(Transposed_Solution),
    ground(Solution).

diagonal([_, R|Rs]) :-
    nth0(1, R, X),
    diagonal(Rs, 2, X).

diagonal([], _, _).
diagonal([R|Rs], I, X) :-
    nth0(I, R, X),
    I1 #= I+1,
    diagonal(Rs, I1, X).

digits([_|Rs]) :-
    maplist(digit, Rs).

digit([_|Rs]) :-
    Rs ins 1..9.

repeats_puzzle([_|Rs]) :-
    maplist(repeats, Rs).

repeats([_|Rs]) :-
    is_set(Rs).

valid_puzzle([_|Rs]) :- maplist(valid_row, Rs).

valid_row(Row) :-
    product_row(Row);
    sum_row(Row).

product_row([R|Rs]) :-
    product_list(Rs, 1, R).

sum_row([R|Rs]) :-
    my_sum_list(Rs, R).

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

