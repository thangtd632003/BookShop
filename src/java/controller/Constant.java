/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

public class Constant {
    // Số bản ghi mỗi trang được hiển thị trong ứng dụng
    public static final int RECORD_PER_PAGE = 9;
// Tên thuộc tính trong phiên (session) để lưu trữ thông tin của người dùng đăng nhập

    public static final String SESSION_CUSTOMER = "account";
// Các vai trò được sử dụng để phân quyền người dùng, ROLE_USER là người dùng thông thường, ROLE_ADMIN là quản trị viên

    public static final int ROLE_USER = 2;
    public static final int ROLE_ADMIN = 1;
}
