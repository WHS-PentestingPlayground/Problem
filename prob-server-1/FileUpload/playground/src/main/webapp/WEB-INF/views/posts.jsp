<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>게시판</title>
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="mb-0">📋 게시판</h1>
        <a href="/logout" class="btn btn-danger">로그아웃</a>
    </div>

    <div class="card shadow rounded-4 border-0">
        <div class="card-body p-0">
            <table class="table table-hover align-middle text-center mb-0" style="border-radius: 1rem; overflow: hidden;">
                <thead class="table-primary">
                    <tr>
                        <th style="width: 60%; font-size:1.1rem;">제목</th>
                        <th style="width: 40%; font-size:1.1rem;">작성자</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="post" items="${posts}">
                    <tr style="transition: background 0.2s;">
                        <td class="text-start ps-4">
                            <a href="/board/post/${post.id}" class="text-decoration-none fw-bold text-primary" style="font-size:1.05rem;">
                                ${post.title}
                            </a>
                        </td>
                        <td class="text-secondary fw-semibold">${post.author}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 버튼 영역 -->
    <div class="mt-4 d-flex justify-content-between">
        <form action="/board/post" method="GET">
            <button type="submit" class="btn btn-primary rounded-pill px-4">✏️ 게시글 쓰기</button>
        </form>
    </div>
</div>
</body>
</html>
