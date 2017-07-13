# Base image
FROM ubuntu:16.04

# Set version and description of mips-none-elf-gcc
LABEL version="1.0" description="mips-none-elf toolchain"

RUN apt-get update && apt-get install -qq -y wget \
    && cd home \
    && wget -q http://ftp.gnu.org/gnu/binutils/binutils-2.28.tar.gz \
    && tar -xzf binutils-2.28.tar.gz \
    && rm binutils-2.28.tar.gz \
    && wget -q http://mirrors-usa.go-parts.com/gcc/releases/gcc-6.3.0/gcc-6.3.0.tar.gz \
    && tar -xzf gcc-6.3.0.tar.gz \
    && rm gcc-6.3.0.tar.gz \
    && wget -q ftp://sourceware.org/pub/newlib/newlib-2.5.0.20170623.tar.gz \
    && tar -xzf newlib-2.5.0.20170623.tar.gz \
    && rm newlib-2.5.0.20170623.tar.gz
