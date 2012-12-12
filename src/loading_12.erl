-module(loading_12).
-export([wait_until_correct_answer/0]).

answer(_Question) -> 42.

wait_until_correct_answer() ->
    Answer = answer("6 times 7?"),
    io:format("Answer is: ~w~n", [Answer]),
    check_answer(Answer).

check_answer(42) ->
    ok;
check_answer(_) ->
    timer:sleep(2000),
    loading_12:wait_until_correct_answer().

