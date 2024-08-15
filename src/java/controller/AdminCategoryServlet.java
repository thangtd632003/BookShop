/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.ProductTypeDAO;
import entity.ProductTypes;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class AdminCategoryServlet extends HttpServlet {
   
    ProductTypeDAO cateDAO = new ProductTypeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<ProductTypes> listCategory = cateDAO.findAll();
        session.setAttribute("listCategory", listCategory);
        request.getRequestDispatcher("../admin/categoryDashboard.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        // Lấy hoặc tạo phiên (session) từ yêu cầu
        HttpSession session = request.getSession();
// Lấy hành động từ yêu cầu. Nếu không có hành động nào được gửi, mặc định là chuỗi trống.
        String action = request.getParameter("action") == null
                ? ""
                : request.getParameter("action");
      // Xử lý các hành động tương ứng
        switch (action) {
            case "add":
                addCategory(request);
                break;
            case "delete":
                delete(request);
                break;
            case "edit":
                edit(request);
                break;
            default:

        }
        response.sendRedirect("category");
    }

    private void addCategory(HttpServletRequest request) {
        try {
                // Lấy tên loại sản phẩm từ yêu cầu

            String name = request.getParameter("name");
                // Tạo một đối tượng ProductTypes mới với ID mặc định (-1) và tên loại sản phẩm

            ProductTypes category = new ProductTypes(-1, name);
                // Chèn đối tượng loại sản phẩm này vào cơ sở dữ liệu thông qua đối tượng DAO

            cateDAO.insert(category);
        } catch (NumberFormatException ex) {
            ex.printStackTrace();
        }
    }

    private void delete(HttpServletRequest request) {
       // Lấy ID của loại sản phẩm từ yêu cầu HTTP
        int id = Integer.parseInt(request.getParameter("id"));
           // Gọi phương thức trong đối tượng DAO để xóa loại sản phẩm dựa trên ID
        cateDAO.deleteById(id);
    }

    private void edit(HttpServletRequest request) {
        try {
          // Lấy ID và tên mới của loại sản phẩm từ yêu cầu HTTP
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
        // Tạo một đối tượng ProductTypes mới với thông tin chỉnh sửa
            ProductTypes category = new ProductTypes(id, name);
                    // Gọi phương thức trong đối tượng DAO để cập nhật thông tin loại sản phẩm
            cateDAO.update(category);
        } catch (NumberFormatException ex) {
            ex.printStackTrace();
        }
    }

}
