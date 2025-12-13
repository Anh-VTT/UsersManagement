package fa3w.controllers;

import fa3w.order.OrderDAO;
import fa3w.order.OrderDetailDTO;
import fa3w.product.Cart;
import fa3w.product.ProductDAO;
import fa3w.product.ProductDTO;
import fa3w.user.UserDTO;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CheckoutController", urlPatterns = {"/CheckoutController"})
public class CheckoutController extends HttpServlet {

    private static final String ERROR = "viewCart.jsp";
    private static final String SUCCESS = "viewCart.jsp";
    private static final String LOGIN_PAGE = "login.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            
            
            if (loginUser == null || !"US".equals(loginUser.getRoleID())) {
                url = LOGIN_PAGE;
                return; 
            }
            
            Cart cart = (Cart) session.getAttribute("CART");
            
            
            if (cart == null || cart.getCart().isEmpty()) {
                request.setAttribute("ERROR", "Giỏ hàng của bạn đang trống!");
                return;
            }

            ProductDAO productDao = new ProductDAO();
            boolean isStockSufficient = true;
            Map<String, String> outOfStockItems = new HashMap<>();
            // Kiểm tra quantity
            for (ProductDTO productInCart : cart.getCart().values()) {
                int dbQuantity = productDao.getQuantity(productInCart.getId());
                if (productInCart.getQuantity() > dbQuantity) {
                    isStockSufficient = false;
                    outOfStockItems.put(productInCart.getId(), "Chỉ còn " + dbQuantity + " sản phẩm cho " + productInCart.getName());
                }
            }

            if (!isStockSufficient) {
                request.setAttribute("CHECKOUT_ERROR", outOfStockItems);
                return; 
            }

            //checkout
            OrderDAO orderDao = new OrderDAO();
            double total = 0;
            for (ProductDTO p : cart.getCart().values()) {
                total += p.getPrice() * p.getQuantity();
            }

            //Thêm vào Order
            int orderID = orderDao.insertOrder(loginUser.getUserID(), total);

            if (orderID > 0) {
                boolean allDetailsInserted = true;
                for (ProductDTO productInCart : cart.getCart().values()) {
                    //Thêm vào OrderDetail
                    OrderDetailDTO detail = new OrderDetailDTO(productInCart.getId(), orderID, productInCart.getPrice(), productInCart.getQuantity());
                    if (!orderDao.insertOrderDetail(detail)) {
                        allDetailsInserted = false;
                        request.setAttribute("ERROR", "Lỗi khi thanh toán sản phẩm: " + productInCart.getName());
                        break; 
                    }
                }

                if (allDetailsInserted) {
                     //Cập nhật quantity
                    for (ProductDTO productInCart : cart.getCart().values()) {
                        int dbQuantity = productDao.getQuantity(productInCart.getId());
                        int newQuantity = dbQuantity - productInCart.getQuantity();
                        productDao.updateQuantity(productInCart.getId(), newQuantity);
                    }
                    
                    session.removeAttribute("CART");
                    request.setAttribute("SUCCESS_MESSAGE", "Thanh toán thành công! Cảm ơn bạn đã mua hàng.");
                    url = SUCCESS;
                } else {
                    request.setAttribute("ERROR", "Đã xảy ra lỗi trong quá trình thanh toán. Vui lòng thử lại.");
                }
            } else {
                request.setAttribute("ERROR", "Tạo đơn hàng thất bại. Vui lòng thử lại.");
            }

        } catch (Exception e) {
            log("Error at CheckoutController: " + e.toString());
            request.setAttribute("ERROR", "Đã xảy ra lỗi không mong muốn. Vui lòng thử lại.");
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
        return "Checkout Controller";
    }
}
