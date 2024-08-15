
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="pageSize" value="9" />

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="description" content="">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <!-- Title  -->
        <title>BOOK Store | Home</title>

        <!-- Favicon  -->
        <link rel="icon" href="img/core-img/favicon.ico">

        <!-- Core Style CSS -->
        <link rel="stylesheet" href="css/core-style.css">
        <link rel="stylesheet" href="css/style.css">

        <style>
      
            .pagination {
                display: flex;
                justify-content: center;
                padding: 20px 0;
            }

            .pagination a {
                color: black;
                float: right;
                padding: 8px 16px;
                text-decoration: none;
                transition: background-color .3s;
                border: 1px solid #ddd;
                margin: 0 4px;
            }

            .pagination a.active {
                background-color: #4CAF50;
                color: white;
                border: 1px solid #4CAF50;
            }

            .pagination a:hover:not(.active) {
                background-color: #ddd;
            }

            .pagination a.disabled {
                color: grey;
                pointer-events: none;
                cursor: default;
            }
            .pagination a.disabled:hover {
                background-color: transparent;
            }

        </style>
    </head>

    <body>
        
        <!-- ##### Footer Area End ##### -->
        <!-- ##### jQuery (Necessary for All JavaScript Plugins) ##### -->
        <script src="js/jquery/jquery-2.2.4.min.js"></script>
        <!-- Popper js -->
        <script src="js/popper.min.js"></script>
        <!-- Bootstrap js -->
        <script src="js/bootstrap.min.js"></script>
        <!-- Plugins js -->
        <script src="js/plugins.js"></script>
        <!-- Active js -->
        <script src="js/active.js"></script>
        <!-- Search Wrapper Area Start -->
      

   
          <jsp:include page="searchWrapper.jsp"></jsp:include> <!-- thêm vào giao diện search -->
          <jsp:include page="footer.jsp"></jsp:include> <!<!--thêm vào giao diện footer -->
            <div class="main-content-wrapper d-flex clearfix">
               <jsp:include page="headerStart.jsp"></jsp:include>
 
         
            <jsp:include page="mobileNav.jsp"></jsp:include><!--  thêm vô giao diện mobileNav -->


                <!-- Header Area Start -->
           <!-- thêm vô giao diện headerStart -->

         

           
                <div class="products-catagories-area clearfix">
                    <div class="sach-pro-catagory clearfix">

                        <!-- Single Catagory -->
                    <c:forEach items="${listProduct}" 
                               var="product" 
                               begin="${(pageControl.page - 1) * pageSize}"
             
                               end="${pageControl.page * pageSize - 1}">
                        <div class="single-products-catagory clearfix">
                            <a href="product-details?id=${product.productID}">
                                <img src="${product.image}" alt="image">
                                <!-- Hover Content -->
                                <div class="hover-content">
                                    <div class="line"></div>
                                    <p>From ${product.price}</p>
                                    <h4>${product.getProductName()}</h4>
                                </div>
                            </a>
                        </div>
                    </c:forEach><!-- hiện ra giao diện danh sách sản phẩm -->
                </div>
                <div class="pagination">
                    <a href="?page=${pageControl.page - 1}" class="${pageControl.page <= 1 ? 'disabled' : ''}">&laquo;</a>
                <c:forEach var="pageNumber" begin="1" end="${pageControl.totalPage}"><!-- lấy số lượng page -->
                        <a class="${pageControl.page == pageNumber ? 'active' : ''}" href="?page=${pageNumber}">${pageNumber}</a>
                    </c:forEach>
                    <a href="?page=${pageControl.page + 1}" class="${pageControl.page >= pageControl.totalPage ? 'disabled' : ''}">&raquo;</a>
                </div>
            </div>
            <!-- Product Catagories Area End -->
        </div>

                    <jsp:include page="newsLetter.jsp"></jsp:include><-<!-- phần cuối trang web -->
    

 
       

    </body>

</html>