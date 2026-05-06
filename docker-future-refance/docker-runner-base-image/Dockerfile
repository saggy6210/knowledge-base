FROM centos

# install java
RUN yum update -y
RUN yum install -y \
       git \
       java-1.8.0-openjdk-devel \
    && yum clean all

# set env variables
ENV JAVA_HOME /etc/alternatives/jre/

# Adding AZ-CLI
RUN yum check-update; yum install -y gcc libffi-devel python-devel openssl-devel
RUN curl "https://bootstrap.pypa.io/get-pip.py" | python
RUN pip install --pre azure-cli

# Terraform
RUN yum update -y
RUN yum install -y \
	unzip\
	wget
#RUN yum install unzip
RUN wget https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip
RUN unzip terraform_0.11.8_linux_amd64.zip
RUN mv terraform /usr/local/bin/
#COPY terraform /usr/local/bin/

## SSH Key
RUN mkdir /root/.ssh
COPY id_rsa.pub  /root/.ssh
COPY id_rsa  /root/.ssh
COPY known_hosts /root/.ssh

