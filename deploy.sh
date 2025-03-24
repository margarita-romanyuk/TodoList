#!/usr/bin/env bash

# Stop any container based on the image
CURRENT_INSTANCE=$(sudo docker ps -a -q --filter ancestor="$IMAGE_NAME" --format="{{.ID}}")
if [ "$CURRENT_INSTANCE" ]
then
  sudo docker rm $(sudo docker stop $CURRENT_INSTANCE)
fi

# Pull the latest image
sudo docker pull $IMAGE_NAME

CONTAINER_EXISTS=$(sudo docker ps -a | grep $CONTAINER_NAME)
if ["$CONTAINER_EXISTS"]
then
    sudo docker rm $CONTAINER_NAME
fi

sudo docker run -p 3000:3000 -d --name $CONTAINER_NAME $IMAGE_NAME