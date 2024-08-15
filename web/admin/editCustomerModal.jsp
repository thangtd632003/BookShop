<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- modal hiển thị chỉnh sửa các thông tin của người dùng -->
<div class="modal fade" id="editCustomerModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editBookModalLabel">Edit password</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- thực hiện servlet url account và action ở method post được gán giá trị edit  -->
                <form id="editBookForm" action="account?action=edit" method="POST"> 
                    <!--id-->
                    <div class="form-group" >
                        <label for="name">Username:</label>
                        <input type="text" class="form-control" id="customerName" name="customerName" readonly>
                    </div>
                    <!--Name-->
                    <div class="form-group">
                        <label for="name">New Password:</label>
                        <input type="text" class="form-control" id="nameEditInput" name="password" required>
                        <div id="nameEditError" class="error"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-primary" form="editBookForm"
                        onclick="validateForm2()">Update</button>
            </div>
        </div>
    </div>
</div>
<!-- gán giá trị của tham số customerName vào trường nhập liệu có id là customerName. Sau đó, nó sử dụng console.log để ghi lại giá trị của biến customerName và giá trị của trường nhập liệu customerName để kiểm tra. -->
<script>
    function editModal(customerName) {
        $('#customerName').val(customerName);
        console.log("CustomerName: " + customerName);
        console.log("CustomerName: " + $('#customerName').val());
    }
</script>
