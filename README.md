# About

This is a collection of Docker images which build the [Spacemesh](https://spacemesh.io) stack from source and makes it easy to run.

# Node

`docker run -e FILE_SIZE=2147483648 -e NUM_UNITS=16 -e START=true -e SMESHING_COINBASE_ADDRESS=your_address -e /local/dir/path/for/post=./post-data -e /local/dir/path/for/state=./node-data andreivcodes/spacemesh-miner`

# Initializer

## list-providers

List providers ouputs the available compute providers for initializing data.

_Requirements:_

- _[Docker](http://docker.com)_
- _[Nvidia Container Tookit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html)_
- _Nvidia GPU_

`docker run --gpus 'all,"capabilities=compute,utility"' --rm -it andreivcodes/spacemesh-initializer list-providers`

Example output:

```
0: [GPU] NVIDIA CUDA/NVIDIA GeForce RTX 4070
1: [CPU] scrypt-jane
```
