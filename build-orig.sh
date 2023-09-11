# # make directory
# for i in brotli http-parser jsmn libhtp-benchmark libyaml-benchmark openssl-benchmark
# do
# cd /home/zhongfa/benchmarks/$i
# # rm patched native slh
# # parallel make ::: patched native slh ::: PERF=1
#     cd /home/zhongfa/benchmarks/run/bin
#     mkdir $i
#     cd ./$i
#     for j in patched native slh
#     do
#     mkdir $j
#     cp /home/zhongfa/benchmarks/$i/$j /home/zhongfa/benchmarks/run/bin-origin/$i/$j/
#     done
# done 

# # build binaries: native slh patched
# cd /home/zhongfa/benchmarks/brotli
# sudo rm native slh patched
# sudo make patched PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make slh PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make native PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src

# cd /home/zhongfa/benchmarks/http-parser
# sudo rm native slh patched
# sudo make patched PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make slh PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make native PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src

# cd /home/zhongfa/benchmarks/jsmn
# sudo rm native slh patched
# sudo make patched PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make slh PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make native PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src

# cd /home/zhongfa/benchmarks/libhtp-benchmark
# sudo rm native slh patched
# sudo make patched PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make slh PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make native PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src

# cd /home/zhongfa/benchmarks/libyaml-benchmark
# sudo rm native slh patched
# sudo make patched PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make slh PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make native PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src

# cd /home/zhongfa/benchmarks/openssl-benchmark
# sudo rm native slh patched
# sudo make patched PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make slh PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make native PERF=1 HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
# sudo make clean HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src

# # rm the old binaries
# for i in brotli http-parser jsmn libhtp-benchmark libyaml-benchmark openssl-benchmark
# do
#     for j in patched native slh
#     do
#     cd /home/zhongfa/benchmarks/run/bin-origin/$i/$j
#     sudo rm ./$j
#     done 
# done

# copy the binaries
for i in brotli http-parser jsmn libhtp-benchmark libyaml-benchmark openssl-benchmark
do

    for j in patched native slh
    do
    cp /home/zhongfa/benchmarks/$i/$j /home/zhongfa/benchmarks/run/bin-origin/$i/$j/
    done
done 