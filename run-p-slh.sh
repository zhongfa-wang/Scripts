# # "p" is short for running in parallel
# # # make path
# # for m in brotli http-parser jsmn libhtp-benchmark libyaml-benchmark openssl-benchmark
# # do
# # for n in {1..10}
# # do
# # cd /home/zhongfa/benchmarks/run/bench/
# # mkdir $m-$n
# # cp -r /home/zhongfa/benchmarks/$m/. /home/zhongfa/benchmarks/run/bench/$m-$n
# # done
# # done
  
# # # copy the input files and binary
# # cd /home/zhongfa/benchmarks/run/bin
# # seq 1 10 | sudo parallel -j10 -k 'sudo cp /home/zhongfa/benchmarks/enwik9.br /home/zhongfa/benchmarks/run/bin/brotli-{}/'
# # seq 1 10 | sudo parallel -j10 -k 'sudo cp /home/zhongfa/benchmarks/http-parser/large.txt /home/zhongfa/benchmarks/run/bin/http-parser-{}/'
# # seq 1 10 | sudo parallel -j10 -k 'sudo cp /home/zhongfa/benchmarks/jsmn/perf.json /home/zhongfa/benchmarks/run/bin/jsmn-{}/'
# # seq 1 10 | sudo parallel -j10 -k 'sudo cp -r /home/zhongfa/benchmarks/libhtp-benchmark/libhtp/test/files /home/zhongfa/benchmarks/run/bin/libhtp-benchmark-{}/'
# # seq 1 10 | sudo parallel -j10 -k 'sudo cp /home/zhongfa/benchmarks/libyaml-benchmark/small.yaml /home/zhongfa/benchmarks/run/bin/libyaml-benchmark-{}/'


# start run of x%
for i in 0 1 2 3 4 5 10 20 30 40 50 100
  do
  # Switch the branch of SpecFuzz repo to insertfence
  cd /home/zhongfa/SpecFuzz
  git checkout insertfence --force

  # modify the value in hardening pass
  sed -i "s/if (randomNum <= .*)/if (randomNum <= $i)/" /home/zhongfa/SpecFuzz/install/patches/llvm/X86SpeculativeLoadHardening.cpp
  
  # Compile the pass
  cd /home/zhongfa/SpecFuzz
  sudo make all HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
  sudo make install HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
  sudo make install_tools HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src  

  # build the benchmarks
  cd /home/zhongfa/benchmarks/run/bench
  ls /home/zhongfa/benchmarks/run/bench | sudo parallel -j64 -k 'cd /home/zhongfa/benchmarks/run/bench/{.} && make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src && make patched PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src'
  
  #evaluating
  cd /home/zhongfa/benchmarks/run/scripts
  parallel -j64 sudo bash ::: brotli-run.sh  http-run.sh  jsmn-run.sh  libhtp-run.sh  libyaml-run.sh  openssl-run.sh ::: $i ::: "patched"
  
  # remove the patched binary
  cd /home/zhongfa/benchmarks/run/bench/
  seq 1 10 | sudo parallel -j10 -k 'cd ./brotli-{} && rm patched enwik9'
  seq 1 10 | sudo parallel -j10 -k 'cd ./http-parser-{} && rm patched'
  seq 1 10 | sudo parallel -j10 -k 'cd ./jsmn-{} && rm patched'
  seq 1 10 | sudo parallel -j10 -k 'cd ./libyaml-benchmark-{} && rm patched'
  seq 1 10 | sudo parallel -j10 -k 'cd ./libhtp-benchmark-{} && rm patched'
  seq 1 10 | sudo parallel -j10 -k 'cd ./openssl-benchmark-{} && rm patched'
done

# start run of origin benchmarks
#Compile the pass
cd /home/zhongfa/SpecFuzz
git checkout master --force
sudo make all HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
sudo make install HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
sudo make install_tools HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src  

# build the benchmarks
cd /home/zhongfa/benchmarks/run/bench
ls | sudo parallel -j64 -k 'cd {.} && make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src && make native PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src'
ls | sudo parallel -j64 -k 'cd {.} && make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src && make slh PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src'
ls | sudo parallel -j64 -k 'cd {.} && make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src && make patched PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src'

#evaluating
cd /home/zhongfa/benchmarks/run/scripts
  
for i in native slh patched
do
cd /home/zhongfa/benchmarks/run/scripts
parallel -j64 sudo bash ::: brotli-run.sh  http-run.sh  jsmn-run.sh  libhtp-run.sh  libyaml-run.sh  openssl-run.sh ::: $i ::: $i

#remove the binaries
cd /home/zhongfa/benchmarks/run/bench/
seq 1 10 | sudo parallel -j10 -k "cd ./brotli-{} && rm enwik9"
done

# # Data wrangling
grep "The result\|user" /home/zhongfa/benchmarks/run/results/results-brotli.txt | sed -E 's/([0-9].*)m/\1 /g; s/([0-9].*)s/\1 /g'| awk '/^The result/ || /^user/ {if (/^user/) {$0 = $2 * 60 + $3}; print}' > /home/zhongfa/benchmarks/run/results/simplified-brotli.md
grep "The result\|user" /home/zhongfa/benchmarks/run/results/results-jsmn.txt | sed -E 's/([0-9].*)m/\1 /g; s/([0-9].*)s/\1 /g'| awk '/^The result/ || /^user/ {if (/^user/) {$0 = $2 * 60 + $3}; print}' > /home/zhongfa/benchmarks/run/results/simplified-jsmn.md
grep "The result\|user" /home/zhongfa/benchmarks/run/results/results-http.txt | sed -E 's/([0-9].*)m/\1 /g; s/([0-9].*)s/\1 /g'| awk '/^The result/ || /^user/ {if (/^user/) {$0 = $2 * 60 + $3}; print}' > /home/zhongfa/benchmarks/run/results/simplified-http.md
grep "The result\|user" /home/zhongfa/benchmarks/run/results/results-libhtp.txt | sed -E 's/([0-9].*)m/\1 /g; s/([0-9].*)s/\1 /g'| awk '/^The result/ || /^user/ {if (/^user/) {$0 = $2 * 60 + $3}; print}' > /home/zhongfa/benchmarks/run/results/simplified-libhtp.md
grep "The result\|user" /home/zhongfa/benchmarks/run/results/results-libyaml.txt | sed -E 's/([0-9].*)m/\1 /g; s/([0-9].*)s/\1 /g'| awk '/^The result/ || /^user/ {if (/^user/) {$0 = $2 * 60 + $3}; print}' > /home/zhongfa/benchmarks/run/results/simplified-libyaml.md

# only take the results from "2048 bits"
grep "The result\|2048 bits" /home/zhongfa/benchmarks/run/results/results-openssl-dsa.txt | awk '{if (/^dsa/) {$0 = $4};print}' |sed -E 's/([0-9].*)s/\1/' > simplified-openssl-dsa.md
# only take the results from "571 bits ecdsa (nistb571)" "sign"
grep "The result\|571 bits ecdsa (nistb571) " /home/zhongfa/benchmarks/run/results/results-openssl-ecdsa.txt | awk '{if (/^.*ecdsa/) {$0 = $5};print}' |sed -E 's/([0-9].*)s/\1/' > simplified-openssl-ecdsa.md
# only take the results from "15360 bits" "sign"
grep "The result\|15360 bits" /home/zhongfa/benchmarks/run/results/results-openssl-rsa.txt | awk '{if (/^rsa/) {$0 = $4};print}' |sed -E 's/([0-9].*)s/\1/' > simplified-openssl-rsa.md
