#Source image - Ubuntu 16.04
FROM ubuntu:16.04
#Install common soft
RUN apt-get update && apt-get install -y \
	git \
	curl \
	cmake

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
RUN apt-get update && apt-get install uuid-dev -y

#Install grpc_tools
RUN apt-get update && apt-get install -y \
	python-dev \
	python-pip
RUN python -m pip install --upgrade pip && python -m pip install grpcio-tools

RUN mkdir /src
WORKDIR /src
