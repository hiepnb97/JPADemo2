/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.User;

/**
 * UserServlet - Controller xử lý tất cả request liên quan đến User
 * Hỗ trợ các chức năng: list, add, edit, delete, search, view
 */
@WebServlet(name = "UserServlet", urlPatterns = {"/user"})
public class UserServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    /**
     * Handles the HTTP <code>GET</code> method.
     * Xử lý các action: list, add, edit, delete, view, search
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Default action
        }

        try {
            switch (action) {
                case "list":
                    listUsers(request, response);
                    break;
                case "add":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteUser(request, response);
                    break;
                case "view":
                    viewUser(request, response);
                    break;
                case "search":
                    searchUsers(request, response);
                    break;
                default:
                    listUsers(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * Xử lý insert và update user
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        try {
            if ("update".equals(action)) {
                updateUser(request, response);
            } else {
                insertUser(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    /**
     * Hiển thị danh sách tất cả users
     */
    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> users = userDAO.getAll();
        request.setAttribute("users", users);
        request.getRequestDispatcher("userList.jsp").forward(request, response);
    }

    /**
     * Hiển thị form thêm user mới
     */
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("action", "add");
        request.getRequestDispatcher("userForm.jsp").forward(request, response);
    }

    /**
     * Hiển thị form edit user
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userDAO.findById(id);
        
        if (user != null) {
            request.setAttribute("user", user);
            request.setAttribute("action", "edit");
            request.getRequestDispatcher("userForm.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Không tìm thấy user với ID: " + id);
            listUsers(request, response);
        }
    }

    /**
     * Xem chi tiết user
     */
    private void viewUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userDAO.findById(id);
        
        if (user != null) {
            request.setAttribute("user", user);
            request.getRequestDispatcher("userDetail.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Không tìm thấy user với ID: " + id);
            listUsers(request, response);
        }
    }

    /**
     * Thêm user mới
     */
    private void insertUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);

        userDAO.insert(user);
        
        request.setAttribute("success", "Thêm user thành công!");
        response.sendRedirect("user?action=list");
    }

    /**
     * Cập nhật user
     */
    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = new User();
        user.setId(id);
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);

        userDAO.update(user);
        
        request.setAttribute("success", "Cập nhật user thành công!");
        response.sendRedirect("user?action=list");
    }

    /**
     * Xóa user
     */
    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean deleted = userDAO.delete(id);
        
        if (deleted) {
            request.setAttribute("success", "Xóa user thành công!");
        } else {
            request.setAttribute("error", "Không thể xóa user với ID: " + id);
        }
        
        response.sendRedirect("user?action=list");
    }

    /**
     * Tìm kiếm users
     */
    private void searchUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchName = request.getParameter("searchName");
        String searchEmail = request.getParameter("searchEmail");
        
        List<User> users;
        
        if ((searchName != null && !searchName.trim().isEmpty()) || 
            (searchEmail != null && !searchEmail.trim().isEmpty())) {
            users = userDAO.search(searchName, searchEmail);
            request.setAttribute("searchName", searchName);
            request.setAttribute("searchEmail", searchEmail);
        } else {
            users = userDAO.getAll();
        }
        
        request.setAttribute("users", users);
        request.getRequestDispatcher("userList.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "UserServlet - CRUD operations for User entity";
    }
}
