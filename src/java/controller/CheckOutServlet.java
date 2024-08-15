package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import dal.OrderDAO;
import dal.OrderDetailsDAO;
import dal.ProductDAO;
import entity.Customer;
import entity.Order;
import entity.OrderDetails;
import entity.Products;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class CheckOutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("check-out.jsp").forward(request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action") == null
                ? ""
                : request.getParameter("action");
        switch (action) {
            case "add-product":
                addProduct(request, response);
                response.sendRedirect("check-out");
                break;
            case "change-quantity":
                changeQuantity(request, response);
                response.sendRedirect("check-out");
                break;    
            case "delete":
                deleteItem(request, response);
                response.sendRedirect("check-out");
                break;
            case "purchase":
                purchase(request, response);
                response.sendRedirect("home");
                break;
            default:
                throw new AssertionError();
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        int id = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        List<Products> list = (List<Products>) session.getAttribute("listProduct");
        Products product = findBookById(list, id);
        OrderDetails orderDetails = OrderDetails.builder()
                .productId(id)
                .quantity(quantity)
                .build();
        Order cart = (Order) session.getAttribute("cart");
        if (cart == null) {
            cart = new Order();
        }
        addOrderDetails(orderDetails, cart);
        System.out.println(cart.toString());
        session.setAttribute("cart", cart);
    }

    private void addOrderDetails(OrderDetails orderDetails, Order cart) {
        boolean isAdd = false;
        for (OrderDetails od : cart.getListOrderDetails()) {
            if (od.getProductId()== orderDetails.getProductId()) {
                od.setQuantity(od.getQuantity() + orderDetails.getQuantity());
                isAdd = true;
                break;
            }
        }
        //kiem tra  add 
        if (isAdd == false) {
            cart.getListOrderDetails().add(orderDetails);
        }
    }

    private Products findBookById(List<Products> list, int id) {
        for (Products product : list) {
            if (product.getProductID() == id) {
                return product;
            }
        }
        return null;
    }

    private void changeQuantity(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        HttpSession session = request.getSession();
        Order cart = (Order) session.getAttribute("cart");

      
        for (OrderDetails od : cart.getListOrderDetails()) {
            if (od.getProductId()== id) {
                od.setQuantity(quantity);
            }
        }
        session.setAttribute("cart", cart);
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        Order cart = (Order) session.getAttribute("cart");
        OrderDetails od = null;
        for (OrderDetails orderDetails : cart.getListOrderDetails()) {
            if (orderDetails.getProductId() == id) {
                od = orderDetails;
            }
        }
//xóa khỏi card
cart.getListOrderDetails().remove(od);
        //set lai cart vao session
        session.setAttribute("cart", cart);
    }

    private void purchase(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //lay ve session, orderDAO, OrderDETAILDAO
        HttpSession session = request.getSession();
        OrderDAO orderDAO = new OrderDAO();
        OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
        
        //get ve note
        //get ve customer tren session
        Customer customer = (Customer) session.getAttribute(Constant.SESSION_CUSTOMER);
        //get cart tren session
        Order cart = (Order) session.getAttribute("cart");
        //get ve list Products tren session
        List<Products> list = (List<Products>) session.getAttribute("listProduct");
        if(cart== null){
                           response.sendRedirect("home");

        }
        //tính amount cua cart
        int amount = caluclateAmount(cart, list);
        //tao doi tuong order
        cart.setAccountId(customer.getId());
        cart.setAmount(amount);
        //luu doi tuong order vao trong DB, sau lưu lay ve id cua order 
        int orderId = orderDAO.insert(cart);
        //luu tung cai order detail trong cart vao trong DB
        for (OrderDetails orderDetails : cart.getListOrderDetails()) {
            orderDetails.setOrderId(orderId);
            orderDetailsDAO.insert(orderDetails);
            new ProductDAO().updateQuantity(orderDetails.getProductId(),
                    orderDetails.getQuantity());
        }
        
        session.removeAttribute("cart");
    }

    private int caluclateAmount(Order cart, List<Products> list) {
        int amount = 0;
        for (OrderDetails od : cart.getListOrderDetails()) {
            amount += (od.getQuantity() * findPriceById(list, od.getProductId()));
        }
        return amount;
    }
    
    private int findPriceById(List<Products> list, int getProductID) {
        for (Products product : list) {
            if (product.getProductID() == getProductID) {
                return product.getPrice();
            }
        }
        return 0;
    }
}
