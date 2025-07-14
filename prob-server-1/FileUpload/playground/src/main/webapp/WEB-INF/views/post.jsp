<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>게시글 상세</title>
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>

<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-body">
                    <!-- 제목 -->
                    <h2 class="card-title text-center mb-3">${post.title}</h2>
                    <!-- 작성자 -->
                    <div class="d-flex justify-content-end mb-2">
                        <span class="text-muted">작성자: <strong>${post.author}</strong></span>
                    </div>
                    <hr/>
                    <!-- 이미지 -->
                    <c:if test="${not empty post.filePath}">
                        <div class="mb-4 text-center">
                            <img src="${post.filePath}" alt="첨부 이미지" class="img-fluid rounded" style="max-width: 400px;">
                        </div>
                    </c:if>
                    <!-- 컨텐츠 -->
                    <p class="card-text" style="white-space: pre-wrap;">${post.contents}</p>
                </div>
            </div>
            <!-- 버튼 영역 -->
            <div class="mt-4 d-flex justify-content-between align-items-center">
                <div>
                    <c:if test="${username == post.author}">
                        <form action="/board/post/${post.id}" method="post" class="d-inline">
                            <input type="hidden" name="_method" value="delete" />
                            <button type="submit" class="btn btn-danger btn-sm"
                                    onclick="return confirm('정말 삭제하시겠습니까?');">
                                삭제
                            </button>
                        </form>
                    </c:if>
                </div>
                <a href="/board/posts" class="btn btn-secondary btn-sm">목록</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>

