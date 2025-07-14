<%-- 
    Document   : userDetail
    Created on : User Detail Page
    Author     : System
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết User - ${user.name}</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f4f4f4;
            }
            .container {
                max-width: 800px;
                margin: 0 auto;
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .header {
                text-align: center;
                margin-bottom: 30px;
                padding-bottom: 15px;
                border-bottom: 2px solid #007bff;
            }
            h1 {
                color: #333;
                margin: 0;
            }
            .user-info {
                background-color: #f8f9fa;
                padding: 30px;
                border-radius: 10px;
                border-left: 5px solid #007bff;
            }
            .info-row {
                display: flex;
                margin-bottom: 20px;
                padding: 15px 0;
                border-bottom: 1px solid #e9ecef;
            }
            .info-row:last-child {
                border-bottom: none;
                margin-bottom: 0;
            }
            .info-label {
                font-weight: bold;
                color: #495057;
                width: 150px;
                flex-shrink: 0;
            }
            .info-value {
                flex: 1;
                color: #333;
                font-size: 16px;
            }
            .password-value {
                font-family: monospace;
                background-color: #e9ecef;
                padding: 5px 10px;
                border-radius: 4px;
                color: #6c757d;
            }
            .actions {
                display: flex;
                gap: 15px;
                justify-content: center;
                margin-top: 30px;
                flex-wrap: wrap;
            }
            .btn {
                padding: 12px 24px;
                text-decoration: none;
                border-radius: 5px;
                font-weight: bold;
                transition: all 0.3s;
                border: none;
                cursor: pointer;
                font-size: 16px;
                display: inline-block;
                text-align: center;
            }
            .btn-primary {
                background-color: #007bff;
                color: white;
            }
            .btn-primary:hover {
                background-color: #0056b3;
            }
            .btn-warning {
                background-color: #ffc107;
                color: #212529;
            }
            .btn-warning:hover {
                background-color: #e0a800;
            }
            .btn-danger {
                background-color: #dc3545;
                color: white;
            }
            .btn-danger:hover {
                background-color: #c82333;
            }
            .btn-secondary {
                background-color: #6c757d;
                color: white;
            }
            .btn-secondary:hover {
                background-color: #5a6268;
            }
            .back-link {
                display: inline-block;
                margin-bottom: 20px;
                color: #007bff;
                text-decoration: none;
            }
            .back-link:hover {
                text-decoration: underline;
            }
            .user-avatar {
                text-align: center;
                margin-bottom: 20px;
            }
            .avatar-circle {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                background-color: #007bff;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 36px;
                font-weight: bold;
                margin: 0 auto;
            }
            .creation-info {
                background-color: #e9ecef;
                padding: 15px;
                border-radius: 5px;
                margin-top: 20px;
                font-size: 14px;
                color: #6c757d;
            }
            .stats {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
                gap: 15px;
                margin-top: 20px;
            }
            .stat-item {
                background-color: white;
                padding: 15px;
                border-radius: 8px;
                text-align: center;
                border: 1px solid #dee2e6;
            }
            .stat-value {
                font-size: 24px;
                font-weight: bold;
                color: #007bff;
            }
            .stat-label {
                font-size: 14px;
                color: #6c757d;
                margin-top: 5px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <a href="user?action=list" class="back-link">← Về danh sách Users</a>
            
            <div class="header">
                <h1>👤 Chi tiết User</h1>
            </div>

            <c:choose>
                <c:when test="${not empty user}">
                    <div class="user-info">
                        <div class="user-avatar">
                            <div class="avatar-circle">
                                ${user.name.substring(0, 1).toUpperCase()}
                            </div>
                            <h2 style="margin-top: 15px; color: #333;">${user.name}</h2>
                        </div>

                        <div class="info-row">
                            <div class="info-label">🆔 ID:</div>
                            <div class="info-value">#${user.id}</div>
                        </div>

                        <div class="info-row">
                            <div class="info-label">👤 Tên:</div>
                            <div class="info-value">${user.name}</div>
                        </div>

                        <div class="info-row">
                            <div class="info-label">📧 Email:</div>
                            <div class="info-value">
                                <a href="mailto:${user.email}" style="color: #007bff; text-decoration: none;">
                                    ${user.email}
                                </a>
                            </div>
                        </div>

                        <div class="info-row">
                            <div class="info-label">🔒 Password:</div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty user.password}">
                                        <span class="password-value">
                                            <c:forEach begin="1" end="${user.password.length()}">*</c:forEach>
                                            (${user.password.length()} ký tự)
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <em style="color: #6c757d;">Chưa có mật khẩu</em>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- User Statistics -->
                    <div class="stats">
                        <div class="stat-item">
                            <div class="stat-value">${user.id}</div>
                            <div class="stat-label">User ID</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value">${user.name.length()}</div>
                            <div class="stat-label">Độ dài tên</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value">
                                <c:choose>
                                    <c:when test="${not empty user.password}">
                                        ${user.password.length()}
                                    </c:when>
                                    <c:otherwise>0</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="stat-label">Độ dài password</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value">
                                <c:choose>
                                    <c:when test="${user.email.contains('@gmail.com')}">Gmail</c:when>
                                    <c:when test="${user.email.contains('@yahoo.com')}">Yahoo</c:when>
                                    <c:when test="${user.email.contains('@hotmail.com')}">Hotmail</c:when>
                                    <c:otherwise>Khác</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="stat-label">Email Provider</div>
                        </div>
                    </div>

                    <div class="creation-info">
                        <strong>📊 Thông tin bổ sung:</strong><br>
                        • Email domain: <strong>${user.email.substring(user.email.indexOf('@') + 1)}</strong><br>
                        • Tên viết tắt: <strong>${user.name.substring(0, 1).toUpperCase()}</strong><br>
                        • Trạng thái: <strong style="color: #28a745;">✓ Hoạt động</strong>
                    </div>

                    <div class="actions">
                        <a href="user?action=edit&id=${user.id}" class="btn btn-warning">
                            ✏️ Chỉnh sửa
                        </a>
                        <a href="user?action=delete&id=${user.id}" 
                           class="btn btn-danger"
                           onclick="return confirm('Bạn có chắc muốn xóa user &quot;${user.name}&quot;?')">
                            🗑️ Xóa
                        </a>
                        <a href="user?action=list" class="btn btn-secondary">
                            📋 Danh sách
                        </a>
                        <a href="user?action=add" class="btn btn-primary">
                            ➕ Thêm User mới
                        </a>
                    </div>

                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 50px; color: #6c757d;">
                        <h2>❌ Không tìm thấy User</h2>
                        <p>User mà bạn đang tìm kiếm không tồn tại hoặc đã bị xóa.</p>
                        <a href="user?action=list" class="btn btn-primary">📋 Về danh sách Users</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <script>
            // Add some interactive features
            var emailLinks = document.querySelectorAll('.info-value a[href^="mailto:"]');
            for (var i = 0; i < emailLinks.length; i++) {
                emailLinks[i].addEventListener('click', function(e) {
                    var confirmed = confirm('Bạn có muốn mở ứng dụng email để gửi mail đến ' + this.textContent + '?');
                    if (!confirmed) {
                        e.preventDefault();
                    }
                });
            }
        </script>
    </body>
</html> 