package fa3w.order;

public class OrderDetailDTO {
    
    private String productID;
    private int orderID;
    private double price;
    private int quantity;

    public OrderDetailDTO() {
        this.productID = "";
        this.orderID = 0;
        this.price = 0;
        this.quantity = 0;
    }

    public OrderDetailDTO(String productID, int orderID, double price, int quantity) {
        this.productID = productID;
        this.orderID = orderID;
        this.price = price;
        this.quantity = quantity;
    }

    

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

}
