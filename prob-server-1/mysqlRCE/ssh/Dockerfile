FROM ubuntu:22.04

RUN apt-get update && \
apt-get install -y openssh-server mysql-client && \
    useradd -m vulunch && \
    echo 'vulunch:vulunch' | chpasswd && \
    mkdir /var/run/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
