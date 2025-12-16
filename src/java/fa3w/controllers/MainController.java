/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package fa3w.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainController extends HttpServlet {

    private static final String WELCOME = "login.jsp";
    private static final String LOGIN = "Login";
    private static final String LOGIN_CONTROLLER = "LoginController";
    private static final String SEARCH = "Search";
    private static final String SEARCH_CONTROLLER = "SearchController";
    private static final String UPDATE = "Update";
    private static final String UPDATE_CONTROLLER = "UpdateController";
    private static final String DELETE = "Delete";
    private static final String DELETE_CONTROLLER = "DeleteController";
    private static final String CREATE_PAGE = "Create Page";
    private static final String CREATE_PAGE_VIEW = "createPage.jsp";
    private static final String CREATE = "Create";
    private static final String CREATE_CONTROLLER = "CreateController";
    private static final String SHOPPING_PAGE = "Shopping Page";
    private static final String SHOPPING_PAGE_VIEW = "shopping.jsp";
    private static final String SEARCH_PRODUCT = "Search Product";
    private static final String SEARCH_PRODUCT_CONTROLLER = "SearchProductController";
    private static final String ADD = "Add";
    private static final String ADD_CONTROLLER = "AddController";
    private static final String VIEW_CART = "View Cart";
    private static final String VIEW_CART_VIEW = "viewCart.jsp";
    private static final String EDIT = "Edit";
    private static final String EDIT_CONTROLLER = "EditController";
    private static final String REMOVE = "Remove";
    private static final String REMOVE_CONTROLLER = "RemoveController";
    private static final String CHECKOUT = "Checkout";
    private static final String CHECKOUT_CONTROLLER = "CheckoutController";
    //Send Mail
    private static final String EMAIL_PAGE = "Send Email";
    private static final String EMAIL_PAGE_VIEW = "send-email.jsp";
    private static final String SENDEMAIL = "SendEmail";
    private static final String SENDEMAIL_CONTROLLER = "SendEmailController";
    private static final String LOGOUT = "Logout";
    private static final String LOGOUT_CONTROLLER = "LogoutController";
    

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = WELCOME;
        try {
            String action = request.getParameter("action");
            if (action == null) {
                url = WELCOME;
            } else if (LOGIN.equals(action)) {//login
                url = LOGIN_CONTROLLER;
            } else if (SEARCH.equals(action)) {//search
                url = SEARCH_CONTROLLER;
            } else if (UPDATE.equals(action)) {//update
                url = UPDATE_CONTROLLER;
            } else if (DELETE.equals(action)) {//delete
                url = DELETE_CONTROLLER;
            } else if (CREATE_PAGE.equals(action)) {//create
                url = CREATE_PAGE_VIEW;
            } else if (CREATE.equals(action)) {
                url = CREATE_CONTROLLER;
            }else if (SHOPPING_PAGE.equals(action)) {//shopping
                url = SHOPPING_PAGE_VIEW;
            }else if (SEARCH_PRODUCT.equals(action)) {
                url = SEARCH_PRODUCT_CONTROLLER;
            }else if (ADD.equals(action)) {
                url = ADD_CONTROLLER;
            }else if (VIEW_CART.equals(action)) {
                url = VIEW_CART_VIEW;
            }else if (EDIT.equals(action)) {
                url = EDIT_CONTROLLER;
            }else if (REMOVE.equals(action)) {
                url = REMOVE_CONTROLLER;
            }else if (CHECKOUT.equals(action)) {//check out
                url = CHECKOUT_CONTROLLER;
            }else if(EMAIL_PAGE.equals(action)){//Email 
                url = EMAIL_PAGE_VIEW;
            }else if(SENDEMAIL.equals(action)){
                url = SENDEMAIL_CONTROLLER;
            }else if(LOGOUT.equals(action)){
                url = LOGOUT_CONTROLLER;
            }

        } catch (Exception e) {
            log("Error at  MainController: " + e.toString());
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
