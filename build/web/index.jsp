<%-- 
    Document   : index
    Created on : Jun 10, 2025, 11:26:16 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Management System</title>
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
            h1 {
                color: #333;
                text-align: center;
                margin-bottom: 30px;
            }
            .menu {
                display: flex;
                justify-content: center;
                gap: 20px;
                margin-bottom: 30px;
            }
            .menu-item {
                background-color: #007bff;
                color: white;
                padding: 12px 24px;
                text-decoration: none;
                border-radius: 5px;
                font-weight: bold;
                transition: background-color 0.3s;
            }
            .menu-item:hover {
                background-color: #0056b3;
            }
            .description {
                text-align: center;
                color: #666;
                font-size: 16px;
                line-height: 1.6;
            }
            .features {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-top: 30px;
            }
            .feature {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                text-align: center;
                border-left: 4px solid #007bff;
            }
            .feature h3 {
                color: #007bff;
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>🚀 User Management System</h1>
            
            <div class="description">
                <p>Hệ thống quản lý người dùng với đầy đủ chức năng CRUD sử dụng JPA/Hibernate</p>
            </div>

            <div class="menu">
                <a href="user?action=list" class="menu-item">📋 Danh sách Users</a>
                <a href="user?action=add" class="menu-item">➕ Thêm User</a>
            </div>

            <div class="features">
                <div class="feature">
                    <h3>📋 Danh sách</h3>
                    <p>Xem tất cả users với phân trang và sắp xếp</p>
                </div>
                <div class="feature">
                    <h3>🔍 Tìm kiếm</h3>
                    <p>Tìm kiếm users theo tên hoặc email</p>
                </div>
                <div class="feature">
                    <h3>✏️ Chỉnh sửa</h3>
                    <p>Thêm, sửa, xóa users dễ dàng</p>
                </div>
                <div class="feature">
                    <h3>👁️ Chi tiết</h3>
                    <p>Xem thông tin chi tiết của từng user</p>
                </div>
            </div>

            <% if (request.getAttribute("msg") != null) { %>
                <div style="margin-top: 20px; padding: 10px; background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; border-radius: 5px;">
                    ${msg}
                </div>
            <% } %>
        </div>
    </body>
</html>
