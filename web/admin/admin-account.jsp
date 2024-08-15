<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <!-- phần quản lí của admin/acount -->
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
        <jsp:include page="navigationBar.jsp"></jsp:include> <!-- Phần trên cùng của trang hiển thị -->

            <div id="wrapper">

                <!-- Sidebar -->
            <jsp:include page="sideBar.jsp"></jsp:include><!-- danh sách lựa chọn  -->

                <div id="content-wrapper">

                    <div class="container-fluid">

                        <!-- Breadcrumbs-->
                    <jsp:include page="breadCumb.jsp"></jsp:include>

                        <!-- Icon Cards-->
                

                        <div class="card mb-3">
                            <div class="card-header">
                                <i class="fas fa-table"></i>
                                Account Table 
                            </div>
                            <!-- danh sách quản lí tài khoản -->
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th style="width: 3%;">STT</th>
                                                <th style="width: 20%;">Tên tài khoản</th>
                                                <th style="width: 10%;">SDT</th>
                                                <th style="width: 15%;">Dia chi</th>
                                                <th style="width: 3%;">Gioi tinh</th>
                                                <th style="width: 5%;">Hoạt động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${listAccount}" var="acc" varStatus="status">
                                            <tr>
                                                <!--No-->
                                                <td>${status.index + 1}</td>
                                                <!--Tên tài khoản-->
                                                <td>
                                                    ${acc.customerName}
                                                </td>
                                                <!--SDT-->
                                                <td>${acc.sdt}</td> 
                                                <!--Dia chi-->
                                                <td>${acc.address}</td> 
                                                <!--Gioi tinh-->
                                                <td >
                                                    ${acc.gender == true ? "Nam" : "Nữ"}
                                                </td>
                                                <!--Hoạt động-->
                                                <td>
                                                    <button type="button"
                                                        class="btn btn-primary"
                                                        data-toggle="modal"
                                                        data-target="#editCustomerModal" 
                                                        onclick="editModal(`${acc.customerName}`)">
                                                        Edit <!-- Edit sau khi click sẽ hiển thị dạng modal -->
                                                    </button>
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
        <jsp:include page="scrollUpToButton.jsp"></jsp:include>


            <!-- Logout Modal-->
        <jsp:include page="logOutModal.jsp"></jsp:include>

            <!--Edit Customer Modal-->
        <jsp:include page="editCustomerModal.jsp"></jsp:include>

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
