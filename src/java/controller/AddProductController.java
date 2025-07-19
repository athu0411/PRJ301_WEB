/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductsDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.UUID;
import model.Products;

/**
 *
 * @author Duy
 */

@MultipartConfig
@WebServlet(name = "AddProductController", urlPatterns = {"/AddProductController"})
public class AddProductController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "add-product.jsp";
    private static final String SUCCESS = "admin-product.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String productName = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("stock"));
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            String description = request.getParameter("description");

            String imageName = "default-balo.jpg";
            Part imagePart = request.getPart("image");

            if (imagePart != null && imagePart.getSize() > 0) {
                String fileName = getFileName(imagePart);
                if (fileName != null && !fileName.isEmpty()) {
                    imageName = generateImageUrl(fileName);

                    // Thư mục lưu ngoài project
                    String targetPath = "D:/MyUploads/ProductImages";
                    File targetDir = new File(targetPath);
                    if (!targetDir.exists()) {
                        targetDir.mkdirs();
                    }

                    // Ghi file ra thư mục ngoài
                    try ( InputStream input = imagePart.getInputStream()) {
                        Files.copy(input,
                                new File(targetDir, imageName).toPath(),
                                StandardCopyOption.REPLACE_EXISTING);
                    }
                }
            }

            Products product = new Products();
            product.setProductName(productName);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setDescription(description);
            product.setCategoryID(categoryID);
            product.setImgUrl(imageName);
            ProductsDAO productDAO = new ProductsDAO();
            boolean checkAdd = productDAO.addProduct(product);

            if (checkAdd) {
                url = SUCCESS;
                request.setAttribute("successMessage", "Added Product Successfully");
            } else {
                request.setAttribute("errorMessage", "Added Product failed, try again");
            }

        } catch (Exception e) {
            log("Error at AddProductController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    private String generateImageUrl(String url) {
        String uuid = UUID.randomUUID().toString();

        // Lấy đuôi file (.jpg, .png, ...)
        String extension = "";
        int dotIndex = url.lastIndexOf('.');
        if (dotIndex >= 0 && dotIndex < url.length() - 1) {
            extension = url.substring(dotIndex);
        }

        return uuid + extension;
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String cd : contentDisp.split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
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
