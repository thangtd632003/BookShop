/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CustomerDAO;
import dal.RoleDAO;
import entity.Customer;
import entity.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class AdminAccountServlet extends HttpServlet {

    CustomerDAO cDAO = new CustomerDAO();
    RoleDAO rDAO = new RoleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         // Lấy danh sách tài khoản khách hàng và danh sách vai trò từ cơ sở dữ liệu
        List<Customer> listAccount = cDAO.findAll();
        List<Role> listRole = rDAO.findAll();
            // Đặt danh sách tài khoản và vai trò như là thuộc tính của yêu cầu
        request.setAttribute("listAccount", listAccount);
        request.setAttribute("listRole", listRole);
    // Chuyển hướng yêu cầu đến trang "admin-account.jsp" để hiển thị thông tin tài khoản và vai trò cho quản trị viên
        request.getRequestDispatcher("../admin/admin-account.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            // Lấy hành động từ yêu cầu. Nếu không có hành động nào được gửi, mặc định là chuỗi trống.
        String action = request.getParameter("action") == null
                ? ""
                : request.getParameter("action");
            // Xác định hành động và gọi phương thức xử lý tương ứng
        switch (action) {
            case "edit":
                edit(request, response);
                break;
            default:
                throw new AssertionError();
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminAccountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminAccountServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private void edit(HttpServletRequest request, HttpServletResponse response) throws IOException {
            // Lấy tên người dùng và mật khẩu mới từ yêu cầu HTTP
        String customerName = request.getParameter("customerName");
        String password = request.getParameter("password");
            // Gọi phương thức trong đối tượng DAO để cập nhật mật khẩu của tài khoản dựa trên tên người dùng
        cDAO.updatePassword(customerName, password);
            // Chuyển hướng người dùng đến trang "account" sau khi chỉnh sửa thành công
        response.sendRedirect("account");
    }

}
