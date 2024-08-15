
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <!-- danh sách đặt hàng cụ thể sản phẩm-->
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>SB Admin - Dashboard</title>

        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

        <!-- Page level plugin CSS-->
        <link href="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="${pageContext.request.contextPath}/css/sb-admin.css" rel="stylesheet">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/colReorder-bootstrap4.css">

        <style>
            .error {
                color: red;
            }
        </style>
    </head>

    <body id="page-top">
        <jsp:include page="navigationBar.jsp"></jsp:include> <!-- phần phía trên của trang -->

            <div id="wrapper">

                <!-- Sidebar -->
            <jsp:include page="sideBar.jsp"></jsp:include> <!-- phần thanh bên -->

                <div id="content-wrapper">

                    <div class="container-fluid">

                   

                        <!-- Icon Cards-->
                 

                        <div class="card mb-3">
                            <div class="card-header">
                                <i class="fas fa-table"></i>
                                Data Table 
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th style="width: 3%;">STT</th>
                                                <th style="width: 12%;">Tên sản phẩm</th>
                                                <th style="width: 22%;">Hình ảnh</th>
                                                <th style="width: 15%;">Giá cả</th>
                                                <th style="width: 8%;">Số lượng</th>
                                                <th style="width: 33%;">Tổng tiền</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${listOrderDetails}" var="obj" varStatus="status">
                                            <c:forEach items="${listProduct}" var="product">
                                                <c:if test="${obj.productId == product.productID}">
                                                    <c:set var="o" value="${product}"></c:set>
                                                </c:if>
                                            </c:forEach>
                                            <tr>
                                                <!--No-->
                                                <td>${status.index + 1}</td>
                                                <!--Tên sản phẩm-->
                                                <td>
                                                    ${o.productName}
                                                </td>
                                                <!--Hình ảnh-->
                                                <td>
                                                    <img class="img-fluid rounded" src="${o.image}" name="image">
                                                </td>
                                                <!--Giá cả-->
                                                <td>
                                                    ${o.price}đ   
                                                </td>
                                                <!--Số lượng-->
                                                <td >
                                                    ${obj.quantity}
                                                </td>
                                                <!--Tổng tiền-->
                                                <td>
                                                    ${o.price * obj.quantity}đ
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
                    </div>


                </div>

            </div>
            <!-- /.container-fluid -->

            <!-- Sticky Footer -->
            <jsp:include page="stickFooter.jsp"></jsp:include>


            </div>
            <!-- /.content-wrapper -->

            <!-- /#wrapper -->

            <!-- Scroll to Top Button-->
            <jsp:include page="scrollUpToButton.jsp"></jsp:include> <!-- nút ấn lên -->


            <!-- logout xuất hiện modal xác nhận lại-->
        <jsp:include page="logOutModal.jsp"></jsp:include>

        

            <!--Modal xác nhận việc xóa-->
        <jsp:include page="deleteProductModal.jsp"></jsp:include>

            <!--Modal để-->
        <jsp:include page="editProductModal.jsp"></jsp:include>

            <!-- Bootstrap core JavaScript-->
            <script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Page level plugin JavaScript-->
        <script src="${pageContext.request.contextPath}/vendor/chart.js/Chart.min.js"></script>
        <script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.js"></script>
        <script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="${pageContext.request.contextPath}/js/sb-admin.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/colReorder-bootstrap4-min.js"></script>
        <script src="${pageContext.request.contextPath}/js/colReorder-dataTables-min.js"></script>

        <!-- Demo scripts for this page-->
        <script src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>
        <script src="${pageContext.request.contextPath}/js/demo/chart-area-demo.js"></script>
        <script src="${pageContext.request.contextPath}/js/colReorder-dataTables-min.js"></script>
        <script src="${pageContext.request.contextPath}/js/colReorder-bootstrap4-min.js"></script>


    </body>

</html>
