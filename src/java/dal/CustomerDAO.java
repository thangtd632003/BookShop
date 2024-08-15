/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dal.DBContext;
import entity.Customer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO extends DBContext {
//in ra list người dùng từ database
    public List<Customer> findAll() {
        String sql = "SELECT*\n"
                + "  FROM [Customer]";
        List<Customer> list = new ArrayList<>();
        try {
            connection = new DBContext().getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {                
                Customer customer1 = new Customer();
                customer1.setId(resultSet.getInt("id"));
                customer1.setCustomerName(resultSet.getString("customerName"));
                customer1.setPassword(resultSet.getString("password"));
                customer1.setSdt(resultSet.getString("phonenumber"));
                customer1.setAddress(resultSet.getString("address"));
                customer1.setGender(resultSet.getBoolean("gender"));
                customer1.setRoleId(resultSet.getInt("roleId"));
                list.add(customer1);
            }
        } catch (Exception e) {
            System.err.println("Loi o findall CustomerDAO: " + e.getMessage());
        }finally {
            closeConnection();
        }
        return list;
    }
//thêm người dùng vào database
    public int insert(Customer t) {
        String sql = "INSERT INTO [dbo].[Customer]\n"
                + "           ([customerName]\n"
                + "           ,[phonenumber]\n"
                + "           ,[password]\n"
                + "           ,[roleId])\n"
                + "     VALUES\n"
                + "           (?, ? , ? , ?)";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, t.getCustomerName());
            statement.setString(2, t.getSdt());
            statement.setString(3, t.getPassword());
            statement.setInt(4, t.getRoleId());
            return statement.executeUpdate();

        } catch (Exception e) {
            System.err.println("Error " + e.getMessage() + " at insert");
        } finally {
            closeConnection();
        }
        return -1;
    }
//tìm người dùng theo tên đăng nhậo và mật khẩu
    public Customer findByCustomerNamePassword(Customer customer) {
        String sql = "SELECT * FROM [Customer]\n"
                + "WHERE CustomerName = ? and Password = ?";
        connection = getConnection();
        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, customer.getCustomerName());
            statement.setString(2, customer.getPassword());
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                Customer customer1 = new Customer();
                customer1.setId(resultSet.getInt("id"));
                customer1.setCustomerName(resultSet.getString("customerName"));
                customer1.setPassword(resultSet.getString("password"));
                customer1.setSdt(resultSet.getString("phonenumber"));
                customer1.setAddress(resultSet.getString("address"));
                customer1.setGender(resultSet.getBoolean("gender"));
                customer1.setRoleId(resultSet.getInt("roleId"));
                return customer1;
            }
        } catch (Exception e) {
            System.err.println("Error " + e.getMessage() + " at findByCustomerNamePassword");
        } finally {
            try {
                connection.close();
                resultSet.close();
                statement.close();
            } catch (Exception e) {
                // TODO: handle exception
                e.printStackTrace();
            }
        }
        return null;
    }
//tìm kiếm người dùng qua tài khoản
    public boolean findByUsername(String username) {
        String sql = "SELECT *\n"
                + "  FROM [dbo].[Customer]\n"
                + "  where customerName = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return true;
            }
        } catch (Exception e) {
            System.err.println("Error " + e.getMessage() + " at findByUsername");
        } finally {
            try {
                connection.close();
                resultSet.close();
                statement.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }
//cập nhật dữ liệu người dùng theo mã người dùng
    public void updateProfile(Customer customer) {
        String sql = "UPDATE [dbo].[Customer]\n"
                + "   SET [phonenumber] = ?\n"
                + "   , [address] = ?\n"
                + "   , [gender] = ?\n"
                + " WHERE customerName = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, customer.getSdt());
            statement.setString(2, customer.getAddress());
            statement.setBoolean(3, customer.isGender());
            statement.setString(4, customer.getCustomerName());
            statement.executeUpdate();
        } catch (Exception e) {
            System.err.println("Error " + e.getMessage() + " at updateProfile");
        } finally {
            try {
                connection.close();
                statement.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
//cập nhật mật khẩu
    public void updatePassword(String username, String password) {
        String sql = "UPDATE [dbo].[Customer]\n"
                + "   SET \n"
                + "      [password] = ?      \n"
                + " WHERE customerName = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, password);
            statement.setString(2, username);
            statement.executeUpdate();
        } catch (Exception e) {
            System.err.println("Error " + e.getMessage() + " at updatePassword");
        } finally {
            try {
                connection.close();
                statement.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
