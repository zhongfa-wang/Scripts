#!/bin/bash
declare -rg bench=${1}
declare -rg patch=${2}
declare -rg percent=${3}
declare -rg copy=${4}

get_cmd(){
  local -rA assignments=(
    [libhtp]="srcdir=test/files"
  )
  [[ -v "${assignments[${bench}]}" ]] && local -r assignment="${assignments[${bench}]}" || local -r assignment=""

  if [[ ${patch} == "percent" ]]; then
    local -r binary="proportion"
  elif [[ ${patch} == "native" ]]; then
    local -r binary="native"
  elif [[ ${patch} == "slh" ]]; then
    local -r binary="slh"
  elif [[ ${patch} == "patched" ]]; then
    local -r binary="patched"
  else
    echo "Wrong patch!" 1>&2
    exit 1
  fi

  local -rA args=(
    [brotli]="--decompress enwik9.br -f"
    [http]="large.txt"
    [jsmn]="perf.json"
    [libhtp]="--gtest_filter=Benchmark.ConnectionWithManyTransactions"
    [libyaml]="small.yaml"
    [openssl-rsa]="speed rsa"
    [openssl-dsa]="speed dsa"
    [openssl-ecdsa]="speed ecdsa"
  )
  local -r cmd="${assignment} ./${binary} ${args[${bench}]}"
  echo "${cmd}"
}

get_src_dir(){
  local -rA src=(
    [brotli]="brotli"
    [http]="http-parser"
    [jsmn]="jsmn"
    [libhtp]="libhtp-benchmark"
    [libyaml]="libyaml-benchmark"
    [openssl-rsa]="openssl-benchmark"
    [openssl-dsa]="openssl-benchmark"
    [openssl-ecdsa]="openssl-benchmark"
  )
  echo "${src[${bench}]}"
}

run(){
  local -r bin_dir="${HOME}/benchmarks/bin/$(get_src_dir)-${patch}-${percent}-${copy}"
  local -r result_dir="${HOME}/benchmarks/results/raw"
  local -r result="time.out.${bench}-${patch}-${percent}-${copy}"
  local -r cmd="$(get_cmd)"

  if ! [[ -d ${bin_dir} ]]; then
    mkdir -p "${bin_dir}"
  fi
  cd ${bin_dir}
  if [[ $(get_src_dir) != "openssl-benchmark" ]];then
    if command -v /usr/bin/time > /dev/null; then
      /usr/bin/time -f %U -o ${result} ${cmd}
    else
      export TIMEFORMAT=%U
      { time ${cmd} > /dev/null 2>&1; } 2> "${bin_dir}/${result}"
    fi
  else
    ${cmd} > "${bin_dir}/${result}"
  fi

  mkdir -p ${result_dir}
  cp "${bin_dir}/${result}" "${result_dir}"
  
  cd "${bin_dir}/.."
}


main(){
  run
}

main
