FROM python:3.11-slim

WORKDIR /app

# 필수 파일 복사
COPY app.py flag.txt requirements.txt ./

# 패키지 설치
RUN pip install --no-cache-dir -r requirements.txt

# 포트 열기
EXPOSE 5000

# 실행
CMD ["python", "app.py"]
