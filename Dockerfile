FROM jenkins/jenkins:lts

# switch to 'root' user => use 'sudo' command => install
USER root

RUN apt-get update && apt-get install -y apt-transport-https \
    ca-certificates curl gnupg2 \
    software-properties-common

# get key entering the DinD
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

# make 'apt' have stable CLI interface // Disable Warning....
RUN add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/debian \
     $(lsb_release -cs) stable"

# install docker community edition for 'docker' command usage
RUN apt-get update && apt-get install -y docker-ce-cli

# switch back to jenkins user
USER jenkins

# REF: https://www.tiuweehan.com/blog/2020-09-10-docker-in-jenkins-in-docker/
