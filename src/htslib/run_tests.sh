#!/usr/bin/env bash

test/fieldarith test/fieldarith.sam
test/hfile
test/sam
test/test-regidx
#cd test && REF_PATH=: ./test_view.pl
cd test && ./test_view.pl
./test.pl