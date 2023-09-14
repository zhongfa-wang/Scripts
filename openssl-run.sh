#run the executable of openssl
# echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-openssl.txt
cd /home/zhongfa/benchmarks/run/bench
# seq 1 10 | parallel -j10 -k "cd ./openssl-benchmark-{} && ./$2 speed rsa dsa ecdsa >&1 | grep -o "real.*" >> /home/zhongfa/benchmarks/run/results/results-openssl.txt"
echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-openssl-rsa.txt
echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-openssl-dsa.txt
echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-openssl-ecdsa.txt
seq 1 10 | parallel -j10 -k "cd ./openssl-benchmark-{} && ./$2 speed rsa > /home/zhongfa/benchmarks/run/results/results-openssl-rsa-{}.txt"
seq 1 10 | parallel -j10 -k "cd ./openssl-benchmark-{} && ./$2 speed dsa > /home/zhongfa/benchmarks/run/results/results-openssl-dsa-{}.txt"
seq 1 10 | parallel -j10 -k "cd ./openssl-benchmark-{} && ./$2 speed ecdsa > /home/zhongfa/benchmarks/run/results/results-openssl-ecdsa-{}.txt"
cat /home/zhongfa/benchmarks/run/results/results-openssl-rsa-*.txt >> /home/zhongfa/benchmarks/run/results/results-openssl-rsa.txt
cat /home/zhongfa/benchmarks/run/results/results-openssl-dsa-*.txt >> /home/zhongfa/benchmarks/run/results/results-openssl-dsa.txt
cat /home/zhongfa/benchmarks/run/results/results-openssl-ecdsa-*.txt >> /home/zhongfa/benchmarks/run/results/results-openssl-ecdsa.txt
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-openssl-rsa.txt
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-openssl-dsa.txt
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-openssl-ecdsa.txt
sudo rm results-openssl-rsa-*.txt 
sudo rm results-openssl-dsa-*.txt 
sudo rm results-openssl-ecdsa-*.txt

