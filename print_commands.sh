#!/bin/bash

if [[ ${2} != "" ]] 
then
  declare -rg copies="${2}"
else
  declare -rg copies=10
fi


declare -rg this_path=$(dirname $(readlink -f $0))
declare -rg mold=$1

print() {
  local -r percents=(
    0
    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    20
    30
  )
  local -r patches=(
    native
    slh
    patched
  )
  if [[ $mold == build ]]; then
    local -r script="bash ${this_path}/build.sh"
    local -r benches=(
      "brotli"
      "http-parser"
      "jsmn"
      "libhtp-benchmark"
      "libyaml-benchmark"
      "openssl-benchmark"
    )
  elif [[ $mold == run ]]; then
    local -r script="bash ${this_path}/run.sh"
    local -r benches=(
      "brotli"
      "http"
      "jsmn"
      "libhtp"
      "libyaml"
      "openssl-rsa"
      "openssl-dsa"
      "openssl-ecdsa"
    )
  else
    echo "Error! The first flag should be either 'build' or 'run'!" 1>&2
    exit 1
  fi

  for bench in ${benches[@]}
  do
    for percent in ${percents[@]}
    do
      for copy in $(seq 1 ${copies})
      do
        echo "${script} ${bench} percent ${percent} ${copy}"
      done
    done
    # copies of origin SpecFuzz patches
    # -1 means that the proportionally inserting fence is disabled
    for patch in ${patches[@]}
    do
      for copy in $(seq 1 ${copies})
      do
        echo "${script} ${bench} ${patch} -1 ${copy}"
      done
    done
  done
}

main() {
  print
}

main
