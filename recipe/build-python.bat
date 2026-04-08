@echo off
setlocal enabledelayedexpansion

set PKG_CONFIG_PATH=%PREFIX%\Library\lib\pkgconfig;%PKG_CONFIG_PATH%

rmdir /s /q build
mkdir build

cmake -B build -G Ninja -S . ^
    %CMAKE_ARGS% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_LIBDIR=lib ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DBUILD_SHARED_LIBS=ON ^
    -DBUILD_DEPS=OFF ^
    -DBUILD_Eigen3=OFF ^
    -DBUILD_absl=OFF ^
    -DUSE_SCIP=OFF ^
    -DUSE_HIGHS=OFF ^
    -DBUILD_PYTHON=ON ^
    -DFETCH_PYTHON_DEPS=OFF ^
    -DBUILD_TESTING=OFF ^
    -DBUILD_pybind11_abseil=ON ^
    -DBUILD_pybind11_protobuf=ON ^
    -DPython3_EXECUTABLE=%PYTHON% ^
    -DPython3_ROOT_DIR=%PREFIX% ^
    -DPython3_FIND_STRATEGY=LOCATION ^
    -DPython3_LIBRARY=%PREFIX%\libs\python%PY_VER:~0,1%%PY_VER:~2,2%.lib ^
    -DCMAKE_PREFIX_PATH=%PREFIX% ^
    -DCMAKE_INSTALL_PYDIR=%SP_DIR% ^
    -DBUILD_SAMPLES=OFF ^
    -DBUILD_EXAMPLES=OFF ^
    -DBUILD_PYTHON_EXAMPLES=OFF
if errorlevel 1 exit /b 1

cmake --build build -j %CPU_COUNT%
if errorlevel 1 exit /b 1

copy build\bin\ortools.dll %PREFIX%\Library\bin
if errorlevel 1 exit /b 1

echo Install begins here
%PYTHON% -m pip install --no-index --find-links=build\python\dist ortools --ignore-installed --no-deps --no-build-isolation -vv
if errorlevel 1 exit /b 1
