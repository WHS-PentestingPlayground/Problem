#################### 🔧 Build Stage ####################
FROM gradle:jdk17 AS builder
WORKDIR /app

# ── Gradle 설정 복사 ────────────────────────────────
COPY build.gradle settings.gradle ./
COPY gradle ./gradle
COPY gradlew* ./
# ── 소스 복사 ───────────────────────────────────────
COPY src ./src
COPY src/main/webapp ./src/main/webapp

# ── CRLF 제거 & 빌드 ────────────────────────────────
RUN chmod +x ./gradlew && \
    apt-get update && apt-get install -y dos2unix && \
    dos2unix ./gradlew || sed -i 's/\r$//' ./gradlew && \
    ./gradlew clean war --no-daemon -x test

#################### 🚀 Run Stage (cron 포함) #########
FROM tomcat:9.0.53-jdk17-openjdk
ENV TZ=Asia/Seoul

# 1️⃣ 유틸리티 + cron 설치
RUN apt-get update && \
    apt-get install -y curl wget netcat python3 bash cron && \
    rm -rf /var/lib/apt/lists/*   # 이미지 경량화

# 2️⃣ 30분마다 webapps/ROOT/* 삭제하는 cron 등록
RUN echo '*/30 * * * * root rm -rf /usr/local/tomcat/webapps/ROOT/*' \
      > /etc/cron.d/cleanup && \
    chmod 0644 /etc/cron.d/cleanup && \
    crontab /etc/cron.d/cleanup          # root 크론에 등록

# 3️⃣ WAR 배포
RUN rm -rf $CATALINA_HOME/webapps/*
COPY --from=builder /app/build/libs/*.war $CATALINA_HOME/webapps/ROOT.war

# 4️⃣ (선택) 플래그 파일
COPY flag.txt /flag.txt

EXPOSE 8080
# 5️⃣ cron + Tomcat 동시 실행
CMD ["sh", "-c", "cron && catalina.sh run"]

