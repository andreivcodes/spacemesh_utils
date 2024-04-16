docker buildx build --platform linux/amd64,linux/arm64 -t spacemesh-providers . --push && docker run --gpus all spacemesh-providers
