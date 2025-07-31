# PentestingPlayground PROBLEM

This repository contains a collection of CTF problems.  
Below is the list of problems with their categories, titles (linked to the problem path), and contributors.

| Category       | Problem Title                                                                                                                                                 | Contributor                                                                                                                                                         |
|----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| File download vuln            | [Just Upload It](https://github.com/WHS-PentestingPlayground/Problem/tree/main/prob-server-1/FileUpload)                                             | [<img src="https://github.com/meowyeok.png" width="50" height="50" alt="meowyeok"><br><sub>meowyeok</sub>](https://github.com/meowyeok)              |
| File upload vuln   | [pathtraversal](https://github.com/WHS-PentestingPlayground/Problem/tree/main/prob-server-1/FileDownload)                                                       | [<img src="https://github.com/meowyeok.png" width="50" height="50" alt="meowyeok"><br><sub>meowyeok</sub>](https://github.com/meowyeok)                  |
| mysqlRCE   | [My Command, MySQL](https://github.com/WHS-PentestingPlayground/Problem/tree/main/prob-server-1/mysqlRCE)                                                                      | [<img src="https://github.com/meowyeok.png" width="50" height="50" alt="meowyeok"><br><sub>meowyeok</sub>](https://github.com/meowyeok)                      |
| JWT bypass   | [Who Signed It](https://github.com/WHS-PentestingPlayground/Problem/tree/main/prob-server-1/JwtAlgHs256)                                                                          | [<img src="https://github.com/yelin1197.png" width="50" height="50" alt="yelin1197"><br><sub>yelin1197</sub>](https://github.com/yelin1197)                  |
| SQL injection            | [Simple SQLi](https://github.com/WHS-PentestingPlayground/Problem/tree/main/prob-server-2/SQLi)                             | [<img src="https://github.com/MEspeaker.png" width="50" height="50" alt="MEspeaker"><br><sub>MEspeaker</sub>](https://github.com/MEspeaker)                      |
| SSTI            | [Say hello to me](https://github.com/WHS-PentestingPlayground/Problem/tree/main/prob-server-2/ssti)                                                                              | [<img src="https://github.com/MEspeaker.png" width="50" height="50" alt="MEspeaker"><br><sub>MEspeaker</sub>](https://github.com/MEspeaker)                  |
| Spring4shell     | [Shall We Melt the Spring?](https://github.com/WHS-PentestingPlayground/Problem/tree/main/prob-server-2/spring4shell)                                                                      | [<img src="https://github.com/namd0ng.png" width="50" height="50" alt="namd0ng"><br><sub>namd0ng</sub>](https://github.com/namd0ng)                              |
                                       
---

## 서버 설치 단계
1. 시스템 패키지 업데이트 및 Docker 설치:
    ```sh
    sudo apt update
    sudo apt install docker.io
    sudo systemctl enable --now docker
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.21.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    docker-compose --version
    ```

2. 프로젝트 클론:
    ```sh
    git clone https://github.com/WHS-PentestingPlayground/Problem.git
    ```
