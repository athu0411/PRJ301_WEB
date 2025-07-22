package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Cart;

@WebServlet(name = "RemoveCartController", urlPatterns = {"/RemoveCartController"})
public class RemoveCartController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            HttpSession session = request.getSession(false);
            if (session != null) {
                Cart cart = (Cart) session.getAttribute("CART");
                if (cart != null) {
                    cart.removeItem(id);
                    request.setAttribute("successMessage", "Đã xóa sản phẩm khỏi giỏ hàng.");
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID sản phẩm không hợp lệ.");
        }

        request.getRequestDispatcher("view-cart.jsp").forward(request, response);
    }
}
