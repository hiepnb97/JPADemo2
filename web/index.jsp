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
        <title>JSP Page</title>
    </head>
    <body>
        <form method="post" action="user">
    Tên: <input name="name" />
    Tuổi: <input name="age" />
    <button type="submit">Lưu</button>
</form>

<p>${msg}</p>
    </body>
</html>
