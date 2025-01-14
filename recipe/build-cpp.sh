#!/bin/sh
set -ex

rm -rf build
mkdir build

cmake -G Ninja \
      ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_CXX_STANDARD=17 \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DBUILD_SHARED_LIBS=ON \
      -DBUILD_DEPS=OFF \
      -DBUILD_Eigen3=OFF \
      -DBUILD_absl=OFF \
      -DBUILD_pybind11=OFF \
      -DBUILD_pybind11_abseil=OFF \
      -DBUILD_pybind11_protobuf=OFF \
      -DUSE_SCIP=OFF \
      -S. \
      -Bbuild \
      -DBUILD_SAMPLES=OFF \
      -DBUILD_EXAMPLES=OFF

cmake --build build --target install -j${CPU_COUNT}
