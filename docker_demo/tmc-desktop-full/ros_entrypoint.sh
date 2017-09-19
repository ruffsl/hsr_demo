#!/bin/bash
set -e

# setup tmc ros environment
source "/opt/tmc/ros/$ROS_DISTRO/setup.bash"
exec "$@"
