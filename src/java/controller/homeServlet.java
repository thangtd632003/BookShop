package controller;

import dal.ProductDAO;
import entity.PageControll;
import entity.Products;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class homeServlet extends HttpServlet {

    ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        PageControll pageControll = new PageControll();
        //get du lieu tu db len
        List<Products> listProduct = findProductDoGet(request, pageControll);

        session.setAttribute("listProduct", listProduct);
        request.setAttribute("pageControl", pageControll);
        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("home");
    }

    private List<Products> findProductDoGet(HttpServletRequest request, PageControll pageControl) {
        String pageRaw = request.getParameter("page");
        //valid page
        int page;
        try {
            page = Integer.parseInt(pageRaw);
        } catch (NumberFormatException e) {
            page = 1;
        }

        List<Products> listProduct;
        String action = request.getParameter("search") == null
                ? "defaultFindAll"
                : request.getParameter("search");
       
        switch (action) {
            
            case "search":
                //get về keyword muốn tìm kiếm
                String keyword = request.getParameter("keyword");
                //tìm  dựa theo thuộc tính name và keyword muốn tìm kiếm
                listProduct = productDAO.findContainsByProperty("productName", keyword);
                break;
            case "filter-price":
                float minPrice;
                float maxPrice;
                try {
                                // Lấy giá trị tối thiểu và tối đa của giá sản phẩm từ yêu cầu

                    minPrice = Float.parseFloat(request.getParameter("minPrice"));
                    maxPrice = Float.parseFloat(request.getParameter("maxPrice"));
                } catch (NumberFormatException e) {
                    // Xử lý ngoại lệ nếu giá trị không hợp lệ
                    minPrice = 0;
                    maxPrice = Float.MAX_VALUE;
                }
                listProduct = productDAO.findByMinMaxPrice(minPrice, maxPrice, page);
                break;
            //tìm về toàn bộ các sản phẩm
            default:
                listProduct = productDAO.findAll();
                break;
        }
        //total Record
        int totalRecord = listProduct.size();
        //totalPage
        int totalPage = (totalRecord % Constant.RECORD_PER_PAGE) == 0
                ? (totalRecord / Constant.RECORD_PER_PAGE)
                : (totalRecord / Constant.RECORD_PER_PAGE) + 1;

        //set page vào pageControl
        pageControl.setPage(page);
        //set totalRecord vào pageControl
        pageControl.setTotalRecord(totalRecord);
        //set total page
        pageControl.setTotalPage(totalPage);
        return listProduct;
    }

}
