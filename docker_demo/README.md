# Docker Demo
This simple demo shows the containerization a HSR simulation, to perhaps test ROS2 integration. By deploying a containerized ROS simulation locally onto the host platform via Docker, we also avoid the issue of whether the OS on the host supports the ROS release for the target robot platform or not.

## Setup

To get started, we'll assume host includes an up-to-date version of Docker and Docker Compose installed. Please make sure current releases are installed if otherwise.

* [Docker Engine](https://docs.docker.com/engine/installation/)
  * Simple: https://get.docker.com
* [Nvidia Docker](https://github.com/NVIDIA/nvidia-docker)
  * Optional for GPU acceleration

Next we can simply clone this repo onto the host, cd into this directory, and start the project build:

> building

```
make build
```

## Runtime

With images built, we can simply call a run script to configure the docker run command to pass though some helpful arguments simplify and expose the startup. You may like to peruse through the scrips to understand the setup.

> simulating

```
./run.bash roslaunch hsrb_gazebo_launch hsrb_megaweb2015_world.launch
```

You should now see a simulation windows for Gazebo and Rviz load onto the screen, where you may then un-pause time within Gazebo by pressing Play in the time-step control interface.
