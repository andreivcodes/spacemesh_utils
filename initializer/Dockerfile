FROM golang AS builder

RUN apt update && \
    apt install -y \
    unzip \
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

WORKDIR /app

RUN git clone https://github.com/spacemeshos/post

WORKDIR /app/post

RUN git fetch --all --tags
RUN git checkout tags/v0.12.8

RUN make install
RUN make get-postrs-lib
RUN make build

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

COPY --from=builder /app/post/build/postcli .
COPY --from=builder /app/post/build/libpost.so .

ENTRYPOINT ["./postcli"]
CMD ["--help"]
