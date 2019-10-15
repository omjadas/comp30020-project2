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
    I1 is I+1,
    diagonal(Rs, I1, X).

digits([_]).
digits([_, [_|R]]) :-
    maplist(digit, R).
digits([_, [_|R]|Rs]) :-
    maplist(digit, R),
    digits([_, Rs]).

digit(X) :-
    between(1, 9, X).

repeats_puzzle([_|Rs]) :-
    maplist(repeats, Rs).

repeats([_|R]) :-
    is_set(R).

valid([_|Rs]) :-
    maplist(product_row, Rs),
    maplist(sum_row, Rs).

product_list([], 1).
product_list([X|Xs], P) :-
    product_list(Xs, Ps),
    P is X*Ps.

product_row([R|Rs]) :-
    product_list(Rs, R).

sum_row([R|Rs]) :-
    sum_list(Rs, R).
