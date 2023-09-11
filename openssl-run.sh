#run the executable of openssl
# echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-openssl.txt
cd /home/zhongfa/benchmarks/run/bench
# seq 1 10 | parallel -j10 -k 'cd ./openssl-benchmark-{} &&(time ./patched speed -multi 4 rsa dsa ecdsa) 2>&1 | grep -o 'real.*' >> /home/zhongfa/benchmarks/run/results/results-openssl.txt'
echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-openssl-rsa.txt
echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-openssl-dsa.txt
echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-openssl-ecdsa.txt
seq 1 10 | parallel -j10 -k 'cd ./openssl-benchmark-{} && (time ./patched speed -multi 4 rsa) 2>> /home/zhongfa/benchmarks/run/results/results-openssl-rsa.txt'
seq 1 10 | parallel -j10 -k 'cd ./openssl-benchmark-{} && (time ./patched speed -multi 4 dsa)  2>> /home/zhongfa/benchmarks/run/results/results-openssl-dsa.txt'
seq 1 10 | parallel -j10 -k 'cd ./openssl-benchmark-{} && (time ./patched speed -multi 4 ecdsa)  2>> /home/zhongfa/benchmarks/run/results/results-openssl-ecdsa.txt'
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-openssl-rsa.txt
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-openssl-dsa.txt
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-openssl-ecdsa.txt

