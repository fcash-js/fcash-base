# setup a centos image with fcore binary components
FROM centos:latest
MAINTAINER Chris Kleeschulte <chrisk@fcash.cash>
RUN yum -y install git curl which xz tar findutils
RUN groupadd fcore
RUN useradd fcore -m -s /bin/bash -g fcore
ENV HOME /home/fcore
USER fcore
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
RUN /bin/bash -l -c "nvm install v4 && nvm alias default v4"
RUN /bin/bash -l -c "npm install fcore -g"

