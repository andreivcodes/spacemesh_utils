FROM golang:latest AS builder

RUN apt update && \
    apt install -y \
    git \
    build-essential \
    cmake \
    llvm-dev \
    libclang-dev \
    ;

RUN apt-get update && apt-get -y upgrade \
    && apt-get install -y \
    apt-utils \
    unzip \
    tar \
    curl \
    xz-utils \
    ocl-icd-libopencl1 \
    opencl-headers \
    clinfo \
    ;


WORKDIR /app

RUN git clone --depth 1 --branch v0.12.8 https://github.com/spacemeshos/post

WORKDIR /app/post

RUN make install && \
    make get-postrs-lib && \
    make build

FROM ubuntu:latest

RUN apt-get update && apt-get -y upgrade \
    && apt-get install -y \
    apt-utils \
    unzip \
    tar \
    curl \
    xz-utils \
    ocl-icd-libopencl1 \
    opencl-headers \
    clinfo \
    ;

RUN mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

WORKDIR /app

COPY --from=builder /app/post/build/postcli .
COPY --from=builder /app/post/build/libpost.so .

ENTRYPOINT ["./postcli"]
CMD ["--help"]
