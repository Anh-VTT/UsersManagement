package fa3w.controllers;

import fa3w.email.EmailSender;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SendEmailController", urlPatterns = {"/SendEmailController"})
public class SendEmailController extends HttpServlet {

    private static final String SUCCESS_PAGE = "send-email.jsp";
    private static final String FAIL_PAGE = "send-email.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = FAIL_PAGE;
        try {
            String toEmail = request.getParameter("toEmail");
            String subject = "Test Email";
            String body = "Hello!!!";

            EmailSender emailSender = new EmailSender();
            boolean isSent = emailSender.sendTextEmail(toEmail, subject, body);

            if (isSent) {
                url = SUCCESS_PAGE;
                request.setAttribute("MESSAGE", "Email sent successfully to " + toEmail);
            } else {
                request.setAttribute("ERROR", "Failed to send email.");
            }
        } catch (Exception e) {
            log("Error at SendEmailController: " + e.toString());
            request.setAttribute("ERROR", "An unexpected error occurred.");
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
        return "Handles sending emails";
    }
}
