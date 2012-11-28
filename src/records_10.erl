-module(records_10).
-include_lib("eunit/include/eunit.hrl").
-record(purchase, {name, price, merchant=default}).

record_creation_test() ->
    P = #purchase{name="Giorgio",
                price=10.00,
                merchant=bakery},
    ?assertEqual("Giorgio", P#purchase.name).

record_default_value_test() ->
    P2 = #purchase{name="Giorgio",
                price=10.00},
    ?assertEqual(default, P2#purchase.merchant).

record_modification_test() ->
    P = #purchase{name="Giorgio", price=10.00},
    NewP = P#purchase{price=20.00},
    ?assertEqual(#purchase{name="Giorgio", price=20.00},
                 NewP).

record_pattern_matching_test() ->
    P = #purchase{name="Giorgio", price=10.00},
    ?assertEqual(2.0, fixed_tax(P)).

fixed_tax(#purchase{price=Price} = Purchase) ->
	Price * 0.20.

record_multiple_pattern_matching_test() ->
    ?assertEqual(2.0, variable_tax(#purchase{name="Giorgio",
                                            price=10.00})),
    ?assertEqual(0.4, variable_tax(#purchase{name="Giorgio", 
                                            price=10.00,
                                            merchant=bakery})).

variable_tax(#purchase{price=Price,merchant=bakery} = Purchase) ->
	Price * 0.04;
variable_tax(#purchase{price=Price} = Purchase) ->
	Price * 0.20.

record_info_on_fields_test() ->
    ?assertEqual([name, price, merchant],
                record_info(fields, purchase)).
