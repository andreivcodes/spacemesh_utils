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

FROM rust:latest

RUN apt update && \
    apt install -y \
    ocl-icd-opencl-dev \
    ocl-icd-libopencl1 \
    opencl-headers \
    clinfo

WORKDIR /app

COPY --from=builder /app/post-rs/target/release/initializer ./initializer

CMD ["./initializer", "list-providers"]
