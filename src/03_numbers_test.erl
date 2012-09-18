-module(numbers_test)
-include_lib("eunit/include/eunit.hrl")

simple_test() ->
    ?assert(length([1,2,3]) =:= 3).
    
