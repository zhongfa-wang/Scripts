#run the executable of jsmn
echo "The results when $1% fences are inserted (nanoseconds):" >> /home/zhongfa/benchmarks/run/results/results-jsmn.txt
cd /home/zhongfa/benchmarks/run/jsmn
ls | parallel -j10 -k 'cd {.} && start=$(date +%s%N) && ./patched perf.json && end=$(date +%s%N) && nanoseconds=$((end - start)) && seconds=$((nanoseconds)) && echo "$seconds" >> /home/zhongfa/benchmarks/run/results/results-jsmn.txt'
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-jsmn.txt

cd /home/zhongfa/benchmarks/run/jsmn
sudo parallel rm -rf ::: run-{1..10} 