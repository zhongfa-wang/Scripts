#run the executable of libyaml
echo "The results when $1% fences are inserted (nanoseconds):" >> /home/zhongfa/benchmarks/run/results/results-libyaml.txt
cd /home/zhongfa/benchmarks/run/libyaml
ls | parallel -j10 -k 'cd {.} && start=$(date +%s%N) && ./patched small.yaml && end=$(date +%s%N) && nanoseconds=$((end - start)) && seconds=$((nanoseconds)) && echo "$seconds" >> /home/zhongfa/benchmarks/run/results/results-libyaml.txt'
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-libyaml.txt

cd /home/zhongfa/benchmarks/run/libyaml
sudo parallel rm -rf ::: run-{1..10} 