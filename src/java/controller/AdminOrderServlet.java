/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CustomerDAO;
import dal.OrderDAO;
import dal.OrderDetailsDAO;
import dal.ProductDAO;
import entity.OrderDetails;
import entity.Products;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class AdminOrderServlet extends HttpServlet {

    OrderDAO orderDAO = new OrderDAO();
    CustomerDAO customerDAO = new CustomerDAO();
    OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy hoặc tạo phiên (session) từ yêu cầu
        HttpSession session = request.getSession();
        // Lưu danh sách tất cả đơn hàng vào phiên
        session.setAttribute("listOrder", orderDAO.findAll());
        // Lưu danh sách tất cả tài khoản khách hàng vào phiên
        session.setAttribute("listAccount", customerDAO.findAll());
         // Chuyển hướng yêu cầu đến trang jsp để quản lý đơn hàng trong trang quản trị viên
        request.getRequestDispatcher("../admin/manageOrder.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      // Lấy hành động từ yêu cầu. Nếu không có hành động nào được gửi, mặc định là chuỗi trống.
        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        // Xử lý các hành động tương ứng

        switch (action) {
                    // Nếu hành động là "detailsOrder", thực hiện chức năng để xem chi tiết đơn hàng
            case "detailsOrder":
                viewOrderDetails(request, response);
                break;

            default:
                break;
        }
    }
    
    private void viewOrderDetails(HttpServletRequest request, HttpServletResponse response) {
       // Lấy ID của đơn hàng từ yêu cầu và chuyển đổi sang kiểu số nguyên
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        // Lấy danh sách các chi tiết đơn hàng dựa trên ID đơn hàng
        List<OrderDetails> listOrderDetails = orderDetailsDAO.findByOrderId(orderId);
        // Lấy danh sách tất cả sản phẩm từ cơ sở dữ liệu
        List<Products> listProduct = new ProductDAO().findAll2();
        // Lưu danh sách chi tiết đơn hàng và danh sách sản phẩm vào phiên (session) để sử dụng trong trang jsp
        HttpSession session = request.getSession();
        session.setAttribute("listOrderDetails", listOrderDetails);
        session.setAttribute("listProduct", listProduct);
        try {
            request.getRequestDispatcher("../admin/admin-order-details.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            e.printStackTrace();
        }
    }

}
