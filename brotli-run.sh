#run the executable of brotli
echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-brotli.log
cd /home/zhongfa/benchmarks/run/bench
# seq 1 10 | parallel -j10 -k "cd ./brotli-{} && start=$(date +%s%N) && sudo ./$2 --decompress enwik9.br -f && end=$(date +%s%N) && nanoseconds=$((end - start)) && seconds=$((nanoseconds)) && echo "$seconds" >> /home/zhongfa/benchmarks/run/results/results-brotli.log"
seq 1 10 | parallel -j10 -k "cd ./brotli-{} && (time ./$2 --decompress enwik9.br -f) 2>> /home/zhongfa/benchmarks/run/results/results-brotli.log"
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-brotli.log
