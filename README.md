# Terminal based IDE

## Description
This project contains the code necessary to build the docker image of linux terminal based IDE. It is built on [NeoVim](https://github.com/neovim/neovim), [Tmux](https://github.com/tmux/tmux) and inlcudes most popular plugins. It supports GUI based matplotlib visualization using [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/index.html). This can be a preferable python IDE for developing deep learning models. The autobuilt docker image is available [here](https://hub.docker.com/r/karthi0804/terminal-ide).

## Getting Started

### Dependencies
- docker (verified with 20.10.6)
- docker-compose (verified in 1.29.2)

### Running the IDE

1. Build & Run the required docker image by specifying any service like `terminal-ide-18-py3.7-service` mentioned in the docker-compose-file.
```commandline
docker-compose up -d terminal-ide-18-py3.7-service
```
Note: `-d` is needed to connect interactively to the container

2. Attach to the running container 
```commandline
docker attach terminal-ide-18-py3.7-containerr
```

3. Run `. /ide_start.sh` to start the terminal based IDE (pre-defined tmux template).
4. To start jupyter lab server (useful for visualization), 
```commandline
jupyter lab --ip 0.0.0.0 --port 8899 --allow-root
```


### Custom IDEs
You can add your own service to satisfy your requirements.

1.  Edit the existing docker-compose.yml file at the project root folder by following the below format with the required inputs 
```dockerfile
version: "3.9"
services:
.
.
.
  terminal-ide-service: # change as you wish
    image: terminal-ide:yourversion # change as you wish
    build:
      context: .
      dockerfile: Dockerfile
      args:
        - baseimage=baseimage  # any image from dockerhub/local registry
        - uid=1000  # uid of the host
        - pythonversion=python3.x  # change as you wish (but python 2.x requires changes int he Docker file also)
        - user=${USER}  # change as you wish
    ports:
      - 8899:8899  # jupyterlab
    volumes:
      - /tmp/.X11-unix:/tmp/.X11-unix  # sync host clipboard
    environment:
      - DISPLAY  # sync host clipboard
    hostname: laptop-docker  # change it as you wish
    container_name: terminal-ide-container # change it as you wish
    stdin_open: true
    tty: true
    runtime: "nvidia" # needed only if you need CUDA support inside docker
    network_mode: "bridge"
```
