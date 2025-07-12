# 🔐 JWT RS256/HS256 Algorithm Confusion CTF

JWT 토큰의 알고리즘을 RS256에서 HS256으로 변경하여 인증을 우회하는 CTF 문제입니다.

## 🎯 문제 목표

admin 계정으로 로그인하여 플래그를 획득하세요!

## 🚀 실행 방법

### Docker Compose 사용 (권장)

```bash
# 애플리케이션 실행
docker-compose up --build

# 브라우저에서 접속
http://localhost:5000
```

### 수동 실행

1. MySQL 서버 실행
2. Python 의존성 설치: `pip install -r requirements.txt`
3. Flask 애플리케이션 실행: `python app.py`

## 📋 문제 설명

이 웹사이트는 JWT 토큰을 사용하여 사용자 인증을 처리합니다.

### 초기 계정 정보
- **user**: user123 (일반 사용자)
- **admin**: admin123 (관리자)

### 취약점
서버는 RS256(비대칭키)으로 JWT 토큰을 생성하지만, 검증 시 JWT 헤더의 `alg` 필드를 신뢰합니다. 공격자가 헤더를 HS256으로 변경하고 대칭키로 서명을 생성하면 인증을 우회할 수 있습니다.

## 🎯 공격 방법

### 1단계: 일반 사용자로 로그인
- 사용자명: `user`, 비밀번호: `user123`으로 로그인
- JWT 토큰을 받습니다

### 2단계: JWT 토큰 분석
- "토큰 정보 보기" 버튼을 클릭하여 현재 토큰의 구조를 확인
- Header와 Payload를 분석

### 3단계: 알고리즘 혼동 공격
JWT 토큰을 다음과 같이 조작합니다:

1. **Header 수정**: `{"alg": "HS256", "typ": "JWT"}` (RS256에서 HS256으로 변경)
2. **Payload 수정**: `{"user_id": 1, "username": "admin", "role": "admin"}`
3. **Signature 생성**: 서버의 secret_key로 HMAC-SHA256 서명 생성

### 4단계: 조작된 토큰 적용
브라우저 개발자 도구에서 쿠키를 수정하거나, 다음과 같은 JavaScript를 실행:

```javascript
// HS256 알고리즘 우회 공격
const header = btoa(JSON.stringify({"alg": "HS256", "typ": "JWT"}));
const payload = btoa(JSON.stringify({"user_id": 1, "username": "admin", "role": "admin"}));
// 실제로는 서버의 secret_key로 HMAC-SHA256 서명을 생성해야 함
const signature = generateHMACSignature(header + "." + payload, secretKey);
const token = header + "." + payload + "." + signature;

// 쿠키 설정
document.cookie = "token=" + token;
```

### 5단계: Admin 권한 확인
"Admin 권한 확인" 버튼을 클릭하여 플래그를 획득!

## 🏆 플래그

성공하면 다음 플래그를 획득할 수 있습니다:
```
flag{JwtAlgHs256_problem_is_solved_gooooooood}
```

## 🔍 학습 포인트

1. **JWT 구조 이해**: Header, Payload, Signature의 역할
2. **알고리즘 혼동 공격**: RS256에서 HS256으로 변경하여 대칭키 검증으로 우회
3. **비대칭키 vs 대칭키**: RSA와 HMAC의 차이점 이해
4. **보안 취약점**: 서버 측 알고리즘 검증 부족

## 🛡️ 방어 방법

- 서버에서 JWT 헤더의 `alg` 필드를 신뢰하지 않기
- `algorithms` 파라미터를 명시적으로 설정하여 허용된 알고리즘만 사용
- 토큰 검증 시 알고리즘을 강제로 지정
- 공개키와 대칭키를 명확히 구분하여 사용

## 📝 참고 자료

- [JWT RFC 7519](https://tools.ietf.org/html/rfc7519)
- [JWT Security Best Practices](https://auth0.com/blog/a-look-at-the-latest-draft-for-jwt-bcp/) 