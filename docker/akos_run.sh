docker run --gpus=all --rm -it \
    -v $HOME/repos/dino:/home/user/dino \
    -v /data:/data \
    my-dino-image:latest

