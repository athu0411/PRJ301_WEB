/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author vient
 */
@MultipartConfig
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    private static final String WELCOME = "login.jsp";
    private static final String WELCOME_VIEW = "Login_View";

    private static final String USER = "Login";
    private static final String USER_CONTROLLER = "UserController";

    private static final String REGISTER = "Register";
    private static final String REGISTER_PAGE = "Sign Up";
    private static final String REGISTER_VIEW = "register.jsp";

    private static final String ADD_PRODUCT = "AddProduct";
    private static final String ADD_PRODUCT_CONTROLLER = "AddProductController";

    private static final String DELETE_PRODUCT = "DeleteProduct";
    private static final String DELETE_PRODUCT_CONTROLLER = "DeleteProductController";

    private static final String UPDATE_PRODUCT = "UpdateProduct";
    private static final String UPDATE_PRODUCT_CONTROLLER = "UpdateProductController";

    private static final String VIEW_PRODUCT_PAGE = "ViewProductPage";
    private static final String VIEW_PRODUCT_CONTROLLER = "ViewProductController";
    
    private static final String VIEW_PRODUCT_DETAIL_PAGE = "ViewProductDetail";
    private static final String VIEW_PRODUCT_DETAIL_CONTROLLER = "ViewProductDetailController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = WELCOME;
        try {
            String action = request.getParameter("action");
            if (USER.equals(action)) {
                url = USER_CONTROLLER;
            } else if (REGISTER_PAGE.equals(action)) {
                url = REGISTER_VIEW;
            } else if (REGISTER.equals(action)) {
                url = USER_CONTROLLER;
            } else if (WELCOME_VIEW.equals(action)) {
                action = WELCOME;
            } else if (ADD_PRODUCT.equals(action)) {
                url = ADD_PRODUCT_CONTROLLER;
            } else if (DELETE_PRODUCT.equals(action)) {
                url = DELETE_PRODUCT_CONTROLLER;
            } else if (UPDATE_PRODUCT.equals(action)) {
                url = UPDATE_PRODUCT_CONTROLLER;
            } else if(VIEW_PRODUCT_PAGE.equals(action)) {
                url = VIEW_PRODUCT_CONTROLLER;
            } else if(VIEW_PRODUCT_DETAIL_PAGE.equals(action)) {
                url = VIEW_PRODUCT_DETAIL_CONTROLLER;
            }
        } catch (Exception e) {
            log("Error at MainController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
