FROM osrf/ros2:r2b3-ros1-bridge

# install ros2 packages
RUN apt-get update && apt-get install -y \
    ros-r2b3-*-msgs \
    && rm -rf /var/lib/apt/lists/*

# setup entrypoint
COPY ./ros2_entrypoint.sh /

ENTRYPOINT ["/ros2_entrypoint.sh"]
CMD ["bash"]
