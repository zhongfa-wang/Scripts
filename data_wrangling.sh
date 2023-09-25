#!/bin/bash -xv
declare -rgA key_word=(
  [openssl-rsa]="15360 bits"
  [openssl-dsa]="2048 bits"
  [openssl-ecdsa]="571 bits ecdsa (nistb571)"
)

print_title(){
  local -r bench="${1}"
  local -r patch="${2}"
  local -r percent="${3}"
  local -r result_dir="${4}"
  echo "The results of ${bench}-${patch}-${percent}" >> ${result_dir}/../${bench}
  # echo "The results of ${1}-${2}-${3}" >> ${4}/../${1}
}
data_compose_non_openssl(){
  local -r bench="${1}"
  local -r patch="${2}"
  local -r percent="${3}"
  local -r result_dir="${4}"
  cat time.out.${bench}-${patch}-${percent}-* >> ${result_dir}/../${bench}
  # cat time.out.${1}-${2}-${3}-* >> ${4}/../${1}
}
data_compose_openssl(){
  local -r bench="${1}"
  local -r patch="${2}"
  local -r percent="${3}"
  local -r result_dir="${4}"
  grep "${key_word[${bench}]}" ./time.out.${bench}-${patch}-${percent}-* > grep.tmp.${bench}-${patch}-${percent}
  if [[ ${bench} != "openssl-ecdsa" ]]; then
  awk '{{$0 = $4};print}' "grep.tmp.${bench}-${patch}-${percent}" > awk.tmp.${bench}-${patch}-${percent}
  else
  awk '{{$0 = $6};print}' "grep.tmp.${bench}-${patch}-${percent}" > awk.tmp.${bench}-${patch}-${percent}
  fi
  sed -E 's/([0-9].*)s/\1/' "awk.tmp.${bench}-${patch}-${percent}" >> ${result_dir}/../${bench}
}
data_wrangling(){
  local -rA get_src_dir=(
    [brotli]="brotli"
    [http]="http"
    [jsmn]="jsmn"
    [libhtp]="libhtp-benchmark"
    [libyaml]="libyaml-benchmark"
    [openssl-rsa]="openssl-benchmark"
    [openssl-dsa]="openssl-benchmark"
    [openssl-ecdsa]="openssl-benchmark"
  )
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
  local -r percents_prop=(
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
  local -r percents_ori=(
    -1
  )
  local -r patches=(
    native
    slh
    patched
    percent
  )
  local -r result_dir="${HOME}/benchmarks/results/raw/"
  # local -rA key_word=(
  #   [openssl-rsa]="15360 bits"
  #   [openssl-dsa]="2048 bits"
  #   [openssl-ecdsa]="571 bits ecdsa (nistb571)"
  # )

  cd "${result_dir}"
  for bench in "${benches[@]}"
  do
    for patch in "${patches[@]}"
    do
      if [[ ${patch} == "percent" ]];then
        for percent in "${percents_prop[@]}"
        do
          if [[ ${get_src_dir[${bench}]} == "openssl-benchmark" ]];then
            if [[ ${bench} == "openssl-rsa" || ${bench} == "openssl-dsa" ]];then
              print_title "${bench}" "${patch}" "${percent}" "${result_dir}"
              data_compose_openssl "${bench}" "${patch}" "${percent}" "${result_dir}" 
              rm -f *tmp*
            elif [[ ${bench} == "openssl-ecdsa" ]];then
              print_title "${bench}" "${patch}" "${percent}" "${result_dir}"
              data_compose_openssl "${bench}" "${patch}" "${percent}" "${result_dir}" 
              rm -f *tmp*
            fi
          else
            print_title "${bench}" "${patch}" "${percent}" "${result_dir}"
            data_compose_non_openssl "${bench}" "${patch}" "${percent}" "${result_dir}"
          fi
        done
      elif [[ ${patch} == "native" || ${patch} == "slh" || ${patch} == "patched" ]];then
        for percent in "${percents_ori[@]}"
        do
          if [[ ${get_src_dir[${bench}]} == "openssl-benchmark" ]];then
            if [[ ${bench} == "openssl-rsa" || ${bench} == "openssl-dsa" ]];then
              print_title "${bench}" "${patch}" "${percent}" "${result_dir}"
              data_compose_openssl "${bench}" "${patch}" "${percent}" "${result_dir}" 
              rm -f *tmp*
            elif [[ ${bench} == "openssl-ecdsa" ]];then
              print_title "${bench}" "${patch}" "${percent}" "${result_dir}"
              data_compose_openssl "${bench}" "${patch}" "${percent}" "${result_dir}" 
              rm -f *tmp*
            fi
          else
            print_title "${bench}" "${patch}" "${percent}" "${result_dir}"
            data_compose_non_openssl "${bench}" "${patch}" "${percent}" "${result_dir}"
          fi
        done
      fi
    done
  done
}

main(){
  data_wrangling
}

main