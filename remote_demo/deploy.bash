#!/bin/bash
ROBOT_ID=hsrb
REMOTE_ID=remote
docker stack deploy -c docker-compse.yml remote_demo
