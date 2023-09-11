#run the executable of http2>&1 | grep -E -o 'real.*|user.*|sys.*' 
echo "The results when $1% fences are inserted: " >> /home/zhongfa/benchmarks/run/results/results-http.txt
cd /home/zhongfa/benchmarks/run/bench
# seq 1 10 | parallel -j10 -k 'cd ./http-parser-{} && ./patched large.txt >> /home/zhongfa/benchmarks/run/results/results-http.txt'
seq 1 10 | parallel -j10 -k 'cd ./http-parser-{} && (time ./patched large.txt) 2>> /home/zhongfa/benchmarks/run/results/results-http.txt'
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-http.txt

