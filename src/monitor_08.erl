-module(monitor_08).
-include_lib("eunit/include/eunit.hrl").

new_parent(Interested) ->
    spawn(fun() -> parent_loop(Interested) end).

new_child(Parent, Name) ->
    Parent ! {new_child, Name, self()},
    receive {created, Child} -> Child end.

parent_loop(Interested) ->
    parent_loop(Interested, 0).

parent_loop(Interested, ChildrenNumber) ->
    receive
        {new_child, _Name, Sender} -> Pid = spawn(fun() -> child_loop() end),
                             erlang:monitor(process, Pid),
                             Sender ! {created, Pid},
                             Interested ! {children, ChildrenNumber + 1},

                             parent_loop(Interested, ChildrenNumber + 1);
        {'DOWN', _Reference, process, _Pid, _Reason} ->
                             Interested ! {children, ChildrenNumber - 1},
                             Pid = spawn(fun() -> child_loop() end),
                             erlang:monitor(process, Pid),
                             Interested ! {children, ChildrenNumber},
                             parent_loop(Interested, ChildrenNumber + 1)
    end.

child_loop() ->
    receive
        {crash} -> 1 / 0
    end.

constant_number_of_children_test() ->
    Parent = new_parent(self()),
    _Child1 = new_child(Parent, "1"),
    Child2 = new_child(Parent, "2"),
    Child2 ! {crash},
    receive_event(1),
    receive_event(2),
    receive_event(1),
    receive_event(2).

receive_event(ExpectedNumber) ->
    receive
        {children, ActualNumber} -> ActualNumber
    end,
    ?assertEqual(ExpectedNumber, ActualNumber).
