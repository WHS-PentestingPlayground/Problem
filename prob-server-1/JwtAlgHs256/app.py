from flask import Flask, request, jsonify, render_template_string
import jwt
import mysql.connector
from functools import wraps
import os
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import rsa
from cryptography.hazmat.backends import default_backend
import json

app = Flask(__name__)
app.secret_key = 'super_secret_key_for_jwt'

# RSA 키 생성
def generate_rsa_keys():
    private_key = rsa.generate_private_key(
        public_exponent=65537,
        key_size=2048,
        backend=default_backend()
    )
    public_key = private_key.public_key()
    
    # PEM 형식으로 변환
    private_pem = private_key.private_bytes(
        encoding=serialization.Encoding.PEM,
        format=serialization.PrivateFormat.PKCS8,
        encryption_algorithm=serialization.NoEncryption()
    )
    
    public_pem = public_key.public_bytes(
        encoding=serialization.Encoding.PEM,
        format=serialization.PublicFormat.SubjectPublicKeyInfo
    )
    
    return private_pem, public_pem

# RSA 키 생성
private_key_pem, public_key_pem = generate_rsa_keys()
private_key = serialization.load_pem_private_key(private_key_pem, password=None, backend=default_backend())
public_key = serialization.load_pem_public_key(public_key_pem, backend=default_backend())

# MySQL 연결 설정
db_config = {
    'host': 'prob3-mysql',  # Docker 서비스 이름 사용
    'user': 'root',
    'password': 'password',
    'database': 'jwt_ctf'
}

def get_db_connection():
    return mysql.connector.connect(**db_config)

