for i in 0 1 2 3 4 5 10 20 30 40 50 100
  do
  #modify the value in hardening pass
  cd /home/zhongfa/SpecFuzz/install/patches/llvm
  sed -i "s/if (randomNum <= .*)/if (randomNum <= $i)/" /home/zhongfa/SpecFuzz/install/patches/llvm/X86SpeculativeLoadHardening.cpp
  #Compile the pass
  cd /home/zhongfa/SpecFuzz
  sudo make all HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
  sudo make install HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src
  sudo make install_tools HONGG_SRC=/usr/local/honggfuzz-589a9fb92/src  

  cd /home/zhongfa/benchmarks/run/scripts
  #make the executable
  parallel sudo bash ::: brotli-build.sh  http-build.sh  jsmn-build.sh  libhtp-build.sh  libyaml-build.sh  openssl-build.sh
  #evaluating
  parallel sudo bash ::: brotli-run.sh  http-run.sh  jsmn-run.sh  libhtp-run.sh  libyaml-run.sh  openssl-run.sh ::: $i
done
grep "The results\|8192.00 mb" /home/zhongfa/benchmarks/run/results/results-http.txt | \
awk '/The results/ { print } /8192.00 mb/ { print $10 }' \
    > /home/zhongfa/benchmarks/run/results/simplified-http.txt
sed -E 's/([0-9]{2})$/.\1/' /home/zhongfa/benchmarks/run/results/results-jsmn.txt \
    > /home/zhongfa/benchmarks/run/results/simplified-jsmn.txt
sed -E 's/([0-9]{2})$/.\1/' /home/zhongfa/benchmarks/run/results/results-brotli.txt \
    > /home/zhongfa/benchmarks/run/results/simplified-brotli.txt
sed -E 's/([0-9]{2})$/.\1/' /home/zhongfa/benchmarks/run/results/results-libhtp.txt \
    > /home/zhongfa/benchmarks/run/results/simplified-libhtp.txt
sed -E 's/([0-9]{2})$/.\1/' /home/zhongfa/benchmarks/run/results/results-libyaml.txt \
    > /home/zhongfa/benchmarks/run/results/simplified-libyaml.txt
sed -E 's/([0-9]{2})$/.\1/' /home/zhongfa/benchmarks/run/results/results-openssl.txt \
    > /home/zhongfa/benchmarks/run/results/simplified-openssl.txt

#sudo bash run.sh parallel --jobs 3