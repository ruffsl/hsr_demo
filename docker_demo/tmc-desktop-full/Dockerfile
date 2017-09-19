FROM osrf/ros:indigo-desktop-full

# install https support for apt
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 1E138F7D9F6F9A40

# setup sources.list
RUN echo "deb https://<user>:<password>@packages.hsr.io/ros/ubuntu trusty main" > /etc/apt/sources.list.d/tmc.list
RUN echo "deb https://<user>:<password>@packages.hsr.io/tmc/ubuntu trusty multiverse main" >> /etc/apt/sources.list.d/tmc.list

# install tmc packages
RUN apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-tmc-desktop-full \
    && rm -rf /var/lib/apt/lists/*

# install dev packages
RUN apt-get update && apt-get install -y \
    bash-completion \
    byobu \
    fish \
    glances \
    htop \
    && rm -rf /var/lib/apt/lists/*

# setup entrypoint
COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]

# nvidia-docker hooks
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}
