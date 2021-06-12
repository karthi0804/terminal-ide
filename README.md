# Terminal based IDE

## Description
This project contains the code necessary to build the docker image of linux terminal based IDE. It is built on [NeoVim](https://github.com/neovim/neovim), [Tmux](https://github.com/tmux/tmux) and inlcudes most popular plugins. It supports GUI based matplotlib visualization using [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/index.html). This can be a preferable python IDE for developing deep learning models. 

## Getting Started

### Dependencies
- docker (verified with 20.10.6)
- docker-compose (verified in 1.29.2)

### Executing program
1. Create docker-compose.yml file at the project root folder following the below format with the required inputs 
    - baseimage : any images from dockerhub (default: `nvidia/cuda:10.2-devel-ubunut18.04`)
    - uid : same as the user of the host

```dockerfile
version: "3.9"
services:
  terminal-ide-service:
    image: terminal-ide:${USER}
    build:
      context: .
      dockerfile: Dockerfile
      args:
        - baseimage=nvidia/cuda:10.2-devel-ubuntu18.04  # baseimage  
        - uid=1000  # uid of the host
        - user=${USER}
    ports:
      - 8899:8899  # jupyterlab
    volumes:
      - /tmp/.X11-unix:/tmp/.X11-unix  # sync host clipboard
    environment:
      - DISPLAY  # sync host clipboard
    hostname: laptop-docker
    container_name: terminal-ide-container
    stdin_open: true
    tty: true
    runtime: "nvidia"
    network_mode: "bridge"
```

1. Build the docker image `terminal-ide` with tag same as your username
```commandline
docker-compose build
```

3. Run the container and attach to it
```commandline
docker-compose up -d terminal-ide-service
docker attach terminal-ide-containerr
```
Note: `-d` is needed to connect interactively to the container

4. Run `. /ide_start.sh` to start the IDE (pre-defined tmux template).

### Custom IDEs
- Edit `line:33-34` in `./.Dockerfile` to change the python versions 
- You can use this as base to build other docker images.
