#!/bin/bash

# WS=${HOME}/ws/docker/ros
# mkdir -p ${WS}
#
# IMAGE="osrf/ros:indigo-desktop-full"

USER_UID=$(id -u)
USER_GID=$(id -g)

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth

# do we need to use sudo to start docker containers?
( id -Gn | grep -q docker ) || SUDO=sudo

# do we need nvidia-docker to use graphical acceleration?
if nvidia_version=$(cat /proc/driver/nvidia/version | head -n 1 | awk '{ print $8 }'); then
    DOCKER_CLI="nvidia-docker"
else
    DOCKER_CLI="docker"
fi

prepare_docker_user_parameters() {
  USER_SET=" --user=${USER_UID}:${USER_GID}"
}

prepare_docker_env_parameters() {
  ENV_VARS+=""
  ENV_VARS+=" --env=USER_UID=${USER_UID}"
  ENV_VARS+=" --env=USER_GID=${USER_GID}"
  ENV_VARS+=" --env=DISPLAY"
  ENV_VARS+=" --env=XAUTHORITY=${XAUTH}"
  ENV_VARS+=" --env=TZ=$(date +%Z)"
  ENV_VARS+=" --env=QT_X11_NO_MITSHM=1"
  ENV_VARS+=" --env=LANG=C.UTF-8"
  ENV_VARS+=" --env=LC_ALL=C"
}

prepare_docker_volume_parameters() {
  touch ${XAUTH}
  xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f ${XAUTH} nmerge -

  VOLUMES+=""
  VOLUMES+=" --volume=${WS}:${HOME}"
  VOLUMES+=" --volume=${XSOCK}:${XSOCK}"
  VOLUMES+=" --volume=${XAUTH}:${XAUTH}"
  VOLUMES+=" --volume=/run/user/${USER_UID}/pulse:/run/pulse"
  VOLUMES+=" --volume=/etc/group:/etc/group:ro"
  VOLUMES+=" --volume=/etc/passwd:/etc/passwd:ro"
  VOLUMES+=" --volume=/etc/shadow:/etc/shadow:ro"
  VOLUMES+=" --volume=/etc/sudoers.d:/etc/sudoers.d:ro"
}

prepare_docker_device_parameters() {
  VIDEO_DEVICES+=""
  # enumerate video devices for webcam support
  # VIDEO_DEVICES=
  # for device in /dev/video*
  # do
  #   if [ -c $device ]; then
  #     VIDEO_DEVICES="${VIDEO_DEVICES} --device $device:$device"
  #   fi
  # done
  VIDEO_DEVICES+=" --privileged"
}

prepare_docker_network_parameters() {
  NETWORKS+=""
  NETWORKS+=" --net=host"
}

prepare_docker_miscellaneous_parameters() {
  MISCELLANEOUS+=""
  MISCELLANEOUS+=" --interactive"
  MISCELLANEOUS+=" --tty"
  MISCELLANEOUS+=" --workdir=${HOME}"
}

prepare_docker_user_parameters
prepare_docker_env_parameters
prepare_docker_volume_parameters
prepare_docker_device_parameters
prepare_docker_network_parameters
prepare_docker_miscellaneous_parameters

echo "Starting ${prog}..."
${SUDO} ${DOCKER_CLI} run \
  ${MISCELLANEOUS} \
  ${USER_SET} \
  ${ENV_VARS} \
  ${VIDEO_DEVICES} \
  ${VOLUMES} \
  ${NETWORKS} \
  ${IMAGE} $@
