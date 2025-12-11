/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fa3w.product;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author votra
 */
public class Cart {
    private Map<String, ProductDTO> cart;
    
    public Cart() {
    }
    
    public Cart(Map<String, ProductDTO> cart) {
        this.cart = cart;
    }

    public Map<String, ProductDTO> getCart() {
        return cart;
    }

    public void setCart(Map<String, ProductDTO> cart) {
        this.cart = cart;
    }

    public boolean add(ProductDTO product) {
        boolean check = false;
        try {
            if(this.cart == null){
                this.cart = new HashMap<>();
            }
            if(this.cart.containsKey(product.getId())){
                int currentQuantity = this.cart.get(product.getId()).getQuantity();
                product.setQuantity(currentQuantity + product.getQuantity());
            }
            this.cart.put(product.getId(), product);
            check = true;
        } catch (Exception e) {
        }
        return check;
    }

    
    
}
