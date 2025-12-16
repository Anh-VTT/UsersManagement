package fa3w.order;

import fa3w.utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;

public class OrderDAO {

    private static final String GET_LAST_ORDER_ID = "SELECT MAX(orderID) as lastID FROM tblOrders";
//    private static final String INSERT_ORDER = "INSERT INTO tblOrders(orderID, userID, date, total) VALUES(?,?,?,?)";
    private static final String INSERT_ORDER = "INSERT INTO tblOrders(userID, date, total) VALUES(?,?,?)";
    private static final String INSERT_ORDER_DETAIL = "INSERT INTO tblOrderDetail(productID, orderID, price, quantity) VALUES(?,?,?,?)";

    private int getLastOrderID() throws SQLException, ClassNotFoundException, NamingException {
        int lastID = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_LAST_ORDER_ID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    lastID = rs.getInt("lastID");
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return lastID;
    }

//    public int insertOrder(String userID, double total) throws SQLException, ClassNotFoundException {
//        Connection conn = null;
//        PreparedStatement ptm = null;
//        int newOrderID = 0;
//        try {
//            conn = DBUtils.getConnection();
//            if (conn != null) {
//                int lastID = getLastOrderID();
//                newOrderID = lastID + 1;
//                
//                ptm = conn.prepareStatement(INSERT_ORDER);
//                ptm.setInt(1, newOrderID);
//                ptm.setString(2, userID);
//                ptm.setDate(3, new Date(System.currentTimeMillis()));
//                ptm.setDouble(4, total);
//                if (ptm.executeUpdate() > 0) {
//                    return newOrderID;
//                }
//            }
//        } finally {
//            if (ptm != null) ptm.close();
//            if (conn != null) conn.close();
//        }
//        return 0; // Return 0 if insertion fails
//    }
    public int insertOrder(String userID, double total) throws SQLException, ClassNotFoundException, NamingException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null; // Cần ResultSet để lấy key
        int orderID = 0;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                // Yêu cầu JDBC trả về key được sinh ra
                ptm = conn.prepareStatement(INSERT_ORDER, PreparedStatement.RETURN_GENERATED_KEYS);
                ptm.setString(1, userID);
                ptm.setDate(2, new Date(System.currentTimeMillis()));
                ptm.setDouble(3, total);
                if (ptm.executeUpdate() > 0) {
                    rs = ptm.getGeneratedKeys();
                    if (rs.next()) {
                        orderID = rs.getInt(1); // Lấy ID tự tăng
                    }
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return orderID;
    }

    public boolean insertOrderDetail(OrderDetailDTO detail) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT_ORDER_DETAIL);
                ptm.setString(1, detail.getProductID());
                ptm.setInt(2, detail.getOrderID());
                ptm.setDouble(3, detail.getPrice());
                ptm.setInt(4, detail.getQuantity());
                check = ptm.executeUpdate() > 0;
            }
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
}
