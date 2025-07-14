<%-- 
    Document   : userList
    Created on : User List Page
    Author     : System
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách Users</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f4f4f4;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
                padding-bottom: 15px;
                border-bottom: 2px solid #007bff;
            }
            h1 {
                color: #333;
                margin: 0;
            }
            .btn {
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 5px;
                font-weight: bold;
                transition: all 0.3s;
                border: none;
                cursor: pointer;
                font-size: 14px;
            }
            .btn-primary {
                background-color: #007bff;
                color: white;
            }
            .btn-primary:hover {
                background-color: #0056b3;
            }
            .btn-success {
                background-color: #28a745;
                color: white;
            }
            .btn-success:hover {
                background-color: #1e7e34;
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
            .btn-info {
                background-color: #17a2b8;
                color: white;
            }
            .btn-info:hover {
                background-color: #138496;
            }
            .search-form {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 30px;
            }
            .search-form h3 {
                margin-top: 0;
                color: #495057;
            }
            .form-row {
                display: flex;
                gap: 15px;
                align-items: end;
                flex-wrap: wrap;
            }
            .form-group {
                flex: 1;
                min-width: 200px;
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                color: #495057;
            }
            .form-group input {
                width: 100%;
                padding: 8px 12px;
                border: 1px solid #ced4da;
                border-radius: 4px;
                font-size: 14px;
            }
            .table-container {
                overflow-x: auto;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #dee2e6;
            }
            th {
                background-color: #343a40;
                color: white;
                font-weight: bold;
            }
            tr:hover {
                background-color: #f5f5f5;
            }
            .actions {
                display: flex;
                gap: 5px;
                flex-wrap: wrap;
            }
            .alert {
                padding: 12px 20px;
                margin-bottom: 20px;
                border-radius: 5px;
                font-weight: bold;
            }
            .alert-success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            .alert-error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            .no-data {
                text-align: center;
                color: #6c757d;
                font-style: italic;
                padding: 40px;
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
        </style>
    </head>
    <body>
        <div class="container">
            <a href="index.jsp" class="back-link">← Về trang chủ</a>
            
            <div class="header">
                <h1>📋 Danh sách Users</h1>
                <a href="user?action=add" class="btn btn-primary">➕ Thêm User</a>
            </div>

            <!-- Search Form -->
            <div class="search-form">
                <h3>🔍 Tìm kiếm Users</h3>
                <form method="get" action="user">
                    <input type="hidden" name="action" value="search">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="searchName">Tên:</label>
                            <input type="text" id="searchName" name="searchName" 
                                   value="${searchName}" placeholder="Nhập tên để tìm kiếm...">
                        </div>
                        <div class="form-group">
                            <label for="searchEmail">Email:</label>
                            <input type="text" id="searchEmail" name="searchEmail" 
                                   value="${searchEmail}" placeholder="Nhập email để tìm kiếm...">
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-success">🔍 Tìm kiếm</button>
                            <a href="user?action=list" class="btn btn-info">🔄 Reset</a>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Alert Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <!-- Users Table -->
            <div class="table-container">
                <c:choose>
                    <c:when test="${not empty users}">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tên</th>
                                    <th>Email</th>
                                    <th>Password</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${users}">
                                    <tr>
                                        <td>${user.id}</td>
                                        <td>${user.name}</td>
                                        <td>${user.email}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty user.password}">
                                                    ${'*'.repeat(user.password.length())}
                                                </c:when>
                                                <c:otherwise>
                                                    <em>Chưa có</em>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="actions">
                                                <a href="user?action=view&id=${user.id}" 
                                                   class="btn btn-info" title="Xem chi tiết">👁️</a>
                                                <a href="user?action=edit&id=${user.id}" 
                                                   class="btn btn-warning" title="Chỉnh sửa">✏️</a>
                                                <a href="user?action=delete&id=${user.id}" 
                                                   class="btn btn-danger" title="Xóa"
                                                   onclick="return confirm('Bạn có chắc muốn xóa user này?')">🗑️</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        
                        <div style="text-align: center; color: #6c757d; margin-top: 20px;">
                            <strong>Tổng cộng: ${users.size()} users</strong>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">
                            <h3>📭 Không có dữ liệu</h3>
                            <p>Chưa có user nào trong hệ thống hoặc không tìm thấy kết quả phù hợp.</p>
                            <a href="user?action=add" class="btn btn-primary">➕ Thêm User đầu tiên</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </body>
</html> 