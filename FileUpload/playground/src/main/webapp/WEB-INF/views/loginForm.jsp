<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 페이지</title>
</head>
<body>
<div class="container mt-5">
    <h1 class="mb-4">로그인 페이지</h1>

    <form action="/login" method="post" class="bg-light p-4 rounded shadow-sm">
        <div class="mb-3">
            <label for="username" class="form-label">아이디</label>
            <input type="text" id="username" name="username" class="form-control" placeholder="Username" required />
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="Password" required />
        </div>

        <button type="submit" class="btn btn-primary w-100">로그인</button>
    </form>

    <div class="text-center mt-3">
        <a href="/joinForm" class="text-decoration-none">회원가입을 아직 하지 않으셨나요?</a>
    </div>
</div>
</body>
</html>
