-module(fail_07).
-include_lib("eunit/include/eunit.hrl").
-export([parent/0, child/2]).

happy_path_test() ->
    Server = spawn(fail_07, parent, []),
    Server ! {divide, 2, self()},
    receive
        {result, Result} -> Result
    end,
    ?assertEqual(21, Result).

divide_by_zero_test() ->
    Server = spawn(fail_07, parent, []),
    Server ! {divide, 0, self()},
    Status = receive
        {result, _} -> ok
    after 2000 -> error
    end,
    ?assertEqual(error, Status),
    Server ! {ping, self()},
    receive
        {pong, Server} -> ok
    end.

parent() ->
    process_flag(trap_exit, true),
    parent_loop().

parent_loop() ->
    receive
        {'EXIT', _Pid, {ErrorCode, _}} -> ErrorCode;
        {divide, Divisor, AnswerTo} -> spawn_link(fail_07, child, [Divisor, AnswerTo]);
        {ping, AnswerTo} -> AnswerTo ! {pong, self()}
    end,
    parent_loop().

child(Divisor, AnswerTo) ->
    timer:sleep(1000),
    Result = 42 div Divisor,  % integer division
    AnswerTo ! {result, Result}.

