<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | WH 주유소  Internal System</title>
    <style>
        @import url('https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css');

        :root {
            --primary-blue: #00529B;
            --secondary-yellow: #FFD500;
            --background-light: #f0f4f8;
            --text-dark: #1d2d3d;
            --text-light: #5a6a7b;
            --border-color: #dbe2eb;
            --white: #ffffff;
            --shadow-color: rgba(0, 82, 155, 0.1);
        }

        body {
            font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background-color: var(--background-light);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            color: var(--text-dark);
        }

        .login-wrapper {
            background-color: var(--white);
            padding: 50px;
            border-radius: 16px;
            box-shadow: 0 10px 30px var(--shadow-color);
            width: 100%;
            max-width: 440px;
            text-align: center;
            border-top: 5px solid var(--primary-blue);
        }

        .main-title {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .subtitle {
            font-size: 1rem;
            color: var(--text-light);
            margin-bottom: 40px;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            font-size: 0.9rem;
            font-weight: 500;
            margin-bottom: 8px;
            color: var(--text-light);
        }

        .form-group input {
            width: 100%;
            padding: 14px 16px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 1rem;
            box-sizing: border-box;
            transition: all 0.2s ease-in-out;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 3px rgba(0, 82, 155, 0.15);
        }

        .submit-btn {
            width: 100%;
            background: linear-gradient(135deg, var(--primary-blue), #006acb);
            color: var(--white);
            border: none;
            padding: 15px;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            margin-top: 15px;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 82, 155, 0.25);
        }
    </style>
</head>
<body>
    <div class="login-wrapper">
        <h1 class="main-title">🐚 WH 주유소</h1>
        <p class="subtitle">내부 관리 시스템</p>
        
        <!-- 
          // TODO: 최과장님, Spring Boot 2.6.5로 올리고 나서 인트라넷 폼 데이터 바인딩이
          //       가끔 실패합니다. 템플릿 처리 문제 같은데, 확인 좀 부탁드려요.
          //       일단 임시로 폼 action은 그대로 두었습니다.
        -->
        <form action="/login" method="post">
            <div class="form-group">
                <label for="username">사원번호</label>
                <input type="text" id="username" name="username" required autocomplete="off">
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required autocomplete="off">
            </div>
            <button type="submit" class="submit-btn">로그인</button>
        </form>
    </div>
</body>
</html>
