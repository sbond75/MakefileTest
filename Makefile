SOURCES = $(wildcard ./driver/*.cpp) ./commonOutMutex.cpp
OBJS = $(patsubst %.cpp, %.o, $(SOURCES))
CXXFLAGS = -I./VectorNav/include
LDFLAGS = ${NIX_LDFLAGS} -L ./VectorNav/build/bin -lvncxx -lpigpio



# To see implicit rules (and all rules), run: `make --print-data-base --dry-run` and look for this to see the default cpp compilation rule:
# %.o: %.cpp
# #  commands to execute (built-in):
# 	$(COMPILE.cpp) $(OUTPUT_OPTION) $<

# %.o: %.cpp
#	gcc .cpp -o .o



all: ./VectorNav/build/bin/libvncxx.a $(OBJS) main.o
	g++ $^ $(CFLAGS) $(LDFLAGS)

./VectorNav/build/bin/libvncxx.a:
	cd ./VectorNav && $(MAKE)

.PHONY: clean
clean:
	rm -f $(OBJS)
	cd ./VectorNav && make clean
