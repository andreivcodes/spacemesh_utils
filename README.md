# About

This is a collection of Docker images which builds the [Spacemesh](https://spacemesh.io) stack from source and makes it easy to run.

# Node

`-e FILESIZE=` - The file size of your post files.

`-e NUM_UNITS=` - The number of post units.

`-e START=` - Start mining.

`-e SMESHING_COINBASE_ADDRESS=` - The reward address for mining.

`-v /local/dir/path/for/post=./post-data` - Maps the local `/local/dir/path/for/post` directory to the container `/post-data` directory. The container is hardcoded to use `/post-data` for post data.

`-v /local/dir/path/for/node=./node-data` - Maps the local `/local/dir/path/for/node` directory to the container `/node-data` directory. The container is hardcoded to use `/node-data` for node state data.

Example:

`docker run -e FILE_SIZE=2147483648 -e NUM_UNITS=16 -e START=true -e SMESHING_COINBASE_ADDRESS=your_address -v /local/dir/path/for/post=./post-data -v /local/dir/path/for/node=./node-data andreivcodes/spacemesh-miner`

# Initializer

## list-providers

list-providers ouputs the available compute providers for initializing data.

_Requirements:_

- _[Docker](http://docker.com)_
- _[Nvidia Container Tookit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html)_
- _Nvidia GPU_

Example:

`docker run --gpus 'all,"capabilities=compute,utility"' --rm -it andreivcodes/spacemesh-initializer list-providers`

Example output:

```
0: [GPU] NVIDIA CUDA/NVIDIA GeForce RTX 4070
1: [CPU] scrypt-jane
```
