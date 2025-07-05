<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>회원가입</title></head>
<body>
<h2>회원가입</h2>
<form action="/register" method="post">
    사용자명: <input type="text" name="username"><br>
    비밀번호: <input type="password" name="password"><br>
    <input type="submit" value="가입">
</form>
<p>${message}</p>
<a href="/login">로그인</a>
</body>
</html>
