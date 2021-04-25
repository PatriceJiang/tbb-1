#!/bin/bash
cmake . -GNinja \
 -Bbuild-mac \
 -DCMAKE_C_COMPILER=clang  \
 -DCMAKE_CXX_COMPILER=clang++ \
 -DCMAKE_OSX_ARCHITECTURES=arm64 \
 -DCMAKE_BUILD_TYPE=Release \
 -DCMAKE_OSX_DEPLOYMENT_TARGET=10.0
