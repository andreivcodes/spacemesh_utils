FROM rust:latest AS builder

RUN apt update && \
    apt install -y \
    git \
    build-essential \
    cmake \
    llvm-dev \
    libclang-dev \
    clang \
    ocl-icd-opencl-dev \
    ocl-icd-libopencl1 \
    opencl-headers \
    clinfo

RUN rustup default nightly

WORKDIR /app

RUN git clone https://github.com/spacemeshos/post-rs

WORKDIR /app/post-rs/initializer

RUN cargo build --release

FROM ubuntu

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

COPY --from=builder /app/post-rs/target/release/initializer ./initializer

ENTRYPOINT ["./initializer"]
CMD ["--help"]
