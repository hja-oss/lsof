#!/usr/bin/env bash
# Regression test for https://github.com/lsof-org/lsof/issues/413
#
# Two ports in one -i selector create two network selection entries that share
# the protocol string.  lsof must exit normally whether or not either port is
# open, instead of aborting in lsof_destroy() with a double free.
source tests/common.bash

{
    "$lsof" -nP -ti tcp:4193,4194 > /dev/null 2>&1
    status=$?
    case $status in
    0|1)
        echo "PASS: multi-port TCP lookup exited with status $status"
        ;;
    *)
        echo "FAIL: multi-port TCP lookup exited with status $status"
        exit 1
        ;;
    esac
} >> "$report" 2>&1
