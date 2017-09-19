# Remote Demo
This simple demo shows the teleoperation a ROS1 enabled robot with ROS2 enabled remote. By deploying a containerized ros1-bridge locally onto the robot platform via Docker, we also avoid the issue of whether the legacy OS on the target robot platform supports ROS2 installation or not.

## Setup

To get started, we'll assume both the robot and remote host include an up-to-date version of Docker and Docker Compose installed. Please make sure current releases are installed if otherwise.

* [Docker Engine](https://docs.docker.com/engine/installation/)
  * Simple: https://get.docker.com
* [Docker Compose](https://docs.docker.com/compose/install/)

Next we can simply clone this repo onto both targets, and cd into this directory.

## Runtime

With both networked robot and remote host inter-reachable, we can simply call docker-compose on each target with their respective compose files. Note that you will need ROS1's roscore setup and running on the robot beforehand, an a `/dev/input/js0` joystick device plugged into the remote host as well before starting.

> robot

```
docker-compose -f robot-docker-compose.yml up
```

> remote host

```
docker-compose -f remote-docker-compose.yml up
```

If all is well, you should now be able to subscribe to the `/joy` topic from within the existing ROS1 ecosystem inside the robot, while transition of any remote teleop commands can benefit from the QOS advantages in ROS2.
