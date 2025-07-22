package controller;

import dao.ProductsDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Cart;
import model.Products;

@WebServlet(name = "EditCartController", urlPatterns = {"/EditCartController"})
public class EditCartController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            ProductsDAO dao = new ProductsDAO();
            Products product = dao.getProductById(id);

            if (product == null) {
                request.setAttribute("errorMessage", "Sản phẩm không tồn tại.");
            } else if (quantity > product.getQuantity()) {
                request.setAttribute("errorMessage", "Số lượng vượt quá số lượng tồn kho: " + product.getQuantity() + ".");
            } else {
                HttpSession session = request.getSession();
                Cart cart = (Cart) session.getAttribute("CART");

                if (cart != null) {
                    cart.updateQuantity(id, quantity);
                    request.setAttribute("successMessage", "Cập nhật giỏ hàng thành công.");
                }
            }

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ.");
        }
        request.getRequestDispatcher("view-cart.jsp").forward(request, response);
    }
}
