package controller;

import dao.OrderDAO;
import dao.OrderDetailDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.CartItem;
import model.Orders;
import model.Users;

@WebServlet(name = "CheckoutController", urlPatterns = {"/CheckoutController"})
public class CheckoutController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("CART") == null || session.getAttribute("user") == null) {
                request.setAttribute("errorMessage", "Không có giỏ hàng hoặc chưa đăng nhập.");
                request.getRequestDispatcher("view-cart.jsp").forward(request, response);
                return;
            }

            Users user = (Users) session.getAttribute("user");
            Cart cart = (Cart) session.getAttribute("CART");
            List<CartItem> items = new ArrayList<>(cart.getAllItems());

            if (items == null || items.isEmpty()) {
                request.setAttribute("errorMessage", "Giỏ hàng trống.");
                request.getRequestDispatcher("view-cart.jsp").forward(request, response);
                return;
            }

            int userID = user.getUserID();
            Date orderDate = new Date(System.currentTimeMillis());
            double totalAmount = 0;

            for (CartItem item : items) {
                totalAmount += item.getTotalPrice();
            }

            Orders order = new Orders(userID, orderDate, totalAmount);
            OrderDAO dao = new OrderDAO();

            // Trả về orderID sau khi insert
            int orderId = dao.addOrderAndReturnID(order);

            if (orderId > 0) {
                OrderDetailDAO detailDao = new OrderDetailDAO();
                for (CartItem item : items) {
                    String productID = item.getProduct().getProductID() + "";
                    detailDao.addOrderDetail(orderId, productID, item.getQuantity(), item.getTotalPrice());
                }

                session.removeAttribute("CART");
                request.setAttribute("successMessage", "Đặt hàng thành công!");
            } else {
                throw new Exception("Không thể thêm đơn hàng.");
            }

            request.getRequestDispatcher("view-cart.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("view-cart.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "CheckoutController - xử lý đặt hàng";
    }
}
