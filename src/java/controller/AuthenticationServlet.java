/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CustomerDAO;
import entity.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;


public class AuthenticationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action") == null 
                ? "" 
                : request.getParameter("action");
        String url = "";
        switch (action) {
            case "login":
                url = "login.jsp";

                break;
            case "logout":
                url = "home";
                logout(request, response);
                response.sendRedirect(url);
                return;
            case "register":
                url = "register.jsp";
                break;
            default:
                url = "home";
                break;
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action");
        switch (action) {
            case "login":
                login(request, response);
                break;
            case "register":
                register(request, response);
                break;
            default:
                throw new AssertionError();
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerDAO customerDAO = new CustomerDAO();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
// Tạo một đối tượng Customer mới sử dụng builder pattern để thiết lập thông tin khách hàng (ở đây, đang đặt tên và mật khẩu mặc định)

         Customer customer = Customer.builder()
                .customerName(username)
                .password(password)
                .build();
        //kiểm tra xem account có trong DB ko
        customer = customerDAO.findByCustomerNamePassword(customer);
        //nếu account không tồn tài hoặc tài khoảng hoặc mật khẩu sai
        if (customer == null) {
            request.setAttribute("error", "Username or password incorrect !");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } else {
      
            HttpSession session = request.getSession();
            session.setAttribute(Constant.SESSION_CUSTOMER, customer);
            response.sendRedirect("home");
        }

    }
    
 
    private void logout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        session.removeAttribute(Constant.SESSION_CUSTOMER);
        session.removeAttribute("cart");
    }

    private void register(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      // Tạo một đối tượng CustomerDAO để thực hiện các thao tác liên quan đến cơ sở dữ liệu khách hàng
        CustomerDAO customerDAO = new CustomerDAO();
       // Lấy thông tin tên người dùng, mật khẩu và sdt từ yêu cầu HTTP
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String sdt = request.getParameter("sdt");
      // Tạo một đối tượng Customer mới với thông tin từ yêu cầu, bao gồm cả vai trò của người dùng là người dùng thông thường (ROLE_USER)

        Customer customer = Customer.builder()
                .customerName(username)
                .password(password)
                .sdt(sdt)
                .roleId(Constant.ROLE_USER)
                .build();
// Kiểm tra xem tài khoản đã tồn tại trong cơ sở dữ liệu chưa
        boolean isExist = customerDAO.findByUsername(username);
        if (!isExist) {
            customerDAO.insert(customer);
            response.sendRedirect("home");
        } else {
                // Nếu tài khoản đã tồn tại, đặt thuộc tính "error" trong yêu cầu và chuyển hướng người dùng đến trang "register.jsp" để thông báo lỗi
            request.setAttribute("error", "Account exist, please choose other !!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
