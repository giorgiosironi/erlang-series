-module(factorial_04).
-include_lib("eunit/include/eunit.hrl").
-export([guard_factorial/1, y/1]).

recursive_factorial(0) -> 1;
recursive_factorial(N) -> recursive_factorial(N - 1) * N.

guard_factorial(N) when N < 2 -> 1;
guard_factorial(N) -> guard_factorial(N - 1) * N.

case_factorial(N) ->
    case N of
        0 -> 1;
        _ -> case_factorial(N - 1) * N 
    end.

y(M) ->
    G = fun (F) -> 
        M(fun(A) -> (F(F))(A) end)
    end,
    G(G).

simple_test() ->
    ?assertEqual(6, recursive_factorial(3)),
    ?assertEqual(2, recursive_factorial(2)),
    ?assertEqual(1, recursive_factorial(1)),
    ?assertEqual(1, recursive_factorial(1)),

    ?assertEqual(6, guard_factorial(3)),
    ?assertEqual(2, guard_factorial(2)),
    ?assertEqual(1, guard_factorial(1)),
    ?assertEqual(1, guard_factorial(1)),

    ?assertEqual(6, case_factorial(3)),
    ?assertEqual(2, case_factorial(2)),
    ?assertEqual(1, case_factorial(1)),
    ?assertEqual(1, case_factorial(1)),
    
    ?assertEqual(6, apply(factorial_04, guard_factorial, [3])),
    
    Factorial = fun(N, F) ->
        case N of
            0 -> 1;
            _ -> apply(F, [N-1, F]) * N 
        end
    end,
    ?assertEqual(6, apply(Factorial, [3, Factorial])),
    
    FactorialY = 
        fun(F) ->
            fun (N) ->
                case N of
                    0 -> 1;
                    _ -> F(N-1) * N 
                end
            end
        end,
    ?assertEqual(6, apply(y(FactorialY), [3])).

    
