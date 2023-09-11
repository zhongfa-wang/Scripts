#run the executable of brotli
echo "The results when $1% fences are inserted (nanoseconds):" >> /home/zhongfa/benchmarks/run/results/results-brotli.txt
cd /home/zhongfa/benchmarks/run/brotli
ls | parallel -j10 -k 'cd {.} && start=$(date +%s%N) && sudo ./patched --decompress enwik9.br -f && end=$(date +%s%N) && nanoseconds=$((end - start)) && seconds=$((nanoseconds)) && echo "$seconds" >> /home/zhongfa/benchmarks/run/results/results-brotli.txt'
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-brotli.txt

cd /home/zhongfa/benchmarks/run/brotli
sudo parallel rm -rf ::: run-{1..10} 