<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- bảng hiện lên ở dashbard  sau khi người dùng click vào user -->
<div class="card mb-3">
    
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th style="width: 10%"">Mã vận đơn</th>
                        <th  style="width: 30%;">Số tiền</th>
                        <th  style="width: 30%;">Thời gian mua</th>
                        <th  style="width: 15%;">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listOrder}" var="order">
                        <tr>
                            <td>${order.id}</td>
                            <td>${order.amount}VNĐ</td>
                            <td><fmt:formatDate value="${order.createAt}" pattern="dd/MM/yyyy HH:mm:ss" /></td>
                            <td style="cursor: pointer">
                                <a 
                                    href="${pageContext.request.contextPath}/dashboard?page=orderDetailsSearching&id=${order.id}">
                                    <i class="fa fa-eye" aria-hidden="true"></i>
                                </a>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                  <i class="fa fa-trash fa-2x"
                                   style="color: #e70808"
                                   data-toggle="modal"
                                   data-target="#delete-modal"
                                   onclick="deleteProductModal(${order.id})">
                                </i>
                            </td>
                             
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
</div>
