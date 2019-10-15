:- ensure_loaded(library(clpfd)).

puzzle_solution(Solution) :-
    diagonal(Solution),
    digits(Solution),
    transpose(Solution, Transposed_Solution),
    repeats_puzzle(Solution),
    repeats_puzzle(Transposed_Solution),
    valid(Solution),
    valid(Transposed_Solution),
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

repeats([_|R]) :-
    is_set(R).

valid([_|Rs]) :-
    maplist(product_row, Rs);
    maplist(sum_row, Rs).

product_list([], 1).
product_list([X|Xs], P) :-
    product_list(Xs, P1),
    P #= X*P1.

product_row([R|Rs]) :-
    product_list(Rs, R).

sum_row([R|Rs]) :-
    my_sum_list(Rs, R).

my_sum_list([], 0).
my_sum_list([X|Xs], Sum) :-
    my_sum_list(Xs, Sum1),
    Sum #= X+Sum1.
