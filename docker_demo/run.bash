#!/bin/bash

WS=${HOME}/ws/tmc/hsr
mkdir -p ${WS}

IMAGE="tmc/ros:indigo-tmc-desktop-full"

source ros-gui-docker.bash $@ 
