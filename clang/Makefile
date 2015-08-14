all: hello_clang hello_gcc

hello_clang: hello_clang.nim
	nim c -o:$@ -d:release --cc:gcc --verbosity:0 $<

hello_gcc: hello_gcc.nim
	nim c -o:$@ -d:release --cc:clang --verbosity:0 $<

.PHONY:
clean:
	rm -f hello_gcc hello_clang
	rm -rf nimcache
