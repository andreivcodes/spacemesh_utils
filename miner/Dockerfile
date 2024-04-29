FROM golang

RUN apt-get update && apt-get install -y \
    git \
    git-lfs \
    make \
    curl \
    build-essential \
    unzip \
    wget \
    ocl-icd-libopencl1

RUN git-lfs install

WORKDIR /container

RUN git clone --progress --verbose https://github.com/spacemeshos/go-spacemesh

WORKDIR /container/go-spacemesh

RUN git fetch --all --tags
RUN git checkout tags/v1.5.1

RUN make get-libs
RUN make install
RUN make build

WORKDIR /container/go-spacemesh/build

RUN wget https://configs.spacemesh.network/config.mainnet.json

RUN chmod +x go-spacemesh

EXPOSE 9092
EXPOSE 9093

CMD ./go-spacemesh --config config.mainnet.json --smeshing-opts-maxfilesize $FILE_SIZE --smeshing-opts-numunits $NUM_UNITS --smeshing-start=$START --smeshing-coinbase $SMESHING_COINBASE_ADDRESS --smeshing-opts-datadir ./post-data --data-folder ./node-data
