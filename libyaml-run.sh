#run the executable of libyaml
echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-libyaml.txt
cd /home/zhongfa/benchmarks/run/bench
# seq 1 10 | parallel -j10 -k 'cd ./libyaml-benchmark-{} && start=$(date +%s%N) && ./patched small.yaml && end=$(date +%s%N) && nanoseconds=$((end - start)) && seconds=$((nanoseconds)) && echo "$seconds" >> /home/zhongfa/benchmarks/run/results/results-libyaml.txt'
seq 1 10 | parallel -j10 -k 'cd ./libyaml-benchmark-{} && (time ./patched small.yaml) 2>> /home/zhongfa/benchmarks/run/results/results-libyaml.txt'
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-libyaml.txt

