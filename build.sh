#!/bin/bash
rm -rf bin
mkdir bin
erl -make
cd bin
erl -noshell -eval 'eunit:test([{dir, "."}], [verbose])' -s init stop
