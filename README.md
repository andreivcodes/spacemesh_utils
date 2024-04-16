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
