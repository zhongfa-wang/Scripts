#make the executable of brotli
cd /home/zhongfa/benchmarks/run/brotli
parallel mkdir ::: run-{1..10}
for j in {1..10}
do
cd /home/zhongfa/benchmarks/brotli
sudo rm patched
make clean PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
make patched PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
mv ./patched /home/zhongfa/benchmarks/run/brotli/run-$j/
cp /home/zhongfa/benchmarks/enwik9.br /home/zhongfa/benchmarks/run/brotli/run-$j/

done