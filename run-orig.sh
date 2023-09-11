# building
for m in brotli http-parser jsmn libhtp-benchmark libyaml-benchmark openssl-benchmark
do
cd /home/zhongfa/benchmarks/$m
sudo rm native slh patched
sudo make clean PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
for n in native slh patched
do
sudo make $n PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
sudo make clean PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
done
done


# runing
# brotli
for m in native slh patched
do
echo "The result of brotli-$m is: " >> /home/zhongfa/benchmarks/run/results/results-origin.txt
cd /home/zhongfa/benchmarks/brotli/$m
(time ./$m --decompress enwik9.br -f) 2>&1 | grep -E -o 'real.*|user.*|sys.*' >> /home/zhongfa/benchmarks/run/results/results-origin.txt
sudo rm enwik9
done

# http-parser
for m in native slh patched
do
echo "The result of http-parser-$m is: " >> /home/zhongfa/benchmarks/run/results/results-origin.txt
cd /home/zhongfa/benchmarks/http-parser/$m
(time ./$m large.txt) 2>&1 | grep -E -o 'real.*|user.*|sys.*' >> /home/zhongfa/benchmarks/run/results/results-origin.txt
done

# jsmn
for m in native slh patched
do
echo "The result of jsmn-$m is: " >> /home/zhongfa/benchmarks/run/results/results-origin.txt
cd /home/zhongfa/benchmarks/jsmn/$m
(time ./$m perf.json) 2>&1 | grep -E -o 'real.*|user.*|sys.*' >> /home/zhongfa/benchmarks/run/results/results-origin.txt
done

# libhtp-benchmark
for m in native slh patched
do
echo "The result of libhtp-benchmark-$m is: " >> /home/zhongfa/benchmarks/run/results/results-origin.txt
cd /home/zhongfa/benchmarks/libhtp-benchmark/$m
(time srcdir=./files ./$m --gtest_filter=Benchmark.ConnectionWithManyTransactions ) 2>&1 | grep -E -o 'real.*|user.*|sys.*' >> /home/zhongfa/benchmarks/run/results/results-origin.txt
done

# libyaml-benchmark
for m in native slh patched
do
echo "The result of libyaml-benchmark-$m is: " >> /home/zhongfa/benchmarks/run/results/results-origin.txt
cd /home/zhongfa/benchmarks/libyaml-benchmark/$m
(time ./$m small.yaml ) 2>&1 | grep -E -o 'real.*|user.*|sys.*' >> /home/zhongfa/benchmarks/run/results/results-origin.txt
done

# openssl-benchmark
for m in native slh patched
do
cd /home/zhongfa/benchmarks/openssl-benchmark/$m
for n in rsa dsa ecdsa
do
echo "The result of openssl-benchmark-$m-$n is: " >> /home/zhongfa/benchmarks/run/results/results-origin.txt
(time ./$m speed -multi 4 $n) 2>&1 | grep -E -o 'real.*|user.*|sys.*' >> /home/zhongfa/benchmarks/run/results/results-origin.txt
done
done

