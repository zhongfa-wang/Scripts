#make the executable of http
cd /home/zhongfa/benchmarks/run/http-parser
parallel mkdir ::: run-{1..10}
for j in {1..10}
do
cd /home/zhongfa/benchmarks/http-parser
sudo rm patched
make clean PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
make patched PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
mv ./patched /home/zhongfa/benchmarks/run/http-parser/run-$j/
cp ./large.txt /home/zhongfa/benchmarks/run/http-parser/run-$j/

done