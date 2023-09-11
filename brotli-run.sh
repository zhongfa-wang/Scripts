#run the executable of brotli
echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-brotli.txt
cd /home/zhongfa/benchmarks/run/bench
# seq 1 10 | parallel -j10 -k 'cd ./brotli-{} && start=$(date +%s%N) && sudo ./patched --decompress enwik9.br -f && end=$(date +%s%N) && nanoseconds=$((end - start)) && seconds=$((nanoseconds)) && echo "$seconds" >> /home/zhongfa/benchmarks/run/results/results-brotli.txt'
seq 1 10 | parallel -j10 -k 'cd ./brotli-{} && (time ./patched --decompress enwik9.br -f) 2>> /home/zhongfa/benchmarks/run/results/results-brotli.txt'
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-brotli.txt
