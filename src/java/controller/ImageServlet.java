/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

/**
 *
 * @author vient
 */
@WebServlet(name = "ImageServlet", urlPatterns = {"/image"})
public class ImageServlet extends HttpServlet {

    private static final String IMAGE_FOLDER = "D:/MLB_Store/images/uploads/";
//    private static final String IMAGE_FOLDER = "D:\\FPTU\\Semester 4\\PRJ301\\VienBama\\MLB\\MLB_Store\\MLB_Store\\web\\images\\uploads\\";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String imageName = request.getParameter("name");
        if (imageName == null || imageName.contains("..")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid image name.");
            return;
        }

        File imageFile = new File(IMAGE_FOLDER, imageName);
        if (!imageFile.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String mime = getServletContext().getMimeType(imageFile.getName());
        if (mime == null) {
            mime = "application/octet-stream";
        }

        response.setContentType(mime);
        response.setContentLengthLong(imageFile.length());

        try ( FileInputStream in = new FileInputStream(imageFile);  OutputStream out = response.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
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
