-module(functional_13).
-include_lib("eunit/include/eunit.hrl").

square(N) -> N * N.

anonymous_function_test() ->
    Squared = (fun(N) -> N*N end)(5),
    ?assertEqual(25, Squared).

assigned_anonymous_function_test() ->
    Square = fun(N) -> N*N end,
    Squared = Square(5),
    ?assertEqual(25, Squared).

closure_currying_test() ->
    Times = fun(M) -> fun(N) -> M * N end end,
    FiveTimes = Times(5),
    ?assertEqual(15, FiveTimes(3)).

map_test() ->
    Square = fun(N) -> N*N end,
    ?assertEqual([1, 4, 9], lists:map(Square, [1, 2, 3])).

reduce_test () -> nothing. %implement

filter_test() ->
    IsSquare = fun(N) -> N == 4 end, %TODO: implement and extract
    ?assertEqual([4], lists:filter(IsSquare, [3, 4, 5])).

all_test() ->
    IsSquare = fun(N) -> N == 4 end, %TODO implement and extract
    ?assertEqual(true, lists:all(IsSquare, [4])), %TODO extend
    ?assertEqual(false, lists:all(IsSquare, [3, 4])). %TODO extend

any_test() ->
    IsSquare = fun(N) -> N == 4 end, %TODO implement and extract
    ?assertEqual(true, lists:any(IsSquare, [3, 4, 5])),
    ?assertEqual(false, lists:any(IsSquare, [3, 5, 7])).

dropwhile_test() ->
    IsSquare = fun(N) -> N == 4 end, %TODO implement and extract
    ?assertEqual([5], lists:dropwhile(IsSquare, [4, 5])). % extend

foldl_test() ->
    Sum = fun(A, B) -> A + B end,
    ?assertEqual(10, lists:foldl(Sum, 0, [1, 2, 3, 4])).

zip_test () -> nothing. %TODO write a test case
