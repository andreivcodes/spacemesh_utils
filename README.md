# Spacemesh Docker Utilities

This repository contains Docker images for building and running the [Spacemesh](https://spacemesh.io/) stack from source code.

## Node

### `andreivcodes/spacemesh-miner`

#### Parameters:

- `-e FILESIZE=`: File size of post files
- `-e NUM_UNITS=`: Number of post units
- `-e START=`: Initiates mining
- `-e SMESHING_COINBASE_ADDRESS=`: Mining reward address
- `-v /local/dir/path/for/post=./post-data`: Maps local post directory
- `-v /local/dir/path/for/node=./node-data`: Maps local node directory

#### Example:

```bash
docker run -e FILE_SIZE=2147483648 -e NUM_UNITS=16 -e START=true \
           -e SMESHING_COINBASE_ADDRESS=your_address \
           -v /local/dir/path/for/post=./post-data \
           -v /local/dir/path/for/node=./node-data \
           andreivcodes/spacemesh-miner
```

## Initializer

### `andreivcodes/spacemesh-initializer`

#### Requirements:

- Nvidia GPU
- [Docker](http://docker.com/)
- [Nvidia Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html)

### Installation Guide

1. Add `contrib` and `non-free` repository components:
   ```bash
   apt update && apt install software-properties-common -y
   apt-add-repository --component non-free contrib -y
   ```

2. Install Nvidia drivers:
   ```bash
   apt update && apt install nvidia-smi nvidia-cuda-toolkit clinfo -y
   ```

3. Install Docker:
   ```bash
   curl -fsSL https://get.docker.com | sh
   ```

4. Install Nvidia container toolkit:
   ```bash
   apt install sudo -y
   curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
     && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
       sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
       sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
   apt update && apt install nvidia-container-toolkit nvidia-container-runtime -y
   ```

5. Configure Nvidia container toolkit:
   ```bash
   nvidia-ctk runtime configure --runtime=docker
   systemctl restart docker
   ```

### Usage

#### Listing Providers:

```bash
docker run --rm --runtime=nvidia --gpus all -it andreivcodes/spacemesh-initializer -printProviders
```

#### Initializing PoST Data:

```bash
docker run -v ./host-post-data:/post --gpus all --rm -it andreivcodes/spacemesh-initializer \
           -provider=0 -numUnits=8 \
           -commitmentAtxId=c230c51669d1fcd35860131e438e234726b2bd5f9adbbd91bd88a718e7e98ecb \
           -datadir /post -genproof
```
