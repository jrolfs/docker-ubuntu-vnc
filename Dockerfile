FROM ubuntu:focal

ENV DEBIAN_FRONTEND noninteractive
ENV TZ 'America/Los_Angeles'

RUN apt-get update && echo $TZ > /etc/timezone && \
    apt-get update && apt-get install -y tzdata && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install -y openssh-server xfce4 xfce4-goodies x11vnc sudo bash xvfb && \
    useradd -ms /bin/bash ubuntu && echo 'ubuntu:ubuntu' | chpasswd && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && apt-get clean

USER ubuntu
WORKDIR /home/ubuntu

COPY x11vnc-1 /etc/init.d/
COPY x11vnc-2 /etc/init.d/
COPY xvfb-1 /etc/init.d/
COPY xvfb-2 /etc/init.d/

COPY mini-vmac /home/ubuntu/
COPY vMac.ROM /home/ubuntu/
COPY disk1.dsk /home/ubuntu/
COPY disk2.dsk /home/ubuntu/

COPY entry.sh /

COPY start.sh /

RUN mkdir -vp /home/ubuntu/.vnc > /dev/null 2>&1
RUN x11vnc -storepasswd ubuntu /home/ubuntu/.vnc/passwd > /dev/null 2>&1

RUN sudo chmod +x /entry.sh /start.sh /etc/init.d/* /home/ubuntu/mini-vmac

EXPOSE 22 59000-59100
