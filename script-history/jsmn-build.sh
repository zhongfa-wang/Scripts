#make the executable of jsmn
cd /home/zhongfa/benchmarks/run/jsmn
parallel mkdir ::: run-{1..10}
for j in {1..10}
do
cd /home/zhongfa/benchmarks/jsmn
sudo rm patched
make clean PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
make patched PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
mv ./patched /home/zhongfa/benchmarks/run/jsmn/run-$j/
cp ./perf.json /home/zhongfa/benchmarks/run/jsmn/run-$j/

done