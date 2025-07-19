FROM ubuntu:22.04

RUN apt-get update && \
apt-get install -y openssh-server mysql-client && \
    useradd -m vulunch && \
    echo 'vulunch:vulunch' | chpasswd && \
    mkdir /var/run/sshd

# DB 연결 정보를 vulunch 사용자의 홈 폴더에 파일로 저장 (환경변수 사용)
RUN echo 'MYSQL_HOST=prob4-mysql' > /home/vulunch/db_info.txt && \
    echo 'MYSQL_PORT=3306' >> /home/vulunch/db_info.txt && \
    echo 'MYSQL_DATABASE=vulunchDB' >> /home/vulunch/db_info.txt && \
    echo 'MYSQL_USER=vulunch' >> /home/vulunch/db_info.txt && \
    echo 'MYSQL_PASSWORD=vulunch' >> /home/vulunch/db_info.txt && \
    chmod 644 /home/vulunch/db_info.txt

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
