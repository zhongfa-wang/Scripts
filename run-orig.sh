# # build llvm
# cd /home/zhongfa/SpecFuzz
# git checkout --force master
# sudo make all HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make install HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make install_tools HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src  

# # build benchmark binaries brotli http-parser jsmn
# for m in brotli http-parser jsmn
# do
# cd /home/zhongfa/benchmarks/$m
# rm native slh patched
# make clean PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# for n in native slh patched
# do
# make $n PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# make clean PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# done
# done

# # build benchmark binaries: libhtp-benchmark libyaml-benchmark openssl-benchmark
# for m in libhtp-benchmark libyaml-benchmark openssl-benchmark
# do
# cd /home/zhongfa/benchmarks/$m
# sudo rm native slh patched
# sudo make clean PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# for n in native slh patched
# do
# sudo make $n PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# done
# done

# # undone: build benchmark binaries brotli http-parser jsmn
# ls /home/zhongfa/benchmarks | grep -E 'brotli|http-parser|jsmn'| parallel -k 'cd {} && sudo rm patched slh native && make clean && make native PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src && make clean && make slh PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src && make clean && make patched PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src'

# # undone: build benchmark binaries libhtp-benchmark libyaml-benchmark openssl-benchmark
# ls /home/zhongfa/benchmarks | grep -E 'lib|ssl'| parallel -k 'cd {} && sudo rm patched slh native && make clean && sudo make native PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src && make clean && sudo make slh PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src && make clean && sudo make patched PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src'


# # runing
# # brotli
# for m in native slh patched
# do
# echo "The result of brotli-$m is: " >> /home/zhongfa/benchmarks/run/results/results-origin.log
# cd /home/zhongfa/benchmarks/brotli
# (time ./$m --decompress enwik9.br -f) 2>&1 | grep -E -o 'real.*|user.*|sys.*' >> /home/zhongfa/benchmarks/run/results/results-origin.log
# sudo rm enwik9
# done

# # http-parser
# for m in native slh patched
# do
# echo "The result of http-parser-$m is: " >> /home/zhongfa/benchmarks/run/results/results-origin.log
# cd /home/zhongfa/benchmarks/http-parser
# (time ./$m large.txt) 2>&1 | grep -E -o 'real.*|user.*|sys.*' >> /home/zhongfa/benchmarks/run/results/results-origin.log
# done

# # jsmn
# for m in native slh patched
# do
# echo "The result of jsmn-$m is: " >> /home/zhongfa/benchmarks/run/results/results-origin.log
# cd /home/zhongfa/benchmarks/jsmn
# (time ./$m perf.json) 2>&1 | grep -E -o 'real.*|user.*|sys.*' >> /home/zhongfa/benchmarks/run/results/results-origin.log
# done

# # libhtp-benchmark
# for m in native slh patched
# do
# echo "The result of libhtp-benchmark-$m is: " >> /home/zhongfa/benchmarks/run/results/results-origin.log
# cd /home/zhongfa/benchmarks/libhtp-benchmark
# (time srcdir=./files ./$m --gtest_filter=Benchmark.ConnectionWithManyTransactions ) 2>&1 | grep -E -o 'real.*|user.*|sys.*' >> /home/zhongfa/benchmarks/run/results/results-origin.log
# done

# # libyaml-benchmark
# for m in native slh patched
# do
# echo "The result of libyaml-benchmark-$m is: " >> /home/zhongfa/benchmarks/run/results/results-origin.log
# cd /home/zhongfa/benchmarks/libyaml-benchmark
# (time ./$m small.yaml ) 2>&1 | grep -E -o 'real.*|user.*|sys.*' >> /home/zhongfa/benchmarks/run/results/results-origin.log
# done

# openssl-benchmark
for m in native slh patched
do
cd /home/zhongfa/benchmarks/openssl-benchmark
for n in rsa dsa ecdsa
do
echo "The result of openssl-benchmark-$m-$n is: " >> /home/zhongfa/benchmarks/run/results/results-origin.log
(time ./$m speed -multi 4 $n) 2>&1 | grep -E -o 'real.*|user.*|sys.*' >> /home/zhongfa/benchmarks/run/results/results-origin.log
done
done

