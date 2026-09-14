@echo off
setlocal enabledelayedexpansion

set PKG_CONFIG_PATH=%PREFIX%\Library\lib\pkgconfig;%PKG_CONFIG_PATH%

rmdir /s /q build
mkdir build

cmake -B build -G Ninja -S . ^
    %CMAKE_ARGS% ^
    -DCMAKE_CXX_FLAGS="/EHsc" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_CXX_STANDARD=17 ^
    -DCMAKE_INSTALL_LIBDIR=lib ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DBUILD_SHARED_LIBS=ON ^
    -DBUILD_DEPS=OFF ^
    -DBUILD_Eigen3=OFF ^
    -DBUILD_absl=OFF ^
    -DBUILD_pybind11=OFF ^
    -DBUILD_pybind11_abseil=OFF ^
    -DBUILD_pybind11_protobuf=OFF ^
    -DUSE_SCIP=OFF ^
    -DBUILD_SAMPLES=OFF ^
    -DBUILD_EXAMPLES=OFF

if errorlevel 1 exit /b 1

cmake --build build --target install -j %CPU_COUNT%

if errorlevel 1 exit /b 1