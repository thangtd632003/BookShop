/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.ProductTypes;
import dal.ProductDAO;
import dal.ProductTypeDAO;
import entity.Products;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.List;


@MultipartConfig
public class AdminDashboardServlet extends HttpServlet {

    ProductDAO productDAO;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        ProductDAO productDAO = new ProductDAO();
        ProductTypeDAO productTypeDAO = new ProductTypeDAO();
        //tạo ra session
        HttpSession session = request.getSession();

        //get dữ liệu từ DB lên
        List<Products> listProduct = productDAO.findAll2();
        List<ProductTypes> listCategory = productTypeDAO.findAll();
        //set list 
        session.setAttribute("listProduct", listProduct);
        session.setAttribute("listCategory", listCategory);
        request.getRequestDispatcher("../admin/dashboard.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      // Đặt mã ký tự và kiểu nội dung của phản hồi là "UTF-8" để hỗ trợ mã hóa và hiển thị tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
      // Lấy hoặc tạo phiên (session) từ yêu cầu
        HttpSession session = request.getSession();

        String action = request.getParameter("action") == null
                ? ""
                : request.getParameter("action");
     // Xử lý các hành động tương ứng
        switch (action) {
            case "add":
                addProduct(request);
                break;
            case "delete":
                delete(request);
                break;
            case "edit":
                edit(request);
                break;
            default:
                throw new AssertionError();
        }
        response.sendRedirect("dashboard");
    }

    private void addProduct(HttpServletRequest request) {
        productDAO = new ProductDAO();
     
        int typeID = Integer.parseInt(request.getParameter("typeID"));
        String productName = request.getParameter("productName");
        int price = Integer.parseInt(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String imagePath = null;
        try {
                // Lấy phần dữ liệu hình ảnh từ yêu cầu
            Part part = request.getPart("image");
                // Lấy đường dẫn thực tế của thư mục lưu trữ hình ảnh trong ứng dụng
            String path = request.getServletContext().getRealPath("/images");
            File dir = new File(path);
       // Tạo thư mục nếu chưa tồn tại
            if (!dir.exists()) {
                dir.mkdirs();
            }
  // Tạo tập tin hình ảnh trong thư mục lưu trữ với tên tệp được gửi trong yêu cầu
            File image = new File(dir, part.getSubmittedFileName());
            // Tạo đường dẫn cho hình ảnh
            part.write(image.getAbsolutePath());
            imagePath = request.getContextPath() + "/images/" + image.getName();
        } catch (Exception e) {
        }
        // Tạo đối tượng sản phẩm mới sử dụng mẫu thiết kế Builder

        Products products = Products.builder()
                .typeID(typeID)
                .productName(productName)
                .price(price)
                .stockQuantity(quantity)
                .image(imagePath)
                .build();
        productDAO.insert(products);
    }

    private void delete(HttpServletRequest request) {
        productDAO = new ProductDAO();
        int productID = Integer.parseInt(request.getParameter("productID"));
        productDAO.deleteById(productID);
    }

    private void edit(HttpServletRequest request) {
        Products products = new Products();
        int id = Integer.parseInt(request.getParameter("id"));
        int typeID = Integer.parseInt(request.getParameter("typeID"));
        String productName = request.getParameter("productName");
        int price = Integer.parseInt(request.getParameter("price"));
        int stockQuantity = Integer.parseInt(request.getParameter("quantity"));

        String imagePath = null;
        try {

            Part part = request.getPart("image");
            if (part.getSubmittedFileName() == null || part.getSubmittedFileName().trim().isEmpty()) {
                // Sử dụng ảnh hiện tại và cập nhật đường dẫn 
                imagePath = request.getParameter("currentImage");
            } else {
                try {
                    String path = request.getServletContext().getRealPath("/images");
                    File dir = new File(path);
                    if (!dir.exists()) {
                        dir.mkdirs();
                    }

                    File image = new File(dir, part.getSubmittedFileName());
                    part.write(image.getAbsolutePath());
                    imagePath = request.getContextPath() + "/images/" + image.getName();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        products.setProductID(id);
        products.setTypeID(typeID);
        products.setProductName(productName);
        products.setPrice(price);
        products.setStockQuantity(stockQuantity);
        products.setImage(imagePath);

        ProductDAO dao = new ProductDAO();
        dao.updateproduct(products);
    }
}
