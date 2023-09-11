#run the executable of openssl
echo "The results when $1% fences are inserted (seconds):" >> /home/zhongfa/benchmarks/run/results/results-openssl.txt
cd /home/zhongfa/benchmarks/run/openssl
# ls | parallel -j10 -k 'cd {.} && start=$(date +%s%N) && ./patched large.yaml && end=$(date +%s%N) && nanoseconds=$((end - start)) && seconds=$((nanoseconds / 1000000000)) && echo "$seconds" >> /home/zhongfa/benchmarks/run/results/results-openssl.txt'
ls | parallel -j10 -k 'cd {.} && (time ./patched speed -multi 4 rsa dsa ecdsa) 2>&1 | grep -o 'real.*' >> /home/zhongfa/benchmarks/run/results/results-openssl.txt'
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-openssl.txt

cd /home/zhongfa/benchmarks/run/openssl
sudo parallel rm -rf ::: run-{1..10} 