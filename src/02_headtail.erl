#!/usr/bin/escript
head([]) -> throw( error);
head([Element | _Tail]) -> Element.

main(_) -> io:format("Head of [1]: ~p~n", [head([1])]),
           io:format("Head of [1, 2]: ~p~n", [head([1, 2])]).
