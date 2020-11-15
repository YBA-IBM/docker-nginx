#!/bin/bash

set -e

export ANSI_YELLOW="\e[1;33m"
export ANSI_GREEN="\e[32m"
export ANSI_RESET="\e[0m"

echo -e "\n $ANSI_YELLOW *** FUNCTIONAL TEST(S) *** $ANSI_RESET \n"

echo -e "$ANSI_YELLOW Activate nginx with various functions described in description: $ANSI_RESET"
docker run --rm --name some-nginx -d quay.io/ibmz/docker-nginx:1.19.4
docker stop some-nginx
touch testcontent
docker build -t some-content-nginx .
docker run --rm --name some-nginx -d some-content-nginx
docker stop some-nginx
docker run --rm --name some-nginx -d -p 8080:80 some-content-nginx
docker stop some-nginx
docker build -t custom-nginx conf
docker run --rm --name my-custom-nginx-container -d custom-nginx


echo -e "\n $ANSI_GREEN *** FUNCTIONAL TEST(S) COMPLETED SUCESSFULLY *** $ANSI_RESET \n"
