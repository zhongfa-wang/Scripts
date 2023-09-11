# for m in brotli http-parser jsmn libhtp-benchmark libyaml-benchmark openssl-benchmark
# do
# for n in {1..10}
# do
# cd /home/zhongfa/benchmarks/run/bench/$m-$n
# sed -i 's/include \.\.\/common.mk/include ..\/..\/common.mk/' Makefile

# done
# done

# # brotli
# for n in native slh patched
# do
# cd /home/zhongfa/benchmarks/run/bin-origin/brotli/$n/
# echo "The result of brotli-$n" >> /home/zhongfa/benchmarks/run/results/results-origin.txt
# (time ./$n --decompress enwik9.br -f) 2>&1 | grep -o 'real.*' >> /home/zhongfa/benchmarks/run/results/results-origin.txt
# sudo rm enwik9
# done

# # http-parser 
# for n in native slh patched
# do
# cd /home/zhongfa/benchmarks/run/bin-origin/http-parser/$n/
# echo "The result of http-parser-$n" >> /home/zhongfa/benchmarks/run/results/results-origin.txt
# (time ./$n large.txt) 2>&1 | grep -o 'real.*' >> /home/zhongfa/benchmarks/run/results/results-origin.txt
# done

# # jsmn
# for n in native slh patched
# do
# cd /home/zhongfa/benchmarks/run/bin-origin/jsmn/$n/
# echo "The result of jsmn-$n" >> /home/zhongfa/benchmarks/run/results/results-origin.txt
# (time ./$n perf.json) 2>&1 | grep -o 'real.*' >> /home/zhongfa/benchmarks/run/results/results-origin.txt
# done

# # libhtp-benchmark
# for n in native slh patched
# do
# cd /home/zhongfa/benchmarks/run/bin-origin/libhtp-benchmark/$n/
# echo "The result of libhtp-benchmark-$n" >> /home/zhongfa/benchmarks/run/results/results-origin.txt
# (time srcdir=./files ./$n --gtest_filter=Benchmark.ConnectionWithManyTransactions) 2>&1 | grep -o 'real.*' >> /home/zhongfa/benchmarks/run/results/results-origin.txt
# done

# # libyaml-benchmark openssl-benchmark
# for n in native slh patched
# do
# cd /home/zhongfa/benchmarks/run/bin-origin/libyaml-benchmark/$n/
# echo "The result of libyaml-benchmark-$n" >> /home/zhongfa/benchmarks/run/results/results-origin.txt
# (time ./$n small.yaml) 2>&1 | grep -o 'real.*' >> /home/zhongfa/benchmarks/run/results/results-origin.txt
# done

# # openssl-benchmark
# for n in native slh patched
# do
# for p in rsa dsa ecdsa
# do
# cd /home/zhongfa/benchmarks/run/bin-origin/openssl-benchmark/$n/
# echo "The result of openssl-benchmark-$n-$p" >> /home/zhongfa/benchmarks/run/results/results-origin.txt
# (time ./$n speed -multi 4 $p) 2>&1 | grep -o 'real.*' >> /home/zhongfa/benchmarks/run/results/results-origin.txt
# done
# done

# # openssl-benchmark
# for n in native slh patched
# do
# cd /home/zhongfa/benchmarks/run/bin-origin/openssl-benchmark/$n/
# echo "The result of openssl-benchmark-$n-all" >> /home/zhongfa/benchmarks/run/results/results-origin.txt
# (time ./$n speed -multi 4 rsa dsa ecdsa) 2>&1 | grep -o 'real.*' >> /home/zhongfa/benchmarks/run/results/results-origin.txt
# done

cd /home/zhongfa/benchmarks/run/results
sed -E 's/^.*?([0-9].*)m([0-9].*)s/\1 \2/' /home/zhongfa/benchmarks/run/results/results-origin.txt \
 | awk '/^The result/ || /^[0-9]/ {if (/^[0-9]/) {$0 = $1 * 60 + $2}; print}' > simplified-origin.txt