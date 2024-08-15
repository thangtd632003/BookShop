
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<header class="header-area clearfix">
        
    <!-- Close Icon -->
    <div class="nav-close">
        <i class="fa fa-close" aria-hidden="true"></i>
    </div>
    <!-- Logo -->
    <div class="logo">
        <a href="index.html"><img src="img/core-img/Logo.png" alt=""></a>
    </div>
    <nav class="sach-nav">
        <ul>
            <li><a href="index.html">Home</a></li>
            <c:if test="${account == null}">
                <li class="active"><a href="${pageContext.request.contextPath}/authen?action=login">Login</a></li>
                <li><a href="${pageContext.request.contextPath}/authen?action=register">Register</a></li>
            </c:if>
            <c:if test="${account != null}">
                <c:if test="${account.roleId == 2}">
                    <li class="active"><a href="${pageContext.request.contextPath}/dashboard">${account.customerName}</a></li>
                </c:if>
                <c:if test="${account.roleId == 1}">
                    <li class="active"><a href="${pageContext.request.contextPath}/admin/dashboard">${account.customerName}</a></li>
                </c:if>
                <li><a href="${pageContext.request.contextPath}/authen?action=logout">Log Out</a></li>
            </c:if>
        </ul>
    </nav>
    <!-- Cart Menu -->
    <div class="cart-fav-search mb-100">
        
        <c:if test="${account != null}">
            <a href="${pageContext.request.contextPath}/check-out" class="cart-nav"><img src="img/core-img/cart.png" alt=""> Cart <span>(${cart.listOrderDetails.size()})</span></a>
        </c:if>
        <a href="#" class="search-nav"><img src="img/core-img/search1.png" alt=""><jsp:include page="searchWrapper.jsp"></jsp:include>Search</a>
          
    </div>
     
    <!-- Social Button -->
    <div class="social-info d-flex justify-content-between">
        <a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a>
        <a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a>
        <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
        <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
    </div>

</header>
   
