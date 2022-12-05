FROM ubuntu:kinetic

ENV DEBIAN_FRONTEND noninteractive
ENV TZ 'America/Los_Angeles'

RUN apt-get update && echo $TZ > /etc/timezone && \
    apt-get update && apt-get install -y tzdata && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install -y x11vnc sudo bash xvfb && \
    useradd -ms /bin/bash ubuntu && echo 'ubuntu:ubuntu' | chpasswd && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && apt-get clean

USER ubuntu
WORKDIR /home/ubuntu

COPY mini-vmac/ ./mini-vmac/
COPY start.sh .

RUN mkdir -vp /home/ubuntu/.vnc > /dev/null 2>&1
RUN x11vnc -storepasswd mini-vmac /home/ubuntu/.vnc/passwd > /dev/null 2>&1

RUN sudo chmod +x /home/ubuntu/start.sh \
    /home/ubuntu/mini-vmac/mini-vmac-1x \
    /home/ubuntu/mini-vmac/mini-vmac-2x \
    /home/ubuntu/mini-vmac/mini-vmac-4x

EXPOSE 59000-59999
