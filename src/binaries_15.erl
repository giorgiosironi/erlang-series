-module(binaries_15).
-include_lib("eunit/include/eunit.hrl").

binary_representation_test() ->
    Bin = term_to_binary(a),
    ?assertEqual(<<131, 100, 0, 1, 97>>, Bin).

binary_conversions_test() ->
    Bin = term_to_binary(a),
    ?assertEqual(a, binary_to_term(Bin)).

binary_complex_conversions_test() ->
    Bin = term_to_binary({a, 42, {b, c}}),
    ?assertEqual({a, 42, {b, c}}, binary_to_term(Bin)).

bit_building_test() ->
    G=6*16+6,
    B=9*16+9,
    Bin = <<0, G, B>>,
    ?assertEqual([0, G, B], binary_to_list(Bin)).

bit_pattern_matching_test() ->
    G=6*16+6,
    B=9*16+9,
    Bin = <<0, G, B>>,
    <<0, G, Blue>> = Bin,
    ?assertEqual(B, Blue).

bin_types_test() ->
    ?assertEqual(<<"A">>, <<4:4, 1:4>>).

bin_pattern_matching_with_types_test() ->
    Bin = <<"Answer", 42, "ok">>,
    <<"Answer", Int, Result/binary>> = Bin,
    ?assertEqual(42, Int),
    ?assertEqual(<<"ok">>, Result).

