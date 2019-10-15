:- ensure loaded(library(clpfd)).

puzzle_solution(Solution) :-
    diagonal(Solution),
    digits(Solution),
    transpose(Solution, Transposed_Solution),
    repeats(Solution),
    repeats(Transposed_Solution),
    rows(Solution),
    rows(Transposed_Solution).

diagonal(Solution).

digits(Solution).

repeats(Solution).

rows(Solution).

valid(Solution):- product(Solution); sum(Solution).

product(Solution).

sum(Solution).