def init_db():
    conn = get_db_connection()
    cursor = conn.cursor()
    
    # users 테이블 생성
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS users (
            id INT AUTO_INCREMENT PRIMARY KEY,
            username VARCHAR(50) UNIQUE NOT NULL,
            password VARCHAR(100) NOT NULL,
            role VARCHAR(20) DEFAULT 'user'
        )
    ''')
    
    # admin 계정이 없으면 생성
    cursor.execute("SELECT * FROM users WHERE username = 'admin'")
    if not cursor.fetchone():
        cursor.execute("INSERT INTO users (username, password, role) VALUES ('admin', 'A3Min0712!', 'admin')")
    
    # 일반 사용자 계정이 없으면 생성
    cursor.execute("SELECT * FROM users WHERE username = 'user'")
    if not cursor.fetchone():
        cursor.execute("INSERT INTO users (username, password, role) VALUES ('user', 'user123', 'user')")
    
    conn.commit()
    cursor.close()
    conn.close()

def verify_jwt(token):
    try:
        header = jwt.get_unverified_header(token)
        algorithm = header.get('alg', 'RS256')

        if algorithm == 'HS256':

            from cryptography.hazmat.primitives.asymmetric import rsa
            import base64

            public_numbers = public_key.public_numbers()
            n_bytes = public_numbers.n.to_bytes((public_numbers.n.bit_length() + 7) // 8, 'big')
            hmac_key = n_bytes  # 공개키를 대칭키처럼 사용

            payload = jwt.decode(token, hmac_key, algorithms=['HS256'])  # 🔥 취약점
        elif algorithm == 'RS256':
            payload = jwt.decode(token, key=public_key, algorithms=["RS256"])
        else:
            return None

        return payload
    except jwt.InvalidTokenError:
        return None


def require_auth(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        token = request.cookies.get('token')
        if not token:
            return jsonify({'error': '토큰이 필요합니다'}), 401
        
        payload = verify_jwt(token)
        if not payload:
            return jsonify({'error': '유효하지 않은 토큰입니다'}), 401
        
        request.user = payload
        return f(*args, **kwargs)
    return decorated_function

@app.route('/')
def index():
    html = '''
    <!DOCTYPE html>
    <html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>JWT CTF Challenge</title>
        <style>
            body {
                background-color: #1e1e1e;
                color: #ffffff;
                font-family: 'Segoe UI', sans-serif;
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 50px 20px;
            }

            h1 {
                font-size: 2.5em;
                color: #00ff88;
                margin-bottom: 20px;
            }

            .container {
                background-color: #2b2b2b;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 0 20px rgba(0, 255, 136, 0.3);
                width: 100%;
                max-width: 400px;
                margin-top: 50px;
            }

            input {
                width: 100%;
                padding: 12px;
                margin: 10px 0;
                border: none;
                border-radius: 8px;
                font-size: 1em;
                box-sizing: border-box;
            }

            button {
                width: 100%;
                padding: 12px;
                margin-top: 10px;
                font-size: 1em;
                background-color: #00ff88;
                color: #1e1e1e;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.2s;
            }

            button:hover {
                background-color: #00cc6e;
            }

            #adminBtn {
                display: none;
                margin-top: 20px;
                background-color: #ffc107;
                color: #000;
            }

            #user-header {
                margin-top: 30px;
                font-size: 1.1em;
                color: #ccc;
            }
        </style>
    </head>
    <body>

        <h1>🔐 JWT CTF Challenge</h1>

        <div id="user-header">관리자 권한을 획득하세요.</div>

        <div class="container">
            <h2>🔑 로그인</h2>
            <input type="text" id="username" placeholder="사용자명" value="user">
            <input type="password" id="password" placeholder="비밀번호" value="user123">
            <button onclick="login()">로그인</button>
            <button id="adminBtn" onclick="checkAdmin()">🔓 관리자 페이지로 이동</button>
        </div>

        <script>
            function login() {
                const username = document.getElementById('username').value;
                const password = document.getElementById('password').value;

                fetch('/login', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({username, password})
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        document.getElementById('user-header').innerHTML =
                            `안녕하세요 <strong>${username}</strong>님!`;
                        document.getElementById('adminBtn').style.display = 'block';
                        alert('로그인 성공!');
                    } else {
                        alert('로그인 실패: ' + data.error);
                    }
                });
            }

            function checkAdmin() {
                window.location.href = '/admin';  // HTML 페이지로 이동
            }
        </script>

    </body>
    </html>

    '''
    return html

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')
    
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    cursor.execute("SELECT * FROM users WHERE username = %s AND password = %s", (username, password))
    user = cursor.fetchone()
    
    cursor.close()
    conn.close()
    
    if user:
        # JWT 토큰 생성 (RS256 알고리즘 사용)
        payload = {
            'user_id': user['id'],
            'username': user['username'],
            'role': user['role']
        }
        token = jwt.encode(payload, private_key, algorithm='RS256')
        
        response = jsonify({
            'success': True,
            'token': token,
            'message': '로그인 성공'
        })
        response.set_cookie('token', token)
        return response
    else:
        return jsonify({
            'success': False,
            'error': '잘못된 사용자명 또는 비밀번호'
        }), 401

@app.route('/.well-known/jwks.json')
def jwks():
    # JWKS (JSON Web Key Set) 엔드포인트
    # 공개키를 JWK 형식으로 반환
    from cryptography.hazmat.primitives.asymmetric.rsa import RSAPublicNumbers
    from cryptography.hazmat.primitives import hashes
    import base64
    
    # 공개키에서 n, e 추출
    public_numbers = public_key.public_numbers()
    
    # n과 e를 base64url 인코딩
    n_bytes = public_numbers.n.to_bytes((public_numbers.n.bit_length() + 7) // 8, 'big')
    e_bytes = public_numbers.e.to_bytes((public_numbers.e.bit_length() + 7) // 8, 'big')
    
    n_b64 = base64.urlsafe_b64encode(n_bytes).decode('utf-8').rstrip('=')
    e_b64 = base64.urlsafe_b64encode(e_bytes).decode('utf-8').rstrip('=')
    
    jwks = {
        "keys": [
            {
                "kty": "RSA",
                "use": "sig",
                "alg": "RS256",
                "kid": "jwt-ctf-key",
                "n": n_b64,
                "e": e_b64
            }
        ]
    }
    
    return jsonify(jwks)


@app.route('/admin')
@require_auth
def admin():
    if request.user.get('role') == 'admin':
        html = '''
        <!DOCTYPE html>
        <html lang="ko">
        <head>
            <meta charset="UTF-8">
            <title>FLAG 획득!</title>
            <style>
                body {
                    background-color: #1e1e1e;
                    color: #00ff88;
                    font-family: 'Courier New', monospace;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                    margin: 0;
                }

                .flag-box {
                    border: 2px dashed #00ff88;
                    padding: 30px 40px;
                    font-size: 28px;
                    background-color: #2b2b2b;
                    border-radius: 12px;
                    box-shadow: 0 0 15px rgba(0, 255, 136, 0.3);
                    animation: glow 1.5s infinite alternate;
                }

                @keyframes glow {
                    from { box-shadow: 0 0 10px #00ff88; }
                    to { box-shadow: 0 0 25px #00ff88; }
                }
            </style>
        </head>
        <body>
            <div class="flag-box">
                VUL{JwtAlgHs256_problem_is_solved_gooooooood}
            </div>
        </body>
        </html>

        '''
        return render_template_string(html)
    else:
        return render_template_string("<h1>403 Forbidden</h1><p>Admin 권한이 필요합니다.</p>"), 403


if __name__ == '__main__':
    init_db()
    app.run(host='0.0.0.0', port=5000, debug=False) 