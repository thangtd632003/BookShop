
<!-- modal check lại việc thoát ra -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!-- Modal để xác nhận việc đăng xuất -->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Bạn muốn đăng xuất?</h5>
                   <!-- Nút đóng modal -->
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">Chọn "Đăng xuất" bên dưới nếu bạn sẵn sàng kết thúc phiên hiện tại của mình.</div>
               <!-- Phần nội dung của modal -->
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/authen?action=logout">Logout</a> <!-- servlet liên kết logout -->
              <!-- Nút để thực hiện đăng xuất, liên kết tới servlet xử lý đăng xuất -->
            </div>
        </div>
    </div>
</div>
