#make the executable of libyaml
cd /home/zhongfa/benchmarks/run/libyaml
parallel mkdir ::: run-{1..10}
parallel cp /home/zhongfa/benchmarks/libyaml-benchmark/small.yaml /home/zhongfa/benchmarks/run/libyaml/run-{.} ::: {1..10}
for j in {1..10}
do
cd /home/zhongfa/benchmarks/libyaml-benchmark
sudo rm patched
make clean PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
make patched PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
mv ./patched /home/zhongfa/benchmarks/run/libyaml/run-$j/
done