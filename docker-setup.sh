#!/bin/bash
# docker-setup.sh - Install Docker and run hello-world

sudo apt update
sudo apt install docker.io -y
sudo systemctl start docker
sudo docker run hello-world
