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

diagonal([_, [_|R]|Rs]) :-
    nth0(1, R, X),
    diagonal(Rs, 2, X).

diagonal([], _, _).
diagonal([[_|R]|Rs], I, X) :-
    nth0(I, R, X),
    I1 is I+1,
    diagonal(Rs, I1, X).

digits([_, [_|R]|Rs]) :-
    maplist(digit, R),
    digits([_, Rs]).

digit(X) :-
    X>=1,
    X=<9.

repeats_puzzle([_|Rs]) :-
    maplist(repeats, Rs).

repeats([_, R]) :-
    sort(R, Sorted_R),
    length(R, L),
    length(Sorted_R, L).

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
