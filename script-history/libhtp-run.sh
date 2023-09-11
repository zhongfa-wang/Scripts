#run the executable of libhtp
echo "The results when $1% fences are inserted (nanoseconds):" >> /home/zhongfa/benchmarks/run/results/results-libhtp.txt
cd /home/zhongfa/benchmarks/run/libhtp
ls | parallel -j10 -k 'cd {.} && start=$(date +%s%N) && srcdir=./files ./patched --gtest_filter=Benchmark.ConnectionWithManyTransactions && end=$(date +%s%N) && nanoseconds=$((end - start)) && seconds=$((nanoseconds)) && echo "$seconds" >> /home/zhongfa/benchmarks/run/results/results-libhtp.txt'
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-libhtp.txt

cd /home/zhongfa/benchmarks/run/libhtp
sudo parallel rm -rf ::: run-{1..10} 