#!/bin/bash

print_all() {
  local -r this_dir=$(dirname $(readlink -f $0))

  if [[ ${mode} == build ]]; then
    local -r script="bash ${this_dir}/build.sh"
    local -r benchs=(
      "brotli"
      "http-parser"
      "jsmn"
      "libhtp-benchmark"
      "libyaml-benchmark"
      "openssl-benchmark"
    )
  elif [[ ${mode} == run ]]; then
    local -r script="bash ${this_dir}/run.sh"
    local -r benchs=(
      "brotli"
      "http"
      "jsmn"
      "libhtp"
      "libyaml"
      "openssl_rsa"
      "openssl_dsa"
      "openssl_ecdsa"
    )
  else
    echo "ERROR: the first argument should be either 'build' or 'run'" 1>&2
    exit 1
  fi

  local -r percents=(
    1
    2
    3
    4
    5
    10
    20
    30
    40
    50
  )

  for bench in ${benchs[@]}
  do
    for percent in ${percents[@]}
    do
      for copy in $(seq 1 ${num_copies})
      do
        echo "${script} ${bench} ${percent} ${copy}"
      done
    done
    # single copy with copy id 0 for the two since they're deterministic
    for percent in 0 100
    do
      echo "${script} ${bench} ${percent} 0"
    done
  done
}

main() {
  print_all
}

declare -rg mode="${1}"
if [[ ${2} != "" ]]; then
  declare -rg num_copies="${2}"
else
  declare -rg num_copies=10
fi

main
