/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dal.DBContext;
import entity.Order;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.sql.*;
import java.time.LocalDate;

public class OrderDAO extends DBContext {
//lấy ra danh sách các lượt đặt hàng
    public List<Order> findAll() {
        String sql = "SELECT *\n"
                + "  FROM [Order]";
        List<Order> list = new ArrayList<>();
        try {
            connection = new DBContext().getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Order order = new Order();
                order.setId(resultSet.getInt("id"));
                order.setAmount(resultSet.getInt("amount"));
                order.setCreateAt(resultSet.getTimestamp("createAt"));
                order.setAccountId(resultSet.getInt("accountId"));
                list.add(order);
            }
        } catch (Exception e) {
            System.err.println("Loi o find all: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return list;
    }
//thêm đặt hàng
    public int insert(Order t) {
        String sql = "INSERT INTO [dbo].[Order]\n"
                + "           ([amount]\n"
                + "           ,[accountId])\n"
                + "     VALUES\n"
                + "           (?, ? )";
        try {
            connection = new DBContext().getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setObject(1, t.getAmount());
            statement.setObject(2, t.getAccountId());
            // Thực thi câu truy vấn
            statement.executeUpdate();

            // Lấy khóa chính (ID) được tạo tự động
            resultSet = statement.getGeneratedKeys();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return -1;
    }
//order theo mã của tài khoản
    public List<Order> findsByAccountId(int id) {
        String sql = "SELECT *\n"
                + "  FROM [Order]\n"
                + "  where accountId = ?";
        List<Order> list = new ArrayList<>();
        try {
            connection = new DBContext().getConnection();
            statement = connection.prepareStatement(sql);
            statement.setObject(1, id);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Order order = new Order();
                order.setId(resultSet.getInt("id"));
                order.setAmount(resultSet.getInt("amount"));
                order.setCreateAt(resultSet.getTimestamp("createAt"));
                order.setAccountId(resultSet.getInt("accountId"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return list;
    }
        public void deleteOrderbyOrderid(String id) {
           String sql = "DELETE FROM [dbo].[Order]\n"
                + "      WHERE id = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1,id );
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
    }
}
