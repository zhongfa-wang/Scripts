#!/bin/bash

get_cmd() {
  local -rA assignments=(
    [libhtp]="srcdir=./libhtp/test/files"
  )

  local -rA args=(
    [brotli]="--decompress enwik9.br -f"
    [http]="large.txt"
    [jsmn]="per.json"
    [libhtp]="--gtest_filter=Benchmark.ConnectionWithManyTransactions"
    [libyaml]="small.yaml"
    [openssl_rsa]="speed rsa"
    [openssl_dsa]="speed dsa"
    [openssl_ecdsa]="speed ecdsa"
  )

  [[ -v "assignments[${bench}]" ]] && local -r assignment=${assignments[${bench}]} || local -r assignment=""
  cmd="${assignment} ${binary} ${args[${bench}]}"

  echo "${cmd}"
}

get_src_dir() {
  local -rA dirs=(
    [brotli]="brotli"
    [http]="http-parser"
    [jsmn]="jsmn"
    [libhtp]="libhtp-benchmark"
    [libyaml]="libyaml-benchmark"
    [openssl_rsa]="openssl-benchmark"
    [openssl_dsa]="openssl-benchmark"
    [openssl_ecdsa]="openssl-benchmark"
  )

  echo ${dirs[${bench}]}
}

run() {
  local -r id="${percent}-${copy}"
  local -r src_dir="${HOME}/benchmarks/src/${bench}"
  local -r bin_dir="${HOME}/benchmarks/bin/$(get_src_dir)"
  local -r result_dir="${HOME}/benchmarks/result/${bench}"
  local -r result="time.out.${bench}.${id}"
  local -r cmd="$(get_cmd)"
  local -r tmp_dir="/tmp/$(id -un)/run"
  local -r work_dir="${tmp_dir}/${bench}.${id}"

  [[ -d ${work_dir} ]] && rm -r "${work_dir}"
  mkdir -p "${work_dir}"
  cp "${bin_dir}/${binary}.${id}" "${work_dir}/${binary}"
  cp "${src_dir}/*" "${work_dir}/"

  cd "${work_dir}"
  if command -v /usr/bin/time > /dev/null; then
    /usr/bin/time -f %U -o ${result} ${cmd}
  else
    export TIMEFORMAT=%U
    # cf. http://mywiki.wooledge.org/BashFAQ/032
    { time ${cmd} > /dev/null 2>&1; } 2> ${result}
  fi

  mkdir -p "${result_dir}"
  cp ${result} "${result_dir}/"

  cd ..
  rm -r "${work_dir}"
}

main() {
  run
}

declare -rg bench=${1}
declare -rg percent=${2}
declare -rg copy=${3}
declare -rg binary="patched"

main
