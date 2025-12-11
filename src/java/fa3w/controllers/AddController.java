/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package fa3w.controllers;

import fa3w.product.Cart;
import fa3w.product.ProductDAO;
import fa3w.product.ProductDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author votra
 */
@WebServlet(name = "AddController", urlPatterns = {"/AddController"})
public class AddController extends HttpServlet {

    private static final String ERROR="SearchProductController";
    private static final String SUCCESS="SearchProductController";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
         String url= ERROR;
        try {
            String id = request.getParameter("id");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("CART");
            if(cart == null){
                cart = new Cart();
            }
            ProductDAO dao= new ProductDAO();
            ProductDTO product= dao.getProduct(id);
            product.setQuantity(quantity);
            boolean check = cart.add(product);
            if(check){
                session.setAttribute("CART", cart);
                url= SUCCESS;
                request.setAttribute("MESSAGE", "add " + quantity + ": " + product.getName());
            }
            
        } catch (Exception e) {
            log("Error at AddController: "+ e.toString());
        }finally{
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
