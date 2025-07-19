
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>에러 발생</title>
    <link rel="stylesheet" href="/static/css/error.css">
    <style>
    @import url('https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css');

body {
  background: #fff;
  font-family: 'Pretendard', 'sans-serif';
}

.error-container {
    text-align: center;
    margin-top: 100px;
    font-family: 'Arial', sans-serif;
}

.error-title {
    font-size: 32px;
    font-weight: bold;
    color: #e74c3c;
    margin-bottom: 20px;
}

.error-message {
    font-size: 24px;
    color: #2c3e50;
    margin-bottom: 30px;
}

.error-code {
    font-size: 72px;
    color: #e74c3c;
    margin-bottom: 20px;
}

.error-details {
    margin: 20px 0;
    padding: 15px;
    background-color: #f8f9fa;
    border-radius: 5px;
    font-size: 16px;
    color: #666;
}

.back-button {
    padding: 10px 20px;
    background-color: #3498db;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    text-decoration: none;
    font-size: 16px;
}

.back-button:hover {
    background-color: #2980b9;
} 
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-code">
            <c:out value="${statusCode}" default="500"/>
        </div>
        <div class="error-message">
            <c:out value="${errorMessage}" default="예기치 않은 오류가 발생했습니다."/>
        </div>
        <c:if test="${not empty exception}">
            <div class="error-details">
                <p>상세 오류: <c:out value="${exception.message}"/></p>
                <c:if test="${not empty exception.cause}">
                    <p>원인: <c:out value="${exception.cause.message}"/></p>
                </c:if>
            </div>
        </c:if>
        <a href="/" class="back-button">홈으로 돌아가기</a>
    </div>
</body>
</html>