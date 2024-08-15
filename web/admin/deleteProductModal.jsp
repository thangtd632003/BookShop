
<!-- modal xác nhận xóa hiển lên -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- model xác nhận xóa sản phẩm -->
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
                <p>Bạn có chắc chắn muốn xoá sản phẩm này không?</p>
            </div>
            <div class="modal-footer">
                <form action="dashboard?action=delete" method="POST"> <!--  hành động servlet dashbard method post giá trị delete -->
                    <div class="form-group" style="display: none">
                        <input type="text" class="form-control" id="pidDeleteInput" name="productID">
                    </div>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Không</button>
                    <button type="submit" class="btn btn-danger">Có</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- nhận một tham số productID từ product cần xóa , và sau đó sử dụng jQuery để chọn phần tử có id là pidDeleteInput -->
<script>
    function deleteProductModal(productID) {
        $('#pidDeleteInput').val(productID);
    }
</script>

