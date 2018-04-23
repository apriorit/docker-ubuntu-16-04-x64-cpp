#Source image - Ubuntu 16.04
FROM ubuntu:16.04

#Install common soft
RUN apt-get update && apt-get install -y \
	git \
	curl \
	cmake \
	automake \
	zip

#Install Cpp environment
RUN apt-get update && apt-get install -y \	
	build-essential \
	autoconf \
	libtool \
	pkg-config \
	libgflags-dev \
	libgtest-dev \
	clang libc++-dev \
	libusb-1.0-0-dev \
	libudev-dev 

#Install grpc
RUN git clone -b $(curl -L https://grpc.io/release) https://github.com/grpc/grpc && cd grpc && git submodule update --init && make && make install && cd third_party/protobuf && make install

#Other 
RUN apt-get update && apt-get install -y \
	uuid-dev \
	libmagickwand-dev \
	libmagick++-dev \
	libnl-3-dev \
	libnl-genl-3-dev \
	libsystemd-dev

#Install gtest	
RUN apt-get update && apt-get install -y libgtest-dev && cd /usr/src/gtest && cmake CMakeLists.txt && make && cp *.a /usr/lib
	
#Install grpc_tools
RUN apt-get update && apt-get install -y \
	python-dev \
	python-pip
RUN python -m pip install --upgrade pip && python -m pip install grpcio-tools

RUN mkdir /src
WORKDIR /src