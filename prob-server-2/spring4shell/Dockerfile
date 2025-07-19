#################### 🔧 Build Stage ####################
FROM gradle:jdk17 AS builder
WORKDIR /app

# ── Gradle 설정 복사 ────────────────────────────────
COPY build.gradle settings.gradle ./
COPY gradle ./gradle
COPY gradlew* ./
# ── 소스 복사 ───────────────────────────────────────
COPY src ./src

# ── CRLF 제거 & 빌드 ────────────────────────────────
RUN chmod +x ./gradlew && \
    apt-get update && apt-get install -y dos2unix && \
    dos2unix ./gradlew || sed -i 's/\r$//' ./gradlew && \
    ./gradlew clean war --no-daemon -x test

#################### 🚀 Run Stage ####################
FROM tomcat:9.0.53-jdk17-openjdk
ENV TZ=Asia/Seoul

# 1️⃣ 유틸리티 설치
RUN apt-get update && \
    apt-get install -y curl wget netcat python3 bash && \
    rm -rf /var/lib/apt/lists/*   # 이미지 경량화

# 2️⃣ WAR 배포
RUN rm -rf $CATALINA_HOME/webapps/*
COPY --from=builder /app/build/libs/*.war $CATALINA_HOME/webapps/ROOT.war

# 3️⃣ 플래그 파일
COPY flag.txt /flag.txt

EXPOSE 8080
CMD ["catalina.sh", "run"]
