
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- admin phần Dashboard -->
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
                        <th>ProductID</th>
                        <th>TypeID</th>
                        <th>ProductName</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Image</th>
                        <th>Action</th>
                    </tr>
                </thead>
              
                <tbody>
                    <c:forEach items="${listProduct}" var="product">
                        <tr>
                            <td name="productID">${product.productID}</td>
                            <td name="typeID">
                                <c:forEach items="${listCategory}" var="c">
                                    <c:if test="${c.id == product.typeID}">
                                        ${c.name}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td name="productName">${product.productName}</td>
                            <td name="price">${product.price}</td>
                            <td name="stockQuantity">${product.stockQuantity}</td>
                            <td name="image">
                                <img width="100px"
                                     height="100px"
                                     src="${product.image}" 
                                     alt="..." class="card-img-top"
                                     style="object-fit: contain">
                            </td>
                            <td>
                                <i class="fa fa-edit fa-2x" style="color: #469408"
                                   data-toggle="modal"
                                   onclick="editModal(this)"
                                   data-target="#editProductModal"></i> <!-- model hiện lên để thêm sửa thông tin -->
                                &nbsp;&nbsp;&nbsp;
                              
                                <i class="fa fa-trash fa-2x"
                                   style="color: #e70808"
                                   data-toggle="modal"
                                   data-target="#delete-modal" 
                                   onclick="deleteProductModal(${product.productID})">
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
