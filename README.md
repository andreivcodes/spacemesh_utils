# About

This is a collection of Docker images which builds the [Spacemesh](https://spacemesh.io) stack from source and makes it easy to run.

# Node - `andreivcodes/spacemesh-miner`

`-e FILESIZE=` - The file size of your post files.

`-e NUM_UNITS=` - The number of post units.

`-e START=` - Start mining.

`-e SMESHING_COINBASE_ADDRESS=` - The reward address for mining.

`-v /local/dir/path/for/post=./post-data` - Maps the local `/local/dir/path/for/post` directory to the container `/post-data` directory. The container is hardcoded to use `/post-data` for post data.

`-v /local/dir/path/for/node=./node-data` - Maps the local `/local/dir/path/for/node` directory to the container `/node-data` directory. The container is hardcoded to use `/node-data` for node state data.

Example:

`docker run -e FILE_SIZE=2147483648 -e NUM_UNITS=16 -e START=true -e SMESHING_COINBASE_ADDRESS=your_address -v /local/dir/path/for/post=./post-data -v /local/dir/path/for/node=./node-data andreivcodes/spacemesh-miner`

# Initializer - `andreivcodes/spacemesh-initializer`

_Requirements:_

- _[Docker](http://docker.com)_
- _[Nvidia Container Tookit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html)_
- _Nvidia GPU_

## Listing providers

list-providers ouputs the available compute providers for initializing data.

Example:

`docker run --gpus 'all,"capabilities=compute,utility"' --rm -it andreivcodes/spacemesh-initializer -printProviders`

Example output:

```
2024-04-17T07:57:53.637570931Z ([]postrs.Provider) (len=2 cap=2) {
2024-04-17T07:57:53.637599251Z  (postrs.Provider) {
2024-04-17T07:57:53.637602351Z   ID: (uint32) 0,
2024-04-17T07:57:53.637604451Z   Model: (string) (len=41) "[GPU] NVIDIA CUDA/NVIDIA GeForce RTX 4090",
2024-04-17T07:57:53.637606561Z   DeviceType: (postrs.DeviceClass) GPU
2024-04-17T07:57:53.637608541Z  },
2024-04-17T07:57:53.637610671Z  (postrs.Provider) {
2024-04-17T07:57:53.637612651Z   ID: (uint32) 4294967295,
2024-04-17T07:57:53.637614661Z   Model: (string) (len=17) "[CPU] scrypt-jane",
2024-04-17T07:57:53.637616671Z   DeviceType: (postrs.DeviceClass) CPU
2024-04-17T07:57:53.637618731Z  }
2024-04-17T07:57:53.637620651Z }
```

## Initializing PoST data

Example:

`docker run --gpus 'all,"capabilities=compute,utility"' --rm -it andreivcodes/spacemesh-initializer -provider=0 -numUnits=16 -commitmentAtxId=c230c51669d1fcd35860131e438e234726b2bd5f9adbbd91bd88a718e7e98ecb -datadir ./post -genproof`

Example output:

```
2024-04-17T08:10:28.903434472Z 2024/04/17 08:10:28 cli: generating new identity
2024-04-17T08:10:28.907650132Z 2024/04/17 08:10:28 generated key in identity.key
2024-04-17T08:10:28.907663252Z 2024/04/17 08:10:28 copy this file to the `data/identities` directory of your node
2024-04-17T08:10:28.917953668Z 2024-04-17T08:10:28.911Z	INFO	initialization started	{"datadir": "/workspace/post", "numUnits": 16, "maxFileSize": 4294967296, "labelsPerUnit": 4294967296}
2024-04-17T08:10:28.918004598Z 2024-04-17T08:10:28.911Z	INFO	initialization file layout	{"labelsPerFile": 268435456, "labelsLastFile": 268435456, "firstFileIndex": 0, "lastFileIndex": 255}
2024-04-17T08:10:28.918009038Z 2024-04-17T08:10:28.912Z	INFO	initialization: starting to write file	{"fileIndex": 0, "currentNumLabels": 0, "targetNumLabels": 268435456, "startPosition": 0}
2024-04-17T08:10:28.968517670Z 2024-04-17T08:10:28.967Z	INFO	selecting 0 provider from 1 available	{"module": "scrypt_ocl", "file": "scrypt-ocl/src/lib.rs", "line": 380}
2024-04-17T08:10:28.968543821Z 2024-04-17T08:10:28.968Z	INFO	Using provider: [GPU] NVIDIA CUDA/NVIDIA GeForce RTX 4090	{"module": "scrypt_ocl", "file": "scrypt-ocl/src/lib.rs", "line": 393}
2024-04-17T08:10:28.968550641Z 2024-04-17T08:10:28.968Z	INFO	device memory: 24217 MB, max_mem_alloc_size: 6054 MB, max_compute_units: 128, max_wg_size: 1024	{"module": "scrypt_ocl", "file": "scrypt-ocl/src/lib.rs", "line": 159}
2024-04-17T08:10:29.951813722Z 2024-04-17T08:10:29.951Z	INFO	preferred_wg_size_multiple: 32, kernel_wg_size: 256	{"module": "scrypt_ocl", "file": "scrypt-ocl/src/lib.rs", "line": 199}
2024-04-17T08:10:29.951849602Z 2024-04-17T08:10:29.951Z	INFO	Using: global_work_size: 12096, local_work_size: 32	{"module": "scrypt_ocl", "file": "scrypt-ocl/src/lib.rs", "line": 212}
2024-04-17T08:10:29.951854522Z 2024-04-17T08:10:29.951Z	INFO	Allocating buffer for input: 32 bytes	{"module": "scrypt_ocl", "file": "scrypt-ocl/src/lib.rs", "line": 216}
2024-04-17T08:10:29.951858713Z 2024-04-17T08:10:29.951Z	INFO	Allocating buffer for output: 387072 bytes	{"module": "scrypt_ocl", "file": "scrypt-ocl/src/lib.rs", "line": 224}
2024-04-17T08:10:29.951861742Z 2024-04-17T08:10:29.951Z	INFO	Allocating buffer for lookup: 6341787648 bytes	{"module": "scrypt_ocl", "file": "scrypt-ocl/src/lib.rs", "line": 237}
2024-04-17T08:20:24.599458782Z 2024-04-17T08:20:24.599Z	INFO	initialization: completed	{"fileIndex": 0, "numLabelsWritten": 268435456}
2024-04-17T08:20:24.627760788Z 2024-04-17T08:20:24.627Z	INFO	initialization: starting to write file	{"fileIndex": 1, "currentNumLabels": 0, "targetNumLabels": 268435456, "startPosition": 268435456}
```

There is a preconfigured [runpod.io](https://runpod.io) template using this image here

[https://runpod.io/console/deploy?template=6747jlo193&ref=1bqdw1sc](https://runpod.io/console/deploy?template=6747jlo193&ref=1bqdw1sc)
