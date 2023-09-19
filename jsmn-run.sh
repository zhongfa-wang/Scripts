#run the executable of jsmn
echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-jsmn.log
cd /home/zhongfa/benchmarks/run/bench
# seq 1 10 | parallel -j10 -k "cd ./jsmn-{} && start=$(date +%s%N) && ./$2 perf.json && end=$(date +%s%N) && nanoseconds=$((end - start)) && seconds=$((nanoseconds)) && echo "$seconds" >> /home/zhongfa/benchmarks/run/results/results-jsmn.log"
seq 1 10 | parallel -j10 -k "cd ./jsmn-{} && (time ./$2 perf.json) 2>> /home/zhongfa/benchmarks/run/results/results-jsmn.log"
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-jsmn.log

