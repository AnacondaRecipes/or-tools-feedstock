#!/bin/sh
set -ex

rm -rf build
mkdir build

cmake -B build -G Ninja -S . \
      ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_CXX_STANDARD=17 \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DBUILD_SHARED_LIBS=ON \
      -DBUILD_TESTING=OFF \
      -DBUILD_DEPS=OFF \
      -DBUILD_Eigen3=OFF \
      -DBUILD_absl=OFF \
      -DUSE_SCIP=OFF \
      -DUSE_HIGHS=OFF \
      -DBUILD_SAMPLES=OFF \
      -DBUILD_EXAMPLES=OFF \
      -DCMAKE_SHARED_LINKER_FLAGS="-L${PREFIX}/lib -lCoinUtils" # The upstream cmake doesn't discover the lib properly

cmake --build build --target install -j${CPU_COUNT}
