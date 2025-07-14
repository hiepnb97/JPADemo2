<%-- 
    Document   : userForm
    Created on : User Add/Edit Form
    Author     : System
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>
            <c:choose>
                <c:when test="${action eq 'edit'}">Chỉnh sửa User</c:when>
                <c:otherwise>Thêm User mới</c:otherwise>
            </c:choose>
        </title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f4f4f4;
            }
            .container {
                max-width: 600px;
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
            .form-group {
                margin-bottom: 20px;
            }
            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                color: #495057;
            }
            .form-group input {
                width: 100%;
                padding: 12px;
                border: 1px solid #ced4da;
                border-radius: 5px;
                font-size: 16px;
                transition: border-color 0.3s;
            }
            .form-group input:focus {
                outline: none;
                border-color: #007bff;
                box-shadow: 0 0 5px rgba(0,123,255,0.3);
            }
            .form-group .required {
                color: #dc3545;
            }
            .form-actions {
                display: flex;
                gap: 15px;
                justify-content: center;
                margin-top: 30px;
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
            .btn-secondary {
                background-color: #6c757d;
                color: white;
            }
            .btn-secondary:hover {
                background-color: #5a6268;
            }
            .alert {
                padding: 12px 20px;
                margin-bottom: 20px;
                border-radius: 5px;
                font-weight: bold;
            }
            .alert-error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
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
            .form-info {
                background-color: #e9ecef;
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
                border-left: 4px solid #007bff;
            }
            .form-info h4 {
                margin-top: 0;
                color: #495057;
            }
            .required-note {
                font-size: 14px;
                color: #6c757d;
                margin-bottom: 20px;
                font-style: italic;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <a href="user?action=list" class="back-link">← Về danh sách Users</a>
            
            <div class="header">
                <h1>
                    <c:choose>
                        <c:when test="${action eq 'edit'}">✏️ Chỉnh sửa User</c:when>
                        <c:otherwise>➕ Thêm User mới</c:otherwise>
                    </c:choose>
                </h1>
            </div>

            <c:if test="${action eq 'edit'}">
                <div class="form-info">
                    <h4>📝 Thông tin hiện tại</h4>
                    <p><strong>ID:</strong> ${user.id}</p>
                    <p><strong>Tên hiện tại:</strong> ${user.name}</p>
                    <p><strong>Email hiện tại:</strong> ${user.email}</p>
                </div>
            </c:if>

            <!-- Error Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <div class="required-note">
                <span class="required">*</span> Các trường bắt buộc
            </div>

            <form method="post" action="user">
                <c:if test="${action eq 'edit'}">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${user.id}">
                </c:if>

                <div class="form-group">
                    <label for="name">
                        👤 Tên <span class="required">*</span>
                    </label>
                    <input type="text" 
                           id="name" 
                           name="name" 
                           value="${user.name}" 
                           required 
                           placeholder="Nhập tên đầy đủ..."
                           maxlength="100">
                </div>

                <div class="form-group">
                    <label for="email">
                        📧 Email <span class="required">*</span>
                    </label>
                    <input type="email" 
                           id="email" 
                           name="email" 
                           value="${user.email}" 
                           required 
                           placeholder="Nhập địa chỉ email..."
                           maxlength="100">
                </div>

                <div class="form-group">
                    <label for="password">
                        🔒 Password <span class="required">*</span>
                    </label>
                    <input type="password" 
                           id="password" 
                           name="password" 
                           value="${user.password}" 
                           required 
                           placeholder="Nhập mật khẩu..."
                           minlength="6"
                           maxlength="50">
                    <small style="color: #6c757d; font-size: 14px;">
                        Mật khẩu phải có ít nhất 6 ký tự
                    </small>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${action eq 'edit'}">💾 Cập nhật</c:when>
                            <c:otherwise>➕ Thêm mới</c:otherwise>
                        </c:choose>
                    </button>
                    <a href="user?action=list" class="btn btn-secondary">❌ Hủy</a>
                </div>
            </form>

            <c:if test="${action eq 'add'}">
                <div style="margin-top: 30px; padding: 15px; background-color: #fff3cd; border: 1px solid #ffeaa7; border-radius: 5px; color: #856404;">
                    <h4>💡 Lưu ý:</h4>
                    <ul style="margin: 0; padding-left: 20px;">
                        <li>Email phải là duy nhất trong hệ thống</li>
                        <li>Mật khẩu sẽ được mã hóa trước khi lưu</li>
                        <li>Tất cả các trường đều bắt buộc</li>
                    </ul>
                </div>
            </c:if>
        </div>

        <script>
            // Validation client-side
            document.querySelector('form').addEventListener('submit', function(e) {
                var name = document.getElementById('name').value.trim();
                var email = document.getElementById('email').value.trim();
                var password = document.getElementById('password').value;

                if (!name) {
                    alert('Vui lòng nhập tên!');
                    document.getElementById('name').focus();
                    e.preventDefault();
                    return;
                }

                if (!email) {
                    alert('Vui lòng nhập email!');
                    document.getElementById('email').focus();
                    e.preventDefault();
                    return;
                }

                if (!password || password.length < 6) {
                    alert('Mật khẩu phải có ít nhất 6 ký tự!');
                    document.getElementById('password').focus();
                    e.preventDefault();
                    return;
                }

                // Form validated successfully
            });
        </script>
    </body>
</html> 