-module(macros_11).
-include_lib("eunit/include/eunit.hrl").  
-define(ANSWER, 42).

constant_test() ->
    ?assertEqual(42, ?ANSWER).

-define(INC, 1+).

hello_test() ->
    ?assertEqual(43, ?INC 42).

-define(HELLO(Who), string:concat("Hello, ", Who)).

parameterized_test() ->
    ?assertEqual("Hello, World", ?HELLO("World")).

-define(IsZero(N), N == 0).

factorial(N) when ?IsZero(N) -> 1;
factorial(N)                 -> N * factorial(N - 1).

cannot_always_use_a_function_test() ->
    ?assertEqual(6, factorial(3)).

-define(VALUE(Call),[??Call,Call]).

debugging_test() ->
    ?assertEqual(["length ( [ 1 , 2 , 3 ] )", 3], ?VALUE(length([1,2,3]))).  

magic_constants_test() ->
    ?assertEqual(macros_11, ?MODULE),
    ?assertEqual("macros_11", ?MODULE_STRING),
    ?assertEqual("src/macros_11.erl", ?FILE),
    ?assertEqual(35, ?LINE).

