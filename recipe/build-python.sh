#!/bin/sh
set -ex

rm -rf build
mkdir build

cmake -G Ninja \
      ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_CXX_STANDARD=17 \
      -DCMAKE_INSTALL_LIBDIR="${PREFIX}/lib" \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DBUILD_SHARED_LIBS=ON \
      -DBUILD_DEPS=OFF \
      -DBUILD_Eigen3=OFF \
      -DBUILD_absl=OFF \
      -DUSE_SCIP=OFF \
      -S. \
      -Bbuild \
      -DBUILD_SAMPLES=OFF \
      -DBUILD_EXAMPLES=OFF \
      -DBUILD_PYTHON=ON \
      -DBUILD_pybind11=OFF \
      -DBUILD_pybind11_abseil=ON \
      -DBUILD_pybind11_protobuf=ON \
      -DFETCH_PYTHON_DEPS=OFF \
      -DBUILD_TESTING=OFF \
      -DPython3_EXECUTABLE="$PYTHON" \
      -DPython3_ROOT_DIR="${PREFIX}" \
      -DCMAKE_PREFIX_PATH="${PREFIX}" \
      -DPython3_FIND_VIRTUALENV=ONLY \
      -DPython3_FIND_STRATEGY=LOCATION \
      -DPython3_EXECUTABLE=${PREFIX}/bin/python \
      -DPython3_LIBRARY=%PREFIX%\libs\python%PY_VER:~0,1%%PY_VER:~2,2%.lib \
      -DCMAKE_INSTALL_PYDIR=$SP_DIR \
      -DPython_EXECUTABLE=$PYTHON \
      -DCMAKE_VERBOSE_MAKEFILE=ON \
      -DBUILD_TESTS=OFF

cmake --build build -j"${CPU_COUNT}"

echo Install begins here

${PYTHON} -m pip install --no-index --find-links=build/python/dist ortools --ignore-installed --no-deps --no-build-isolation -vv
