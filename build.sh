#!/bin/bash

build() {
  local -r id="${percent}-${copy}"
  local -r src_dir="${HOME}/benchmarks/src/${bench}"
  local -r bin_dir="${HOME}/benchmarks/bin/${bench}"
  local -r hongg_dir="/usr/local/honggfuzz-589a9fb92/src"
  local -r binary="patched"
  local -r tmp_dir="/tmp/$(id -un)/build"
  local -r work_dir="${tmp_dir}/${bench}.${id}"

  [[ -d ${work_dir} ]] && rm -r "${work_dir}"
  mkdir -p "${work_dir}"
  cp -r "${src_dir}/*" "${work_dir}/"

  cd "${work_dir}"
  make clean HONGG_SRC=${hongg_dir}
  make patched PERF=1 HONGG_SRC=${hongg_dir} FENCE_PERCENTAGE=${percent}

  mkdir -p "${bin_dir}"
  cp ${binary} "${bin_dir}/${binary}.${id}"

  cd ..
  rm -r "${work_dir}"
}

main() {
  build
}

declare -rg bench=${1}
declare -rg percent=${2}
declare -rg copy=${3}

main
