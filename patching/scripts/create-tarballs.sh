#!/bin/bash -ex

shopt -s nullglob

mkdir -p tarballs

for f in patches/*
do
    (
    PKG1=$(basename $f)
    PKG=${PKG1%.patch}
    rm -rf tmp
    mkdir tmp
    (
    cd tmp
    cabal unpack $PKG
    cd $PKG
    patch -p1 < ../../$f
    cabal sdist
    mv dist/$PKG.tar.gz ../../tarballs
    )
    rm -rf tmp
    )
done
