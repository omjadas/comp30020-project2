puzzle_solution(Solution) :-
    diagonal(Solution),
    digits(Solution),
    repeats(Solution),
    rows(Solution).

diagonal(Solution).

digits(Solution).

repeats(Solution).

rows(Solution).

valid(Solution):- product(Solution); sum(Solution).

product(Solution).

sum(Solution).
