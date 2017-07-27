# Base image
FROM ubuntu:16.04

# Set version and description of mips-none-elf-gcc
LABEL version="1.0" description="mips-none-elf toolchain"

# Set binutils, GCC and newlib versions
ARG BINUTILS_VERSION=2.28
ARG GCC_VERSION=6.3.0
ARG NEWLIB_VERSION=2.5.0.20170623

# Set build parameters
ARG TARGET=mips-none-elf
ARG PREFIX=/usr/local/$TARGET
ARG PATH=$PATH:$PREFIX/bin

WORKDIR /home

RUN apt-get update && apt-get install -qq \
    bzip2 \
    gcc \
    gcc-multilib \
    g++ \
    make \
    wget \
 && wget http://ftp.gnu.org/gnu/binutils/binutils-$BINUTILS_VERSION.tar.gz \
 && tar -xzf binutils-$BINUTILS_VERSION.tar.gz \
 && rm binutils-$BINUTILS_VERSION.tar.gz \
 && wget http://mirrors-usa.go-parts.com/gcc/releases/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.gz \
 && tar -xzf gcc-$GCC_VERSION.tar.gz \
 && rm gcc-$GCC_VERSION.tar.gz \
 && wget ftp://sourceware.org/pub/newlib/newlib-$NEWLIB_VERSION.tar.gz \
 && tar -xzf newlib-$NEWLIB_VERSION.tar.gz \
 && rm newlib-$NEWLIB_VERSION.tar.gz \
 && mkdir build-binutils \
 && cd build-binutils \
 && ../binutils-$BINUTILS_VERSION/configure --target=$TARGET --prefix=$PREFIX \
 && make -j5 all \
 && make -j5 install \
 && cd ../gcc-$GCC_VERSION \
 && ./contrib/download_prerequisites \
 && mkdir ../build-gcc \
 && cd ../build-gcc \
 && ../gcc-$GCC_VERSION/configure --target=$TARGET --prefix=$PREFIX --without-headers --with-newlib  --with-gnu-as --with-gnu-ld \
 && make -j5 all-gcc \
 && make -j5 install-gcc
