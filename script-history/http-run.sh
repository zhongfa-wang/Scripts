#run the executable of http
echo "The results when $1% fences are inserted:" >> /home/zhongfa/benchmarks/run/results/results-http.txt
cd /home/zhongfa/benchmarks/run/http-parser
ls | parallel -j10 -k 'cd {.} && ./patched large.txt >> /home/zhongfa/benchmarks/run/results/results-http.txt'
echo "The results when $1% fences done" >> /home/zhongfa/benchmarks/run/results/results-http.txt

cd /home/zhongfa/benchmarks/run/http-parser
sudo parallel rm -rf ::: run-{1..10} 