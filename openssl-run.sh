#run the executable of openssl
# echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-openssl.log
cd /home/zhongfa/benchmarks/run/bench
# seq 1 10 | parallel -j10 -k "cd ./openssl-benchmark-{} && ./$2 speed rsa dsa ecdsa >&1 | grep -o "real.*" >> /home/zhongfa/benchmarks/run/results/results-openssl.log"
echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-openssl-rsa.log
echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-openssl-dsa.log
echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-openssl-ecdsa.log
seq 1 10 | parallel -j10 -k "cd ./openssl-benchmark-{} && ./$2 speed rsa > /home/zhongfa/benchmarks/run/results/results-openssl-rsa-{}.log"
seq 1 10 | parallel -j10 -k "cd ./openssl-benchmark-{} && ./$2 speed dsa > /home/zhongfa/benchmarks/run/results/results-openssl-dsa-{}.log"
seq 1 10 | parallel -j10 -k "cd ./openssl-benchmark-{} && ./$2 speed ecdsa > /home/zhongfa/benchmarks/run/results/results-openssl-ecdsa-{}.log"
cat /home/zhongfa/benchmarks/run/results/results-openssl-rsa-*.log >> /home/zhongfa/benchmarks/run/results/results-openssl-rsa.log
cat /home/zhongfa/benchmarks/run/results/results-openssl-dsa-*.log >> /home/zhongfa/benchmarks/run/results/results-openssl-dsa.log
cat /home/zhongfa/benchmarks/run/results/results-openssl-ecdsa-*.log >> /home/zhongfa/benchmarks/run/results/results-openssl-ecdsa.log
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-openssl-rsa.log
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-openssl-dsa.log
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-openssl-ecdsa.log

