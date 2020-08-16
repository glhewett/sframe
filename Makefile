# This is just a convenience Makefile to avoid having to remember
# all the CMake commands and their arguments.

# choose: Ninja, Unix Makefiles, Xcode, or leave blank for default
GENERATOR=-G Ninja
BUILD_DIR=build
CLANG_FORMAT=clang-format

.PHONY: all tidy test clean cclean format

all: ${BUILD_DIR} format
	cmake --build ${BUILD_DIR}

test: all
	make -C test test

tidy:
	cmake ${GENERATOR} -B${BUILD_DIR} -DCLANG_TIDY=ON .

${BUILD_DIR}: CMakeLists.txt
	cmake ${GENERATOR} -B${BUILD_DIR} .

clean:
	cd ${BUILD_DIR} && ninja clean

cclean:
	rm -rf ${BUILD_DIR}

format:
	${CLANG_FORMAT} -i src/*.cpp
	${CLANG_FORMAT} -i include/sframe/*.h
	${CLANG_FORMAT} -i test/*.cpp
