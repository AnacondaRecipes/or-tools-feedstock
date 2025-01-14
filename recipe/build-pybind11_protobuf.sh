#!/bin/sh
set -ex

cd pybind11_protobuf
rm -rf build
mkdir build

cmake -G Ninja \
      ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_CXX_STANDARD=17 \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_VERBOSE_MAKEFILE=ON \
      -DBUILD_TESTS=OFF \
      -S . -B build

echo "Building and installing project..."
cmake --build build --target install --verbose -j${CPU_COUNT}
