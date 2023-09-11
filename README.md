This is the repo containing the shell scripts used for running the benchmarks of [SpecFuzz](https://github.com/OleksiiOleksenko/SpecFuzz). 
This script mainly changes the percentage of fences inserted by the `hardenEdgesWithLFENCE` function in the [X86SpeculativeLoadHardening](https://github.com/OleksiiOleksenko/SpecFuzz/blob/master/install/patches/llvm/X86SpeculativeLoadHardening.cpp) pass. This script contains three parts: building LLVM, building benchmarks, and running benchmarks.

## Building LLVM
These scripts are used to evaluate the benchmark running time under different percentages of inserted fences. It uses a random function to insert `x%` (`x` are 0,1,2,3,4,5,10,20,30,40,50,100) of the fences in the hardening compiler pass. The compiler pass refers to a specific phase of compilation. It offers optimization of user programs during compilation. Every time the `x` got changed, the value script builds the LLVM first.
## Building benchmarks
There are 6 benchmarks tested by SpecFuzz: [brotli](https://github.com/google/brotli), [http-parser](https://github.com/nodejs/http-parser), [jsmn](https://github.com/zserge/jsmn), [libhtp](https://github.com/OISF/libhtp), [libyaml](https://github.com/yaml/libyaml), [openssl](https://github.com/openssl/openssl). For each round of `x%`, the `run-parallel.sh` builds 10 binaries of each benchmark and moves them to `/run/bin` path by using the GNU parallel tool. Also, it copies the corresponding input files for each binary.
## Running benchmarks
After all the binaries are built, the `run-parallel.sh` runs all binaries with the parallel tool. For each benchmark, there are 10 copies of binary. So in total, there will be 60 binaries running in parallel.
## Using
Correctly set the paths of SpecFuzz and benchmarks. And run `sudo bash run-parallel.sh` in your terminal.

Under `./script-history` are the scripts no longer used.