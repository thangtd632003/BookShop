
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="description" content="">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
            <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

            <!-- Title  -->
            <title>BOOK Store | Cart</title>

            <!-- Favicon  -->
            <link rel="icon" href="img/core-img/favicon.ico">

            <!-- Core Style CSS -->
            <link rel="stylesheet" href="css/core-style.css">
            <link rel="stylesheet" href="style.css">

        </head>

        <body>
               <jsp:include page="footer.jsp"></jsp:include>
            <!-- Search Wrapper Area Start -->
            <jsp:include page="searchWrapper.jsp"></jsp:include>
            <!-- Search Wrapper Area End -->

            <!-- ##### Main Content Wrapper Start ##### -->
            <div class="main-content-wrapper d-flex clearfix">

                <!-- Mobile Nav (max width 767px)-->
                <jsp:include page="mobileNav.jsp"></jsp:include>

                <!-- Header Area Start -->
                <jsp:include page="headerStart.jsp"></jsp:include>
                <!-- Header Area End -->

                <div class="cart-table-area section-padding-100">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-12 col-lg-8">
                                <div class="cart-title mt-50">
                                    <h2>Shopping Cart</h2>
                                </div>

                                <div class="cart-table clearfix">
                                    <table class="table table-responsive">
                                        <thead>
                                            <tr>
                                                <th>Image</th>
                                                <th>Name</th>
                                                <th>Price</th>
                                                <th>Quantity</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${cart.listOrderDetails}" var="orderDetails"
                                                varStatus="status">
                                                <c:forEach items="${listProduct}" var="productInList">
                                                    <c:if test="${productInList.productID == orderDetails.productId}">
                                                        <c:set var="currentProduct" value="${productInList}"></c:set>
                                                    </c:if>
                                                </c:forEach>
                                                <tr>
                                                    <td class="cart_product_img">
                                                        <a href="#"><img src="${currentProduct.image}"
                                                                alt="Product"></a>
                                                    </td>
                                                    <td class="cart_product_desc">
                                                        <h5>${currentProduct.productName}</h5>
                                                    </td>
                                                    <td class="price">
                                                        <span>${currentProduct.price}</span>
                                                    </td>
                                                    <td class="qty">
                                                        <div class="qty-btn d-flex">
                                                            <p>Qty</p>
                                                            <div class="quantity">
                                                                <form action="check-out?action=change-quantity"
                                                                    method="POST">
                                                                    <input type="hidden" name="id" value="${currentProduct.productID}" />
                                                                    <span class="qty-minus"
                                                                        onclick="updateQuantity(this, -1)"><i
                                                                            class="fa fa-minus"
                                                                            aria-hidden="true"></i></span>
                                                                    <input type="number" class="qty-text" id="qty"
                                                                        step="1" min="1" max="300" name="quantity"
                                                                        value="${orderDetails.quantity}">
                                                                    <span class="qty-plus"
                                                                        onclick="updateQuantity(this, 1)"><i
                                                                            class="fa fa-plus"
                                                                            aria-hidden="true"></i></span>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <form action="check-out?action=delete&id=${currentProduct.productID}" method="POST">
                                                            <button type="submit" class="btn btn-danger">Delete</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="col-12 col-lg-4">
                                <div class="cart-summary">
                                    <h5>Cart Total</h5>
                                    <ul class="summary-table">
                                        <li><span>subtotal:</span> <span id="subtotal">$140.00</span></li>
                                        <li><span>delivery:</span> <span>Free</span></li>
                                        <li><span>total:</span> <span id="total">$140.00</span></li>
                                    </ul>
                                    <div class="cart-btn mt-100">
                                        <form class="form-customer" action="check-out?action=purchase" method="POST">
                                            <a href="#" onclick="return this.closest('form').submit();"
                                                class="btn sach-btn w-100">Checkout</a>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ##### Main Content Wrapper End ##### -->

            <!-- ##### Newsletter Area Start ##### -->
            <jsp:include page="newsLetter.jsp"></jsp:include>
            <!-- ##### Newsletter Area End ##### -->

           
         

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
            <script>
                window.onload = updateQuantityCartTotal();
<!-- gọi hàm updateQuantityCartTotal() -->
                function updateQuantity(element, change) {
                        // Cập nhật số lượng mục trong giỏ hàng và tính tổng số tiền

                    var quantity = element.parentElement.querySelector('.qty-text'); // Lấy input số lượng
                    var newQuantity = parseInt(quantity.value) + change;// Tính toán số lượng mới
                    if (newQuantity < 1) { // Đảm bảo số lượng không âm
                        newQuantity = 1;
                    }
                    quantity.value = newQuantity;// Gán số lượng mới vào input
                    updateQuantityCartTotal();// Cập nhật tổng số tiền trong giỏ hàng
                    let form = element.closest('form');// Lấy biểu mẫu chứa input
                    form.submit();
                }

                function updateQuantityCartTotal() {
                    // Cập nhật tổng số tiền trong giỏ hàng dựa trên số lượng và giá của mỗi mục
        let quantityInputs = document.querySelectorAll('.qty-text');// Lấy tất cả input số lượng
                    let total = 0;
                    
                    quantityInputs.forEach(function (input) {
                                // Duyệt qua từng input số lượng
                        quantity = parseInt(input.value); // Lấy giá trị số lượng
                        price = parseFloat(input.closest('tr').querySelector('.price span').innerText);// Lấy giá của mỗi mục
                        total += quantity * price;// Cập nhật tổng số tiền
                    });
                    document.querySelector('#subtotal').innerHTML = total + 'VND';// Hiển thị tổng số tiền
                    document.querySelector('#total').innerHTML = total + 'VND';// Hiển thị tổng số tiền
                }
            </script>
        </body>

        </html>