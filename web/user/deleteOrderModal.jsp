
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Modal xóa sản phẩm đinh đặt hàng -->
<div class="modal fade" id="delete-modal" tabindex="-1" role="dialog" aria-labelledby="delete-modal-label" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="delete-modal-label">Xác nhận xoá</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn xoá đơn hàng này không?</p>
            </div>
            <div class="modal-footer">
                <!-- dẫn hướng servlet url dashbard gán giá trị action ở method post là delete -->
                <form action="dashboard?action=delete" method="POST">
                    <div class="form-group" style="display: none">
                        <input type="text" class="form-control" id="pidDeleteInput" name="OrderID">
                    </div>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Không</button>
                    <button type="submit" class="btn btn-danger">Có</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    //lấy giá trị productID từ sản phẩm cần xóa và truyền vào giá trị pidDeleteInput
    function deleteProductModal(OrderID) {
        $('#pidDeleteInput').val(OrderID);
    }
</script>

