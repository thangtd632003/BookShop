<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- thêm sản phẩm vào trong hệ thống , hiển thị dang modal -->
<div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-labelledby="addProductModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addProductModalLabel">Add Product</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- dữ liệu được hướng tới servlet adminDashboar và giá trị action được gán là add tại method post -->
                <form id="addProductForm" action="dashboard?action=add" method="POST" enctype="multipart/form-data">                   
                    <!--TypeID-->
                    <div class="form-group">
                        <label for="tid">TypeID:</label>
                        <select class="custom-select" id="tidInput" name="typeID">
                            <c:forEach items ="${listCategory}" var="category">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                        <div id="tidError" class="error"></div>
                    </div>
                    <!--ProductName-->
                    <div class="form-group">
                        <label for="name">ProductName</label>
                        <input type="text" class="form-control" id="nameInput" name="productName">
                        <div id="nameError" class="error"></div>
                    </div>
                    <!--Price-->
                    <div class="form-group">
                        <label for="price">Price:</label>
                        <input type="text" class="form-control" id="priceInput" name="price">
                        <div id="priceError" class="error"></div>
                    </div>
                    <!--Quantity-->
                    <div class="form-group">
                        <label for="quantity">Quantity:</label>
                        <input type="text" class="form-control" id="quantityInput" name="quantity">
                        <div id="quantityError" class="error"></div>
                    </div>


                    <!--Image-->
                    <div class="form-group">
                        <label for="image">Image: </label>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">Upload</span>
                            </div>
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="image" name="image" onchange="displayImage(this)">
                                <label class="custom-file-label" >Choose file</label>
                            </div>
                        </div>
                        <img id="previewImage" src="#" alt="Preview"
                             style="display: none; max-width: 300px; max-height: 300px;">

                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-primary" form="addProductForm" onclick="validateForm()">Add</button>
            </div>
        </div>
    </div>
</div>

<script>
    <!-- kiểm tra dữ liệu nhập -->
    function validateForm() {
        let pid = $('#pidInput').val();
        let tid = $('#tidInput').val();
        let name = $('#nameInput').val();
        let price = $('#priceInput').val();
        let quantity = $('#quantityInput').val();

        //xoá thông báo lỗi hiện tại

        $('.error').html('');
        if (pid === '') {
            $('#pidError').html('Mã sản phẩm không được để trống');
        }

        if (tid === '') {
            $('#tidError').html('Loại sản phẩm không được để trống');
        }

        if (name === '') {
            $('#nameError').html('Tên sản phẩm không được để trống');
        }

        if (price === '') {
            $('#priceError').html('Giá của sản phẩm không được để trống');
        } else if (!$.isNumeric(price) || parseFloat(price) < 0) {
            $('#priceError').html('Giá của sản phẩm phải là số và không được nhỏ hơn 0');
        }

        if (quantity === '') {
            $('#quantityError').html('Số lượng sản phẩm không được để trống');
        } else if (!$.isNumeric(quantity) || parseInt(price) < 0) {
            $('#priceError').html('Số lượng của sản phẩm phải là số và không được nhỏ hơn 0');
        }

        // Kiểm tra nếu không có lỗi thì submit form
        let error = '';
        $('.error').each(function () {
            error += $(this).html();
        });
        if (error === '') {
            $('#addProductForm').submit();
        } else {
            event.preventDefault();
        }
    }

    function displayImage(input) {
        var previewImage = document.getElementById("previewImage");
        var file = input.files[0];
        var reader = new FileReader();

        reader.onload = function (e) {
            previewImage.src = e.target.result;
            previewImage.style.display = "block";
        }

        reader.readAsDataURL(file);
    }


</script>


