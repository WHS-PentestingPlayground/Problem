<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<form action="/board/post" method="post" class="container mt-5" enctype="multipart/form-data">
    <h1 class="mb-4">게시글 작성</h1>

    <div class="mb-3">
        <label for="title" class="form-label">제목:</label>
        <input type="text" id="title" name="title" class="form-control" required>
    </div>

    <div class="mb-3">
        <label for="contents" class="form-label">내용:</label>
        <textarea id="contents" name="contents" class="form-control" required></textarea>
    </div>

    <div class="mb-3">
        <label for="fileInput" class="form-label">파일 선택</label>
        <input type="file" class="form-control" id="fileInput" name="file">
    </div>
    
    <c:if test="${not empty error}">
        <div class="alert">${error}</div>
    </c:if>

    <button type="submit" class="btn btn-primary">게시글 작성</button>
</form>
