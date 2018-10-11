# setup a centos image with fcash-base binary components
FROM centos:latest
MAINTAINER Chris Kleeschulte <chrisk@fcash.cash>
RUN yum -y install git curl which xz tar findutils
RUN groupadd fcash-base
RUN useradd fcash-base -m -s /bin/bash -g fcash-base
ENV HOME /home/fcash-base
USER fcash-base
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
RUN /bin/bash -l -c "nvm install v4 && nvm alias default v4"
RUN /bin/bash -l -c "npm install fcash-base -g"

