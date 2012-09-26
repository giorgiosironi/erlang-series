-module(numbers_test_03).
-include_lib("eunit/include/eunit.hrl").

simple_test() ->
    ?assert(1 == 1),
    ?assertNot(1 == 0),
    ?assertMatch({number, _Var}, {number, 42}),
    ?assertEqual(1, 1),
    ?assertError(undef, lists:append()).
    
