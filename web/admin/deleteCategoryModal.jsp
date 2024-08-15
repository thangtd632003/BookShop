
<!-- xóa tính chất sản phẩm modal -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="modal fade" id="delete-category-modal" tabindex="-1" role="dialog" aria-labelledby="delete-modal-label" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="delete-modal-label">Xác nhận xoá</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn không?</p>
            </div>
            <div class="modal-footer">
                <form action="category?action=delete" method="POST"> <!-- thực hiện logic ở servlet category hành đông xóa ở doPost -->
                    <div class="form-group" style="display: none">
                        <input type="text" class="form-control" id="idDeleteInput" name="id" value="">
                    </div>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Không</button>
                    <button type="submit" class="btn btn-danger">Có</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!--  Hàm này nhận một ID từ productCategory cần xóa và gán giá trị của ID đó vào input ẩn (idDeleteInput)  -->
<script>
    function deleteModal(id) {
        let inputId = document.querySelector("#idDeleteInput");
        inputId.value = id;
    }
</script>
