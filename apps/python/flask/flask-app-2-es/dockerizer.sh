#!/bin/bash

box_text() {
  local text="$1"
  local color="${2:-32}" # Default to green if no color is specified
  local padding=40

  # Calculate text length and total width of the box
  local text_length=${#text}
  local box_width=$((text_length + padding * 2))

  # Top border
  echo -e "\033[${color}m$(printf '%*s' "$box_width" '' | tr ' ' '*')\033[0m"

  # Text with padding
  echo -e "\033[${color}m$(printf '%*s' "$padding" '')$text$(printf '%*s' "$padding" '')\033[0m"

  # Bottom border
  echo -e "\033[${color}m$(printf '%*s' "$box_width" '' | tr ' ' '*')\033[0m"
}


# TAG_1="1"
# TAG_2="1"
# TAG_3="5"

# TAG="$TAG_1.$TAG_2.$TAG_3"

# REGISTRY=ahmedalimsolimansd
# IMAGE_NAME=aams-flask-app-2


# command="docker build --platform linux/amd64 -t $IMAGE_NAME:$TAG ."
# box_text "BUILDING using [$command]"
# $command

# command="docker tag $IMAGE_NAME:$TAG $REGISTRY/$IMAGE_NAME:$TAG"
# box_text "TAGGING using [$command]"
# $command

# command="docker push $REGISTRY/$IMAGE_NAME:$TAG"
# box_text "PUSHING using [$command]"
# $command


TAG_1="1"
TAG_2="1"
TAG_3="5"

TAG="$TAG_1.$TAG_2.$TAG_3"

# REGISTRY=localhost:5000
REGISTRY=10.10.25.207:5000
IMAGE_NAME=flask2


command="docker build --platform linux/amd64 -t $IMAGE_NAME:$TAG ."
box_text "BUILDING using [$command]"
$command

command="docker tag $IMAGE_NAME:$TAG $REGISTRY/$IMAGE_NAME:$TAG"
box_text "TAGGING using [$command]"
$command

command="docker push $REGISTRY/$IMAGE_NAME:$TAG"
box_text "PUSHING using [$command]"
$command

