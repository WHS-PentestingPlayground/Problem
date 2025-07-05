<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>로그인</title></head>
<body>
<h2>로그인</h2>
<form action="/login" method="post">
    사용자명: <input type="text" name="username"><br>
    비밀번호: <input type="password" name="password"><br>
    <input type="submit" value="로그인">
</form>
<p>${message}</p>
<a href="/register">회원가입</a>
</body>
</html>
