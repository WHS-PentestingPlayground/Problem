# Python 베이스 이미지 사용
FROM python:3.10-slim

# 작업 디렉토리 생성 및 이동
WORKDIR /app

# 필요한 파일 복사
COPY app.py ./
COPY downloads ./downloads
COPY flag.txt ./flag.txt

# Flask 설치
RUN pip install flask

# 5000 포트 오픈
EXPOSE 5000

# Flask 앱 실행
CMD ["python", "app.py"] 