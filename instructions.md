# Setting up a new pipeline server
To setup a new server we first need some prerequisites installed.
## Prerequisites
1. A ubuntu server or debian based server installed
2. The server has to be an x86-64 bit computer.
## Installation
First install docker by using snap ``sudo snap install docker``. After that install gitlab runner by downloading the package using ``curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb"`` and then install using the command ``dpkg -i gitlab-runner_amd64.deb``. Lastly for the pipeline to run, the gitlab runner needs to be registered using: 
``sudo gitlab-runner register -n \
  --url https://git-teaching.cs.bham.ac.uk \
  --registration-token REGISTRATION_TOKEN \
  --executor docker \
  --description "Docker Runner" \
  --docker-image "docker:19.03.12" \
  --docker-privileged \
  --docker-volumes "/certs/client" \
  --tag-list "ai, django, docker, flutter, test"``

After registration the pipeline should run and deploy to the server with the ip specified in the variable SERVER_IP with the key SERVER_PRIVATE_KEY and using a private dockerhub repo specified in the variable DOCKER_ACCESS_TOKEN.
