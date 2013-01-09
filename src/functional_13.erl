-module(functional_13).
-include_lib("eunit/include/eunit.hrl").

square(N) -> N * N.

is_square(N) -> 
    Root = erlang:round(math:sqrt(N)),
    Root * Root == N.

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
    ?assertEqual([1, 4, 9], lists:map(fun square/1, [1, 2, 3])).

filter_test() ->
    ?assertEqual([4], lists:filter(fun is_square/1, [3, 4, 5])).

all_test() ->
    ?assertEqual(true, lists:all(fun is_square/1, [4, 9])),
    ?assertEqual(false, lists:all(fun is_square/1, [3, 4, 9])).

any_test() ->
    ?assertEqual(true, lists:any(fun is_square/1, [3, 4, 5])),
    ?assertEqual(false, lists:any(fun is_square/1, [3, 5, 7])).

dropwhile_test() ->
    ?assertEqual([5, 6], lists:dropwhile(fun is_square/1, [1, 4, 5, 6])).

takewhile_test() ->
    ?assertEqual([1, 4], lists:takewhile(fun is_square/1, [1, 4, 5, 6])).

foldl_test() ->
    Sum = fun(A, B) -> A + B end,
    ?assertEqual(10, lists:foldl(Sum, 0, [1, 2, 3, 4])).
