FROM centos:latest

## Install Pre Reqs
RUN yum -y update && \
    yum install -y unzip wget curl vi gcc openssl-devel bzip2-devel libffi-devel make which bash

## Install Python   
#RUN cd /usr/src && \
#    wget https://www.python.org/ftp/python/2.7.16/Python-2.7.16.tgz && \
#    tar xzf Python-2.7.16.tgz && \
#    cd Python-2.7.16 && \
#    ./configure --enable-optimizations && \
#    make altinstall && \
#    ln -s /usr/local/bin/python2.7 /usr/bin/python

RUN cd /usr/src && \
    wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz && \
    tar xzf Python-3.7.4.tgz && \
    cd Python-3.7.4 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    ln -s /usr/local/bin/python3.7 /usr/bin/python

## Install AWS CLI
RUN cd ~ && \
    curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
    unzip awscli-bundle.zip && \
    ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

## Install PIP
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && \
    python get-pip.py

## Install aws-adfs
RUN cd ~ && \
    pip install virtualenv && \
    virtualenv aws-adfs && \
    cd aws-adfs && \
    source bin/activate && \
    pip install aws-adfs


## Add Bash Aliases=profile
RUN echo "alias pyv='python --version'" >> /root/.bashrc
RUN echo "alias awsv='aws --version'" >> /root/.bashrc
RUN echo "alias awsadfs='cd ~/aws-adfs; source bin/activate'" >> /root/.bashrc
#RUN ["/bin/bash", "-c", "source /root/.bash_profile"]


RUN touch /root/.bashrc