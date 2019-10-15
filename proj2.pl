:- ensure_loaded(library(clpfd)).

% File     : proj2.pl
% Author   : Omja Das <odas@student.unimelb.edu.au>
% Purpose  : A solver for maths puzzles

%! puzzle_solution(+Puzzle)
%  
puzzle_solution(Puzzle) :-
    diagonal(Puzzle),
    digits(Puzzle),
    transpose(Puzzle, Transposed_Puzzle),
    repeats_puzzle(Puzzle),
    repeats_puzzle(Transposed_Puzzle),
    valid_puzzle(Puzzle),
    valid_puzzle(Transposed_Puzzle),
    maplist(labeling([]), Puzzle).

%! diagonal(-Puzzle)
diagonal([_, Row|Rows]) :-
    nth0(1, Row, X),
    diagonal(Rows, 2, X).

%! diagonal(-Rows,-Index,-Number)
diagonal([], _, _).
diagonal([Row|Rows], I, X) :-
    nth0(I, Row, X),
    I1 #= I+1,
    diagonal(Rows, I1, X).

%! digits(+Puzzle)
digits([_|Rows]) :-
    maplist(digit, Rows).

%! digit(+Row)
digit([_|Squares]) :-
    Squares ins 1..9.

%! repeats_puzzle(-Puzzle)
repeats_puzzle([_|Rows]) :-
    maplist(repeats, Rows).

%! repeats(-Squares)
repeats([_|Squares]) :-
    is_set(Squares).

%! valid_puzzle(-Puzzle)
valid_puzzle([_|Rows]) :- maplist(valid_row, Rows).

%! valid_row(-Row)
valid_row(Row) :-
    product_row(Row);
    sum_row(Row).

%! product_row(-Row)
product_row([Square|Squares]) :-
    product_list(Squares, 1, Square).

%! sum_row(-Row)
sum_row([Square|Squares]) :-
    my_sum_list(Squares, Square).

%! my_sum_list(-List, -Sum)
my_sum_list(List, Sum) :-
    my_sum_list(List, 0, Sum).

%! my_sum_list(-List, -Accumulator, -Sum)
my_sum_list([],Sum,Sum).
my_sum_list([X|Xs], A, Sum) :-
    A1 #= A+X,
    my_sum_list(Xs, A1, Sum).

%! product_list(-List, -Product)
product_list(List, Product) :-
    product_list(List, 1, Product).

%! product_list(-List, -Accumulator, -Product)
product_list([], Product, Product).
product_list([X|Xs], A, Product) :-
    A1 #= X*A,
    product_list(Xs, A1, Product).
