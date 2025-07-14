<%-- 
    Document   : error
    Created on : Error Page
    Author     : System
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lỗi hệ thống</title>
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
                text-align: center;
            }
            .error-icon {
                font-size: 80px;
                color: #dc3545;
                margin-bottom: 20px;
            }
            h1 {
                color: #dc3545;
                margin-bottom: 20px;
            }
            .error-message {
                background-color: #f8d7da;
                color: #721c24;
                padding: 15px;
                border-radius: 5px;
                margin: 20px 0;
                border: 1px solid #f5c6cb;
            }
            .btn {
                display: inline-block;
                padding: 12px 24px;
                background-color: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                margin: 10px;
                font-weight: bold;
                transition: background-color 0.3s;
            }
            .btn:hover {
                background-color: #0056b3;
            }
            .error-details {
                text-align: left;
                background-color: #f8f9fa;
                padding: 15px;
                border-radius: 5px;
                margin-top: 20px;
                font-family: monospace;
                font-size: 12px;
                color: #6c757d;
                max-height: 200px;
                overflow-y: auto;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="error-icon">⚠️</div>
            <h1>Đã xảy ra lỗi!</h1>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <strong>Lỗi:</strong> ${error}
                </div>
            <% } else { %>
                <div class="error-message">
                    <strong>Lỗi không xác định:</strong> Đã xảy ra lỗi trong quá trình xử lý yêu cầu của bạn.
                </div>
            <% } %>
            
            <p>Vui lòng thử lại hoặc liên hệ quản trị viên nếu lỗi vẫn tiếp tục xảy ra.</p>
            
            <div>
                <a href="user?action=list" class="btn">📋 Về danh sách Users</a>
                <a href="index.jsp" class="btn">🏠 Về trang chủ</a>
            </div>
            
            <% if (exception != null) { %>
                <div class="error-details">
                    <strong>Chi tiết lỗi:</strong><br>
                    <%= exception.getClass().getSimpleName() %>: <%= exception.getMessage() %><br>
                    <% 
                        java.io.StringWriter sw = new java.io.StringWriter();
                        exception.printStackTrace(new java.io.PrintWriter(sw));
                        String stackTrace = sw.toString();
                        // Chỉ hiển thị 5 dòng đầu của stack trace
                        String[] lines = stackTrace.split("\n");
                        for (int i = 0; i < Math.min(5, lines.length); i++) {
                            out.println(lines[i] + "<br>");
                        }
                        if (lines.length > 5) {
                            out.println("...");
                        }
                    %>
                </div>
            <% } %>
        </div>
    </body>
</html> 