-module(distance_06).
-include_lib("eunit/include/eunit.hrl").

distance_parallel(FirstPoint, SecondPoint) ->
    parallelize_dimensions(FirstPoint, SecondPoint),
    Squares = collect(length(FirstPoint)),
    math:sqrt(lists:sum(Squares)).

collect(N) ->
    collect(N, []).
collect(0, SquaresAccumulator) -> SquaresAccumulator;
collect(N, SquaresAccumulator) ->
    receive
        {dimension, Result} -> done
    end,
    collect(N - 1, lists:append(SquaresAccumulator, [Result])).

parallelize_dimensions([], []) -> ok;
parallelize_dimensions([HeadFirst|TailFirst], [HeadSecond|TailSecond]) ->
    Pid = self(),
    spawn(fun() -> difference_squared(HeadFirst, HeadSecond, Pid) end),
    parallelize_dimensions(TailFirst, TailSecond).

difference_squared(X1, X2, Destination) ->
    Difference = X1 - X2,
    Result = math:pow(Difference, 2),
    Destination ! {dimension, Result}.

distance_parallel_test() ->
    ?assertEqual(0.0, distance_parallel([1], [1])),
    ?assertEqual(1.0, distance_parallel([2], [3])),
    ?assertEqual(5.0, distance_parallel([0, 0], [3, 4])),
    ?assertEqual(2.0, distance_parallel([1, 2, 3, 4], [2, 3, 4, 5])).

    
