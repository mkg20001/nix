#!/bin/sh

git show -s --format=%cI | date "+%H-%M_%d.%m.%Y" > $(dirname $(readlink -f $0))/../rev
