-module(clientserver_07).
-include_lib("eunit/include/eunit.hrl").
-export([new_book/0]).

new_book() ->
    spawn(fun() -> book() end).

book() ->
    book([]).

book(Posts) ->
    receive
	{Sender, request, last} -> 
            Sender ! {reply, head(Posts)},
            NewPosts = Posts;
        {Sender, request, NewPost} ->
            Sender ! {reply, ok},
            NewPosts = lists:append([NewPost], Posts)
    end,
    book(NewPosts). 

head([]) -> 'No messages yet.';
head([Head|_Tail]) -> Head.

new_post(Server, Text) ->
    call(Server, Text).

last_post(Server) ->
    call(Server, last).

call(Server, Request) ->
    Server ! {self(), request, Request},
    receive
        {reply, Reply} -> Reply
    end.

client_server_test() ->
    Server = new_book(),
    ok = new_post(Server, "Hello, world"),
    ok = new_post(Server, "Greetings"),
    Post = last_post(Server),
    ?assertEqual("Greetings", Post).
