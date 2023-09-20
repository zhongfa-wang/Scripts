#run the executable of libhtp
echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-libhtp.log
cd /home/zhongfa/benchmarks/run/bench
# seq 1 10 |sudo parallel -j10 -k "cd ./libhtp-benchmark-{} && start=$(date +%s%N) && srcdir=./files ./$2 --gtest_filter=Benchmark.ConnectionWithManyTransactions && end=$(date +%s%N) && nanoseconds=$((end - start)) && seconds=$((nanoseconds)) && echo "$seconds" >> /home/zhongfa/benchmarks/run/results/results-libhtp.log"
seq 1 10 |sudo parallel -j10 -k "cd ./libhtp-benchmark-{} && (time srcdir=./libhtp/test/files ./$2 --gtest_filter=Benchmark.ConnectionWithManyTransactions) 2>> /home/zhongfa/benchmarks/run/results/results-libhtp.log"
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-libhtp.log

