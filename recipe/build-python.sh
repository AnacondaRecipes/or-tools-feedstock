#!/bin/sh
set -ex


# Run CMake with specified configurations
cmake -G Ninja \
      ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_CXX_STANDARD=17 \
      -DCMAKE_INSTALL_LIBDIR="${PREFIX}/lib" \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DBUILD_SHARED_LIBS=ON \
      -DBUILD_DEPS=OFF \
      -DBUILD_Eigen3=ON \
      -DBUILD_absl=OFF \
      -DUSE_SCIP=OFF \
      -S. \
      -Bbuild \
      -DBUILD_SAMPLES=OFF \
      -DBUILD_EXAMPLES=OFF \
      -DBUILD_PYTHON=ON \
      -DBUILD_pybind11=OFF \
      -DFETCH_PYTHON_DEPS=OFF \
      -DBUILD_TESTING=OFF \
      -DPython3_EXECUTABLE="$PYTHON" \
      -DPython3_ROOT_DIR="${PREFIX}" \
      -DCMAKE_PREFIX_PATH="${PREFIX}" \
      -DPython3_FIND_VIRTUALENV=ONLY \
      -DPython3_FIND_STRATEGY=LOCATION \
      -DPython3_EXECUTABLE=${PREFIX}/bin/python \
      -DPython3_LIBRARY=%PREFIX%\libs\python%PY_VER:~0,1%%PY_VER:~2,2%.lib 

# Build with the specified number of processors
cmake --build build -j"${CPU_COUNT}"

echo Install begins here

# Install Python package
${PYTHON} -m pip install --no-index --find-links=build/python/dist ortools -vv

