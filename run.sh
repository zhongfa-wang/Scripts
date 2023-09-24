#!/bin/bash
cd ~/benchmarks/run/scripts
./print_commands.sh build 10 > command_build
nice -n 3 taskset -c 0-63 parallel -j 64 < ./command_build

./print_commands.sh evaluate 10 > command_evaluate
nice -n 3 taskset -c 0-63 parallel -j 64 < ./command_evaluate

rm command_build command_evaluate

cd ~/benchmarks/bin/
ls | sudo parallel -j64 -k 'rm -rf {.}'