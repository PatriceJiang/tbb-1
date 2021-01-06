#!/bin/bash -x
#export ANDROID_NDK_L=$ANDROID_HOME/ndk-bundle
export ANDROID_NDK_L=$ANDROID_HOME/ndk/21.1.6352462
#CMAKE_EXE=$ANDROID_HOME/cmake/3.10.2.4988404/bin/cmake


for arch in armeabi-v7a arm64-v8a x86 x86_64 
do 
echo "Building for arch $arch ... "
ARCH=$arch
INSTALL_DIR=/Users/pt/Github/tbb/install/android/$ARCH
mkdir -p $INSTALL_DIR
CMAKE_EXE=cmake
PATH=$PATH:$ANDROID_NDK_L ${CMAKE_EXE} .. "-DCMAKE_CXX_FLAGS=-frtti -fexceptions -fsigned-char" \
    "-DCMAKE_BUILD_TYPE=Release" \
    "-GNinja" \
    "-DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_L/build/cmake/android.toolchain.cmake" \
    "-DANDROID_ABI=$ARCH" \
    "-DANDROID_NDK=$ANDROID_NDK_L" \
    "-DANDROID_PLATFORM=21" \
    "-DCMAKE_ANDROID_NDK=$ANDROID_NDK_L" \
    "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" \
    "-DCMAKE_MAKE_PROGRAM=$ANDROID_HOME/cmake/3.10.2.4988404/bin/ninja" \
    "-DCMAKE_SYSTEM_NAME=Android" \
    "-DCMAKE_SYSTEM_VERSION=21" \
    "-DANDROID_STL=c++_static" \
    "-DANDROID_TOOLCHAIN=clang" \
    -DCMAKE_CXX_STANDARD=14 \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR

ninja install 
echo "stripping ... "
$ANDROID_NDK_L/toolchains/llvm/prebuilt/darwin-x86_64/bin/llvm-strip --strip-debug $INSTALL_DIR/lib/*.a
done
