/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author vient
 */
import java.util.*;

public class Cart {

    private Map<Integer, CartItem> items;

    public Cart() {
        items = new HashMap<>();
    }

    public void removeItem(int productId) {
        items.remove(productId);
    }

    public void updateQuantity(int productId, int quantity) {
        if (items.containsKey(productId)) {
            CartItem item = items.get(productId);
            item.setQuantity(quantity);
        }
    }

    public Collection<CartItem> getAllItems() {
        return items.values();
    }

    public double getTotalAmount() {
        double total = 0;
        for (CartItem item : items.values()) {
            total += item.getTotalPrice();
        }
        return total;
    }

    public void clearCart() {
        items.clear();
    }

    public void addItem(Products product, int quantity) {
        int productId = product.getProductID();
        if (items.containsKey(productId)) {
            CartItem existingItem = items.get(productId);
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
        } else {
            items.put(productId, new CartItem(product, quantity));
        }
    }
}
