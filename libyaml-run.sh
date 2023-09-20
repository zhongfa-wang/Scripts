#run the executable of libyaml
echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-libyaml.log
cd /home/zhongfa/benchmarks/run/bench
# seq 1 10 |sudo parallel -j10 -k "cd ./libyaml-benchmark-{} && start=$(date +%s%N) && ./$2 small.yaml && end=$(date +%s%N) && nanoseconds=$((end - start)) && seconds=$((nanoseconds)) && echo "$seconds" >> /home/zhongfa/benchmarks/run/results/results-libyaml.log"
seq 1 10 |sudo parallel -j10 -k "cd ./libyaml-benchmark-{} && (time ./$2 small.yaml) 2>> /home/zhongfa/benchmarks/run/results/results-libyaml.log"
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-libyaml.log

