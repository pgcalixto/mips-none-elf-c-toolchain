# Base image
FROM ubuntu:16.04

# Set version and description of mips-none-elf-gcc
LABEL version="1.0" description="mips-none-elf toolchain"

WORKDIR /home

RUN apt-get update && apt-get install -qq \
    bzip2 \
    gcc \
    gcc-multilib \
    g++ \
    make \
    wget \
 && wget http://ftp.gnu.org/gnu/binutils/binutils-2.28.tar.gz \
 && tar -xzf binutils-2.28.tar.gz \
 && rm binutils-2.28.tar.gz \
 && wget http://mirrors-usa.go-parts.com/gcc/releases/gcc-6.3.0/gcc-6.3.0.tar.gz \
 && tar -xzf gcc-6.3.0.tar.gz \
 && rm gcc-6.3.0.tar.gz \
 && wget -q ftp://sourceware.org/pub/newlib/newlib-2.5.0.20170623.tar.gz \
 && tar -xzf newlib-2.5.0.20170623.tar.gz \
 && rm newlib-2.5.0.20170623.tar.gz \
 && export TARGET=mips-none-elf \
 && export PREFIX=/usr/local/$TARGET \
 && export PATH=$PATH:$PREFIX/bin
 && mkdir build-binutils \
 && cd build-binutils \
 && ../binutils-2.28/configure --target=$TARGET --prefix=$PREFIX \
 && make all \
 && make install \
 && cd ../gcc-6.3.0 \
 && ./contrib/download_prerequisites \
 && mkdir ../build-gcc \
 && cd ../build-gcc \
 && ../gcc-6.3.0/configure --target=$TARGET --prefix=$PREFIX --without-headers --with-newlib  --with-gnu-as --with-gnu-ld \
 && make all-gcc \
 && make install-gcc \
 && cd ..
