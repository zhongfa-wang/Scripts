#make the executable of libhtp
cd /home/zhongfa/benchmarks/run/libhtp
parallel mkdir ::: run-{1..10}
parallel cp -r /home/zhongfa/benchmarks/libhtp-benchmark/libhtp/test/files /home/zhongfa/benchmarks/run/libhtp/run-{.} ::: {1..10}
for j in {1..10}
do
cd /home/zhongfa/benchmarks/libhtp-benchmark
sudo rm patched
make clean PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
make patched PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
mv ./patched /home/zhongfa/benchmarks/run/libhtp/run-$j/
done