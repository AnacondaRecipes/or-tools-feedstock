#!/bin/sh
set -ex

cd pybind11_abseil

rm -rf build
mkdir build

# See:
# https://github.com/pybind/pybind11_abseil/blob/52f2739/scripts/build_and_run_tests_cmake.sh

cmake -G Ninja \
      ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_CXX_STANDARD=17 \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_PYDIR=$SP_DIR \
      -DPython_EXECUTABLE=$PYTHON \
      -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_VERBOSE_MAKEFILE=ON \
      -DBUILD_TESTING=OFF \
      -S . -B build

echo "Building and installing project..."
cmake --build build --target install --verbose -j${CPU_COUNT}
