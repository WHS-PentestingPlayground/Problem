<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입 페이지</title>
</head>
<body>
<div class="container mt-5">
    <h1 class="mb-4">회원가입 페이지</h1>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="/join" method="post" class="bg-light p-4 rounded shadow-sm">
        <div class="mb-3">
            <label for="username" class="form-label">아이디</label>
            <input type="text" id="username" name="username" class="form-control" placeholder="Username" required />
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="Password" required />
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">이메일</label>
            <input type="email" id="email" name="email" class="form-control" placeholder="Email" required />
        </div>

        <button type="submit" class="btn btn-primary w-100">회원가입 완료</button>
    </form>
</div>
</body>
</html>
