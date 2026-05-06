##### An image is a lightweight, stand-alone, executable package that includes everything needed to run a piece of software, including the code, a runtime, libraries, environment variables, and config files.
##### A container is a runtime instance of an image
##### A docker-compose.yml file is a YAML file that defines how Docker containers should behave in production.
##### Multi-container, multi-machine applications are made possible by joining multiple machines into a “Dockerized” cluster called a swarm.

## Docker image with java git azurecli terrafrom and python installed

`docker pull sagar6210/base-java-git-azurecli-terraform-python`

> How to install Docker?

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04

## Docker proxy configuration

*Create http-proxy.conf and put the entry of http_proxy and no_proxy.
/etc/systemd/system/docker.service.d/http-proxy.conf

[Service]
Environment="HTTP_PROXY=http://proxy-ip:port/" "NO_PROXY=<HOST_IP>"

/etc/systemd/system/docker.service.d/https-proxy.conf
[Service]
Environment="HTTPS_PROXY=http://proxy-ip:port/"

## Basic Docker commands
> Get Docker version
`docker version`

> Get Docker information with number of images, Running container, CPU, memory, etc.
`docker info`

> List of Docker images
`docker images`

> To list all running and stopped containers
`docker ps -a`

> To list all running containers
`docker ps -a -f status=running`

> To list all running and stopped containers, showing only their container id
`docker ps -aq`

> To delete all containers
`docker rm $(docker ps -a -q)`

> To delete all images
`docker rmi $(docker images -q)`

> Show docker disk usage 
`docker system df -kh`

> Remove unused container, images, network
`docker system prune`

> To remove docker volume
`docker system prune -a --volumes`

> To build docker image
`docker build -t imagename:tag .`

> To run docker image
`docker run -t imagename:tag`

> To run docker image on port with deamon 
`docker run -d -p 4000:80 imagename:tag`

> To tag docker image
`docker tag imagename username/identified-image-name:tag`

> To stop docker container 
`docker container stop container_id`

> to push docker image to container hub
* first tag docker image and then push to docker hub
`docker login`
`docker tag image username/repository:tag`
`docker push username/repository:tag`

> To pull docker image from docker registry 
`docker pull username/dockerimage:tag`

## Docker build image
Create docker files with centos base image
Install java, git, azure-cli, python and terraform on that image

*If you are working behind proxy run docker image with argument. Use below command to run docker with arguments 
Run below command from where you kept dokcer file.

`docker build --build-arg no_proxy_ip=<NO_PROXY> --build-arg proxy_ip=<HTTP_PROXY_IP> -t localhost:5000/azure-java:1.5 .`

Here, <NO_PROXY> is ip address of your machine and <HTTP_PROXY_IP> is ip address of your proxy server.
