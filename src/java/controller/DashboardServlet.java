/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CustomerDAO;
import dal.OrderDAO;
import dal.OrderDetailsDAO;
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
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class DashboardServlet extends HttpServlet {

    CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String page = request.getParameter("page") == null ? "" : request.getParameter("page");
        String url;
        //cạp nhật lai account vao session
        HttpSession session = request.getSession();
        Customer account = (Customer) session.getAttribute(Constant.SESSION_CUSTOMER);
        if (account.getRoleId() == Constant.ROLE_ADMIN) {
            response.sendRedirect("admin/book");
            return;
        }
        setListPurchase(request, account);
        switch (page) {
            case "orderDetailsSearching":
                findListOrderDetails(request, response);
                url = "user/orderDetailsSearching.jsp";
                break;
            case "profile":
                url = "user/profile.jsp";
                break;
            case "change-password":
                url = "user/change-password.jsp";
                break;
            default:
                url = "user/dashboard.jsp";
                break;
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    private void setListPurchase(HttpServletRequest request, Customer customer) {
        OrderDAO orderDAO = new OrderDAO();
        List<Order> listOrder = orderDAO.findsByAccountId(customer.getId());
        HttpSession session = request.getSession();
        session.setAttribute("listOrder", listOrder);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String url = "";
        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        switch (action) {
            case "profile":
                updateProfileDoPost(request);
                url = "user/profile.jsp";
                break;
            case "change-password":
                changePassword(request);
                url = "user/change-password.jsp";
                break;
            case "delete":
                DeleteOrder(request, response);
                url="dashboard";
                response.sendRedirect(url);
                break;
            default:
                url = "dashboard";
                break;
        }
        request.getRequestDispatcher(url).forward(request, response);
    }
private void DeleteOrder(HttpServletRequest request,HttpServletResponse response){
    String id = request.getParameter("OrderID");
 OrderDAO db = new OrderDAO();
        OrderDetailsDAO db1 = new OrderDetailsDAO();
    
db1.DelteByOrderId(id);
db.deleteOrderbyOrderid(id);
    
}
    private void updateProfileDoPost(HttpServletRequest request) {
        String sdt = request.getParameter("sdt");
        String customername = request.getParameter("customerName");
        String address = request.getParameter("address");
        boolean gender = request.getParameter("gender").
                equalsIgnoreCase("Male");
        Customer customer = Customer.builder()
                .customerName(customername)
                .sdt(sdt)
                .address(address)
                .gender(gender)
                .build();
        customerDAO.updateProfile(customer);
        HttpSession session = request.getSession();
        Customer customerNew = (Customer) session.getAttribute(Constant.SESSION_CUSTOMER);
        customerNew.setSdt(sdt);
        customerNew.setAddress(address);
        customerNew.setGender(gender);
        session.setAttribute(Constant.SESSION_CUSTOMER, customerNew);

    }

    private void changePassword(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String newPassword = request.getParameter("newPassword");

        HttpSession session = request.getSession();
        Customer accountSession = (Customer) session.getAttribute(Constant.SESSION_CUSTOMER);

        if (password.equals(accountSession.getPassword())) {
            customerDAO.updatePassword(username, newPassword);
            accountSession.setPassword(password);
            session.setAttribute(Constant.SESSION_CUSTOMER, accountSession);
        } else {
            request.setAttribute("error", "Incorrect password");
        }
    }

    private void findListOrderDetails(HttpServletRequest request, HttpServletResponse response) {
        int orderId = Integer.parseInt(request.getParameter("id"));

     
        List<OrderDetails> listOrderDetails = new OrderDetailsDAO().findByOrderId(orderId);
        //xuất list product tu sesison
        HttpSession session = request.getSession();
        List<Products> listProduct = (List<Products>) session.getAttribute("listProduct");
        //tao ra hashmap
        Map<OrderDetails, Products> map = new LinkedHashMap<>();
        //them gia tri vao hashmap
        map = addMap(map, listOrderDetails, listProduct);
        //set vao request
        System.out.println(map);
        session.setAttribute("map", map);
    }

    private Map<OrderDetails, Products> addMap(Map<OrderDetails, Products> map,
            List<OrderDetails> listOrderDetails, List<Products> listProduct) {
        for (OrderDetails od : listOrderDetails) {
            for (Products products : listProduct) {
                if (od.getProductId() == products.getProductID()) {
                    map.put(od, products);
                }
            }
        }
        return map;
    }

}
