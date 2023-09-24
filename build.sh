#!/bin/bash

declare -rg bench=${1}
declare -rg patch=${2}
declare -rg percent=${3}
declare -rg copy=${4}

build(){
  local -r tmp_dir="/tmp/$(id -un)-sf-build"
  local -r work_dir="${tmp_dir}/${bench}-${patch}-${percent}-${copy}"
  local -r src_dir="${HOME}/benchmarks/${bench}"
  local -r bin_dir="${HOME}/benchmarks/bin/${bench}-${patch}-${percent}-${copy}"
  local -r hongg_dir="/usr/local/honggfuzz-589a9fb92/src"
  local -r makefile="common.mk"
  local -r mf_dir="${HOME}/benchmarks"

  if [[ ${patch} == "percent" ]]; then
    local -r binary="proportion"
  elif [[ ${patch} == "native" ]]; then
    local -r binary="native"
  elif [[ ${patch} == "slh" ]]; then
    local -r binary="slh"
  elif [[ ${patch} == "patched" ]]; then
    local -r binary="patched"
  else
    echo "Wrong building flag!" 1>&2
    exit 1
  fi
  
  local -r input_file_dir="${src_dir}"
  if [[ ${bench} == "brotli" ]]; then
    local -r input_file="enwik9.br"
    local -r input_file_dir="${HOME}/benchmarks/resources"
  elif [[ ${bench} == "http-parser" ]]; then
    local -r input_file="large.txt"
  elif [[ ${bench} == "jsmn" ]]; then
    local -r input_file="perf.json"
  elif [[ ${bench} == "libhtp-benchmark" ]]; then
    local -r input_file="libhtp/test/files/."
  elif [[ ${bench} == "libyaml-benchmark" ]]; then
    local -r input_file="small.yaml"
  fi

  [[ -d ${work_dir} ]] && rm -r "${work_dir}"
  mkdir -p "${work_dir}"
  cp -r "${src_dir}/." "${work_dir}/"
  cp -r "${mf_dir}/common.mk" "${tmp_dir}/"


  cd "${work_dir}"
  set -x
  sed -i -e "s@${src_dir}/@${work_dir}/@g" "${work_dir}/whitelist.txt"
  make clean
  make ${binary} PROP=${percent} PERF=1 HONGG_SRC=${hongg_dir}

  mkdir -p "${bin_dir}"
  mv "${work_dir}/${binary}" "${bin_dir}/"
  if [[ ${bench} != "openssl-benchmark" ]]; then
  cp -r "${input_file_dir}/${input_file}" "${bin_dir}"
  fi

  cd "${work_dir}/.."
  rm -rf "${work_dir}"
}

main(){
  build
}

main