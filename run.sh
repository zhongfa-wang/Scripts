#!/bin/bash

declare -rg copies=${1}
declare -rg parallelism=${2}
declare -rg nice_level=${3}

run(){
  local -r script_dir="~/benchmarks/run/scripts"
  local -r bin_dir="~/benchmarks/bin/"
  cd "${script_dir}"
  ./print_commands.sh build "${copies}" > command_build
  nice -n "${nice_level}" taskset -c 0-63 parallel -j "${parallelism}" < ./command_build

  ./print_commands.sh evaluate "${copies}" > command_evaluate
  nice -n "${nice_level}" taskset -c 0-63 parallel -j "${parallelism}" < ./command_evaluate

  # rm command_build command_evaluate

  cd "${bin_dir}"
  ls | parallel -j64 -k 'rm -rf {.}'
  
  cd "${script_dir}"
  ./data_wrangling.sh
}

main(){
  run
}

main