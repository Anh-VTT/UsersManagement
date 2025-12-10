/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package fa3w.controllers;

import fa3w.user.UserDAO;
import fa3w.user.UserDTO;
import fa3w.user.UserError;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author votra
 */
@WebServlet(name = "CreateController", urlPatterns = {"/CreateController"})
public class CreateController extends HttpServlet {

    private static final String ERROR="createPage.jsp";
    private static final String SUCCESS="login.jsp";
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url= ERROR;
        UserError userError = new UserError();
        try {
            boolean checkValidation = true;
            UserDAO dao = new UserDAO();
            String userID = request.getParameter("userID");
            String fullName = request.getParameter("fullName");
            String roleID = request.getParameter("roleID");
            String password = request.getParameter("password");
            String confirm = request.getParameter("confirm");
            //validation o day
            
            if(userID.length() < 2 || userID.length() > 5){
                checkValidation = false;
                userError.setUserIDError("User ID must be in [2,5]");
            }
//            boolean checkDuplicate = dao.checkDuplicate(userID);
//            if(checkDuplicate){
//                checkValidation = false;
//                userError.setUserIDError("Duplicate userID!!!");
//            }
            if(fullName.length() < 5 || fullName.length() > 10){
                checkValidation = false;
                userError.setFullNameError("Full Name must be in [5,10]");
            }
            if(!password.equals(confirm)){
                checkValidation = false;
                userError.setConfirmError("Both password are not same!!");
            }
            if(checkValidation){
//                boolean checkInsert = dao.insert(new UserDTO(userID, fullName, roleID, password));
                boolean checkInsert = dao.insertV2(new UserDTO(userID, fullName, roleID, password));
                if(checkInsert){
                    url = SUCCESS;
                }else{
                    userError.setError("Unknow error!!!");
                    request.setAttribute("USER_ERROR", userError);
                }
            }else{
                request.setAttribute("USER_ERROR", userError);
            }
            
            
        } catch (Exception e) {
            log("Error at CreaterController: "+ e.toString());
            if(e.toString().contains("duplicate")){
                userError.setUserIDError("Duplicate ID!!!");
                request.setAttribute("USER_ERROR", userError);
            }
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
