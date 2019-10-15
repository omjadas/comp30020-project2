:- ensure_loaded(library(clpfd)).

% File     : proj2.pl
% Author   : Omja Das <odas@student.unimelb.edu.au>
% Purpose  : A solver for maths puzzles

%! puzzle_solution(+Puzzle)
%  Solves / verifies a maths puzzle
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
%  Checks the diagonals of a maths puzzle
diagonal([_, Row|Rows]) :-
    nth0(1, Row, X),
    diagonal(Rows, 2, X).

%! diagonal(-Rows,-Index,-Number)
%  Checks the entry in the row that lies on the diagonal
diagonal([], _, _).
diagonal([Row|Rows], I, X) :-
    nth0(I, Row, X),
    I1 #= I+1,
    diagonal(Rows, I1, X).

%! digits(+Puzzle)
%  Checks the digits of the solution
digits([_|Rows]) :-
    maplist(digit, Rows).

%! digit(+Row)
%  Checks the solution digits of a row are between 1 and 9 (inclusive)
digit([_|Squares]) :-
    Squares ins 1..9.

%! repeats_puzzle(-Puzzle)
%  Checks that there are no repeated numbers in each row of a puzzle
repeats_puzzle([_|Rows]) :-
    maplist(repeats_row, Rows).

%! repeats_row(-Squares)
%  Checks that there are no repeated numbers in a given row
repeats_row([_|Squares]) :-
    is_set(Squares).

%! valid_puzzle(-Puzzle)
%  Checks that each row of a puzzle is valid (either its sum or product is
%  equal to it's heading)
valid_puzzle([_|Rows]) :- maplist(valid_row, Rows).

%! valid_row(-Row)
%  Checks that an individual row is valid
valid_row(Row) :-
    product_row(Row);
    sum_row(Row).

%! product_row(-Row)
%  Checks if a row's heading is equal to its product
product_row([Square|Squares]) :-
    product_list(Squares, 1, Square).

%! sum_row(-Row)
%  Checks if a row's heading is equal to its sum
sum_row([Square|Squares]) :-
    my_sum_list(Squares, Square).

%! my_sum_list(-List, -Sum)
%  Checks that the sum of each element in a list is equal to Sum
my_sum_list(List, Sum) :-
    my_sum_list(List, 0, Sum).

%! my_sum_list(-List, -Accumulator, -Sum)
my_sum_list([],Sum,Sum).
my_sum_list([X|Xs], A, Sum) :-
    A1 #= A+X,
    my_sum_list(Xs, A1, Sum).

%! product_list(-List, -Product)
%  Checks that the product of each element in a list is equal to Sum
product_list(List, Product) :-
    product_list(List, 1, Product).

%! product_list(-List, -Accumulator, -Product)
product_list([], Product, Product).
product_list([X|Xs], A, Product) :-
    A1 #= X*A,
    product_list(Xs, A1, Product).
