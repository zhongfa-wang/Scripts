#make the executable of openssl
cd /home/zhongfa/benchmarks/run/openssl
parallel mkdir ::: run-{1..10}
for j in {1..10}
do
cd /home/zhongfa/benchmarks/openssl-benchmark
sudo rm patched
make clean PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
sudo make patched PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
mv ./patched /home/zhongfa/benchmarks/run/openssl/run-$j/
done