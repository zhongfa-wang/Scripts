# # make path
# for m in brotli http-parser jsmn libhtp-benchmark libyaml-benchmark openssl-benchmark
# do
# for n in {1..10}
# do
# cd /home/zhongfa/benchmarks/run/bench/
# mkdir $m-$n
# cp -r /home/zhongfa/benchmarks/$m/. /home/zhongfa/benchmarks/run/bench/$m-$n
# done
# done
  
# # copy the input files and binary
# cd /home/zhongfa/benchmarks/run/bin
# seq 1 10 | parallel -j10 -k 'sudo cp /home/zhongfa/benchmarks/enwik9.br /home/zhongfa/benchmarks/run/bin/brotli-{}/'
# seq 1 10 | parallel -j10 -k 'sudo cp /home/zhongfa/benchmarks/http-parser/large.txt /home/zhongfa/benchmarks/run/bin/http-parser-{}/'
# seq 1 10 | parallel -j10 -k 'sudo cp /home/zhongfa/benchmarks/jsmn/perf.json /home/zhongfa/benchmarks/run/bin/jsmn-{}/'
# seq 1 10 | parallel -j10 -k 'sudo cp -r /home/zhongfa/benchmarks/libhtp-benchmark/libhtp/test/files /home/zhongfa/benchmarks/run/bin/libhtp-benchmark-{}/'
# seq 1 10 | parallel -j10 -k 'sudo cp /home/zhongfa/benchmarks/libyaml-benchmark/small.yaml /home/zhongfa/benchmarks/run/bin/libyaml-benchmark-{}/'

for i in 0 1 2 3 4 5 10 20 30 40 50 100
  do
  #modify the value in hardening pass
  cd /home/zhongfa/SpecFuzz/install/patches/llvm
  sed -i "s/if (randomNum <= .*)/if (randomNum <= $i)/" /home/zhongfa/SpecFuzz/install/patches/llvm/X86SpeculativeLoadHardening.cpp
  #Compile the pass
  cd /home/zhongfa/SpecFuzz
  sudo make all HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
  sudo make install HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
  sudo make install_tools HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src  

  # build the benchmarks
  cd /home/zhongfa/benchmarks/run/bench
  ls | parallel -j64 -k 'cd {.} && sudo make clean PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src && sudo make patched PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src'
  # # move the binary from the benchmark path to the bin path
  # for m in brotli http-parser jsmn libhtp-benchmark libyaml-benchmark openssl-benchmark
  # do
  # for n in {1..10}
  # do
  # mv /home/zhongfa/benchmarks/run/bench/$m-$n/patched /home/zhongfa/benchmarks/run/bin/$m-$n/
  # done
  # done
  

  #evaluating
  cd /home/zhongfa/benchmarks/run/scripts
  parallel -j64 sudo bash ::: brotli-run.sh  http-run.sh  jsmn-run.sh  libhtp-run.sh  libyaml-run.sh  openssl-run.sh ::: $i

  #remove the patched binary
  cd /home/zhongfa/benchmarks/run/bench/
  seq 1 10 | parallel -j10 -k 'cd ./brotli-{} && sudo rm patched enwik9'
  seq 1 10 | parallel -j10 -k 'cd ./http-parser-{} && sudo rm patched'
  seq 1 10 | parallel -j10 -k 'cd ./jsmn-{} && sudo rm patched'
  seq 1 10 | parallel -j10 -k 'cd ./libyaml-benchmark-{} && sudo rm patched'
  seq 1 10 | parallel -j10 -k 'cd ./libhtp-benchmark-{} && sudo rm patched'
  seq 1 10 | parallel -j10 -k 'cd ./openssl-benchmark-{} && sudo rm patched'
done
# grep "The results\|8192.00 mb" /home/zhongfa/benchmarks/run/results/results-http.txt | \
# awk '/The results/ { print } /8192.00 mb/ { print $10 }' \
#     > /home/zhongfa/benchmarks/run/results/simplified-http.txt
# sed -E 's/([0-9]{9})$/.\1/' /home/zhongfa/benchmarks/run/results/results-jsmn.txt \
#     > /home/zhongfa/benchmarks/run/results/simplified-jsmn.txt
# sed -E 's/([0-9]{9})$/.\1/' /home/zhongfa/benchmarks/run/results/results-brotli.txt \
#     > /home/zhongfa/benchmarks/run/results/simplified-brotli.txt
# sed -E 's/([0-9]{9})$/.\1/' /home/zhongfa/benchmarks/run/results/results-libhtp.txt \
#     > /home/zhongfa/benchmarks/run/results/simplified-libhtp.txt
# sed -E 's/([0-9]{6})$/.\1/' /home/zhongfa/benchmarks/run/results/results-libyaml.txt \
#     > /home/zhongfa/benchmarks/run/results/simplified-libyaml.txt
# sed -E 's/^.*([0-9]{2})m([0-9].*)s/\1 \2/' /home/zhongfa/benchmarks/run/results/results-openssl.txt \
#  | awk '/^The results/ || /^[0-9]/ {if (/^[0-9]/) {$0 = $1 * 60 + $2}; print}' > simplified-openssl.txt

# sed -E 's/^.*?([0-9].*)m([0-9].*)s/\1 \2/' /home/zhongfa/benchmarks/run/results/results-origin.txt \
#  | awk '/^The result/ || /^[0-9]/ {if (/^[0-9]/) {$0 = $1 * 60 + $2}; print}' > /home/zhongfa/benchmarks/run/results/simplified-origin.txt