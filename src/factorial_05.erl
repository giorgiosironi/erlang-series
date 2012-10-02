-module(factorial_05).
-include_lib("eunit/include/eunit.hrl").

tail_factorial(N) -> tail_factorial(1, N).

tail_factorial(N, 0) -> N;
tail_factorial(Result, N) -> tail_factorial(Result * N, N - 1).

zip(First, Second) -> zip([], First, Second).

zip(Result, [], []) -> Result;
zip(Result, [FirstHead|FirstTail], [SecondHead|SecondTail]) -> 
    zip(Result ++ [{FirstHead, SecondHead}], FirstTail, SecondTail).

average(Numbers) -> 
    {Total, Size} = average(0, 0, Numbers),
    Total / Size.

average(Total, Size, []) -> {Total, Size};
average(Total, Size, [Head|Tail]) -> 
    average(Total + Head, Size + 1, Tail).


factorial_test() ->
    ?assertEqual(6, tail_factorial(3)),
    ?assertEqual(2, tail_factorial(2)),
    ?assertEqual(1, tail_factorial(1)),
    ?assertEqual(1, tail_factorial(0)).

zip_test() ->
    ?assertEqual([],
                 zip([], [])),
    ?assertEqual([{a, 'alpha'}],
                 zip([a], ['alpha'])),
    ?assertEqual([{a, 'alpha'}, {b, 'bravo'}, {c, 'charlie'}],
                 zip([a, b, c], ['alpha', 'bravo', 'charlie'])).

average_test() ->
    ?assertEqual(2.0, average([2])),
    ?assertEqual(2.0, average([1, 3])),
    ?assertEqual(2.0, average([1, 3, 1, 1, 1, 5])).
