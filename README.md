# Script illustration
This is the repo containing the shell scripts used for running the benchmarks of [SpecFuzz](https://github.com/OleksiiOleksenko/SpecFuzz). 
This script mainly changes the percentage of fences inserted by the `hardenEdgesWithLFENCE` function in the [X86SpeculativeLoadHardening](https://github.com/OleksiiOleksenko/SpecFuzz/blob/master/install/patches/llvm/X86SpeculativeLoadHardening.cpp) pass. Mainly I use the `run-p-disabslh.sh` to create paths, build the SLH Pass & LLVM, build benchmarks, run the benchmarks, and data wrangling. Specifically:

## Create path
For every benchmark, I make ten copies of their project saved at `~/benchmarks/run/bench/`, each of which is named as [benchmarkname]-[1-10]. This enables building the binaries in parallel but costs more storage. The path-creating is required only once. Thus after the paths were created, these codes were commented out.
## Building LLVM
These scripts are used to evaluate the benchmark running time under different percentages of inserted fences. It uses a random function to insert `x%` (`x` are 0,1,2,3,4,5,10,20,30,40,50,100) of the fences in the hardening compiler pass. (The compiler pass refers to a specific phase of compilation. It offers optimization of user programs during compilation.) Every time the `x` got changed, the value script builds the LLVM first.
The `run-p-disabslh.sh` goes to the path of SpecFuzz, changes the value of `x`, and then builds the compiler. 
## Building benchmarks
There are 6 benchmarks tested by SpecFuzz: [brotli](https://github.com/google/brotli), [http-parser](https://github.com/nodejs/http-parser), [jsmn](https://github.com/zserge/jsmn), [libhtp](https://github.com/OISF/libhtp), [libyaml](https://github.com/yaml/libyaml), [openssl](https://github.com/openssl/openssl). For each round of evaluating (each round means running them with a specific `x`), the `run-parallel.sh` goes to the path of all benchmarks and builds the binaries.

## Running benchmarks
After all the binaries are built, the `run-parallel.sh` runs all binaries with the parallel tool. For each benchmark, there are 10 copies of binary. So in total, there will be 60 binaries running in parallel.
The execution of each benchmark is controlled by `[benchmark]-run.sh` file, so in total there are 6 `.sh` files: `jsmn-run.sh`, `libyaml-run.sh`, `brotli-run.sh`, `http-run.sh`, `libhtp-run.sh`, `openssl-run.sh`. Each benchmark requires different input to start running, so I use different script files to control the binary evaluation and results output.
The results are outputted to `results-[benchmark].log` files at `~/benchmarks/run/results/`.

## Data wrangling
When the evaluation is done and all data are outputted, the `run-p-disabslh.sh` performs data wrangling. It captures the interested data, performs unit conversion (from minutes and seconds to seconds), and outputs to `simplified-[benchmark].log`.