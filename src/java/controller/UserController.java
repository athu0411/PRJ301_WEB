/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductsDAO;
import dao.UsersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Users;
import model.UsersErrors;

/**
 *
 * @author vient
 */
@WebServlet(name = "LoginController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {

    private UsersDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UsersDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "login";
        }

        switch (action) {
            case "Login": {
                try {
                    handleLogin(request, response);
                } catch (SQLException ex) {
                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;

            case "Register": {
                try {
                    handleRegister(request, response);
                } catch (SQLException ex) {
                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;

            case "Logout":
                logout(request, response);
                break;
            case "Profile":
                showProfile(request, response);
                break;

            case "DeleteAccount": {
                try {
                    deleteAccount(request, response);
                } catch (SQLException ex) {
                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            default:
                response.sendRedirect("index.jsp");
                break;
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
//        String action = request.getParameter("action");
//
//        if (action == null) {
//            action = "login";
//        }
//
//        switch (action) {
//            case "logout":
//                logout(request, response);
//                break;
//                
//            case "profile":
//                showProfile(request, response);
//                break;
//
//            case "deleteAccount": {
//                try {
//                    deleteAccount(request, response);
//                } catch (SQLException ex) {
//                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
//                } catch (ClassNotFoundException ex) {
//                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
//                }
//                break;
//            }
//            case "login": {
//                try {
//                    handleLogin(request, response);
//                } catch (SQLException ex) {
//                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
//                } catch (ClassNotFoundException ex) {
//                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
//            break;
//
//            case "register": {
//                try {
//                    handleRegister(request, response);
//                } catch (SQLException ex) {
//                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
//                } catch (ClassNotFoundException ex) {
//                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
//            break;
//            
//            default:
//                response.sendRedirect("index.jsp");
//                break;
//        }
    }

    private void deleteAccount(HttpServletRequest request, HttpServletResponse response) throws SQLException, ClassNotFoundException, IOException, ServletException {
//        boolean check = userDAO.delete(request.getParameter("id"));
//        if(check) {
//            HttpSession session = request.getSession();
//            session.invalidate();
//            response.sendRedirect("login.jsp");
//        } else {
//            request.setAttribute("MESSAGE", "CAN NOT DELETE THIS ACCOUNT");
//            request.getRequestDispatcher("index.jsp").forward(request, response);
//        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
//        String action = request.getParameter("action");
//
//        if (action == null) {
//            response.sendRedirect("index.jsp");
//            return;
//        }
//
//        switch (action) {
//            case "login": {
//                try {
//                    handleLogin(request, response);
//                } catch (SQLException ex) {
//                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
//                } catch (ClassNotFoundException ex) {
//                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
//            break;
//
//            case "register": {
//                try {
//                    handleRegister(request, response);
//                } catch (SQLException ex) {
//                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
//                } catch (ClassNotFoundException ex) {
//                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
//            break;
//
//            default:
//                response.sendRedirect("index.jsp");
//                break;
//        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        Users user = userDAO.loginUser(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            if (user.getRole().equalsIgnoreCase("admin")) {
                ProductsDAO productDAO = new ProductsDAO(); 
                session.setAttribute("productList", productDAO.getAllProducts());
                response.sendRedirect("admin-product.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        boolean check = false;
        String checkName = "", checkEmail = "", checkPass = "";

        // Validation
        if (username == null || password == null || email == null || fullName == null
                || username.trim().isEmpty() || password.trim().isEmpty() || email.trim().isEmpty()
                || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }

        if (!password.equals(confirmPassword)) {
            checkPass = "Mật khẩu xác nhận không khớp";
        }

        if (userDAO.usernameExists(username)) {
            checkName = "Tên đăng nhập đã tồn tại";
            check = true;
        }

        if (userDAO.emailExists(email)) {
            checkEmail = "Email đã được sử dụng";
            check = true;
        }
        
        if(check) {
            UsersErrors error = new UsersErrors(checkName, checkPass, fullName, checkEmail, phone, address);
            request.setAttribute("USER_ERROR", error);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        

        Users user = new Users(username, password, email, fullName, phone, address);

        if (userDAO.createUser(user)) {
            request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Có lỗi xảy ra trong quá trình đăng ký");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("index.jsp");
    }

    private void showProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("user?action=login");
            return;
        }

        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }
}
