# JDK 17이 포함된 Tomcat 10 이미지 사용
FROM tomcat:10.0-jdk17

# 작업 디렉토리 설정
WORKDIR /app

# 소스 전체 복사
COPY . .

# gradlew에 실행 권한 부여 (리눅스 환경)
RUN chmod +x ./gradlew

# 빌드
RUN ./gradlew build -x test

# 빌드된 WAR 파일을 톰캣 webapps로 복사
RUN cp build/libs/app.war /usr/local/tomcat/webapps/ROOT.war

# 외부에 노출할 포트
EXPOSE 8080

# 톰캣 실행
CMD ["catalina.sh", "run"]