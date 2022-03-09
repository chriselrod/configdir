
if status --is-interactive

  set -xg EDITOR nvim
  #set -xg CFLAGS -g -O3 -feliminate-unused-debug-types -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=32 -Wformat -Wformat-security -m64 -fasynchronous-unwind-tables -Wp,-D_REENTRANT -ftree-loop-distribute-patterns -Wl,-z -Wl,now -Wl,-z -Wl,relro -fno-semantic-interposition -ffat-lto-objects -fno-trapping-math -Wl,-sort-common -Wl,--enable-new-dtags -march=native -Wa,-mbranches-within-32B-boundaries
  #set -xg CXXFLAGS -g -O3 -feliminate-unused-debug-types -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=32 -Wformat -Wformat-security -m64 -fasynchronous-unwind-tables -Wp,-D_REENTRANT -ftree-loop-distribute-patterns -Wl,-z -Wl,now -Wl,-z -Wl,relro -fno-semantic-interposition -ffat-lto-objects -fno-trapping-math -Wl,-sort-common -Wl,--enable-new-dtags -march=native -Wa,-mbranches-within-32B-boundaries -fvisibility-inlines-hidden -Wl,--enable-new-dtags
  set -xg CFLAGS -g -O3 -feliminate-unused-debug-types -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=32 -Wformat -Wformat-security -m64 -fasynchronous-unwind-tables -Wp,-D_REENTRANT -fno-semantic-interposition -fno-trapping-math -march=native -fPIC
  set -xg CXXFLAGS -g -O3 -feliminate-unused-debug-types -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=32 -Wformat -Wformat-security -m64 -fasynchronous-unwind-tables -Wp,-D_REENTRANT -fno-semantic-interposition -fno-trapping-math -march=native -fPIC
  set -xg FFLAGS -g -O3 -feliminate-unused-debug-types -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=32 -m64 -fasynchronous-unwind-tables -Wp,-D_REENTRANT -ftree-loop-distribute-patterns -Wl,-z -Wl,now -Wl,-z -Wl,relro -malign-data=abi -march=native -fno-semantic-interposition -ftree-vectorize -ftree-loop-vectorize -Wl,--enable-new-dtags -Wa,-mbranches-within-32B-boundaries
  set -xg JULIA_NUM_THREADS (nproc)

  alias g="git"
  alias gg="git grep -nr"
#  alias julia="/home/chriselrod/Documents/languages/julia/usr/bin/julia -O3 -C\"native,-prefer-256-bit\" -q"

  
  abbr --add --global ht 'htop -sPERCENT_CPU'

  abbr --add --global j '/home/chriselrod/Documents/languages/julialts/usr/bin/julia -O3 -C"native,-prefer-256-bit" -q'
  abbr --add --global jm '/home/chriselrod/Documents/languages/julia/usr/bin/julia -O3 -C"native,-prefer-256-bit" -q'
  abbr --add --global jmm1 '/home/chriselrod/Documents/languages/juliamm1/usr/bin/julia -O3 -C"native,-prefer-256-bit" -q'
  abbr --add --global jlts '/home/chriselrod/Documents/languages/julialts/usr/bin/julia -O3 -C"native,-prefer-256-bit" -q'
  abbr --add --global jr '/home/chriselrod/Documents/languages/juliarelease/usr/bin/julia -O3 -C"native,-prefer-256-bit" -q'
  abbr --add --global jmd '/home/chriselrod/Documents/languages/julia/usr/bin/julia -O3 --project=~/Documents/progwork/julia/devproject -C"native,-prefer-256-bit" -q'
  abbr --add --global jrd '/home/chriselrod/Documents/languages/juliarelease/usr/bin/julia -O3 -c"native,-prefer-256-bit" --project=~/Documents/progwork/julia/devproject -q'
  abbr --add --global jmp '/home/chriselrod/Documents/languages/julia/usr/bin/julia -O3 --project=~/Documents/progwork/julia/pumas -C"native,-prefer-256-bit" -q'
  abbr --add --global jrp '/home/chriselrod/Documents/languages/juliarelease/usr/bin/julia -O3 --project=~/Documents/progwork/julia/pumas -C"native,-prefer-256-bit" -q'
  abbr --add --global m 'time make -j(nproc)'
  abbr --add --global n 'time ninja'
  # abbr --add --global mgitstatus '/home/chriselrod/Documents/libraries/multi-git-status/mgitstatus'
end
