-module(listcomprehensions_14).
-include_lib("eunit/include/eunit.hrl").

map_test() ->
    ?assertEqual([1, 4, 9], [X*X || X <- [1, 2, 3]]).

filter_test() ->
    ?assertEqual([42, 5], [X || X <- [-1, 42, -2, 5], X > 0]).

filter_map_test() ->
    ?assertEqual([1, 4], [X*X || X <- [-1, 42, -2, 5], X < 0]).

pattern_matching_test() ->
    % Monomia?
    Monomia = [{a, 2}, {b, 3}, {a, 5}],
    ?assertEqual([2, 5], [Exponent || {Letter, Exponent} <- Monomia, Letter == a]).
% TODO implement ./build.sh listcomprehensions_14

two_nested_generators_test() ->
    Letters = [a, b],
    Numbers = [1, 2],
    Expected = [{a, 1}, {a, 2}, {b, 1}, {b, 2}],
    ?assertEqual(Expected, [{Letter, Exponent} || Letter <- Letters, Exponent <- Numbers]).

unroll_test() ->
    ListOfLists = [[1, 2], [3, 4, 5]],
    ?assertEqual([1, 2, 3, 4, 5], [X || SingleList <- ListOfLists, X <- SingleList]).

qsort([]) -> [];
qsort([X|Xs]) ->
    qsort([Y || Y <- Xs, Y =< X]) ++ [X] ++ qsort([Y || Y <- Xs, Y > X]).

quicksort_test() ->
    Unsorted = [3, 1, 2, 5, 4],
    ?assertEqual([1, 2, 3, 4, 5], qsort(Unsorted)).
