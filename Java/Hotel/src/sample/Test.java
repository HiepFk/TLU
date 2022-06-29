package sample;

import com.microsoft.sqlserver.jdbc.SQLServerDataSource;
import com.microsoft.sqlserver.jdbc.SQLServerException;

import java.sql.Connection;
import java.sql.SQLException;

public class Test {
    public static void main(String[] args) {
        SQLServerDataSource ds = new SQLServerDataSource();
        ds.setUser("sa");
        ds.setPassword("1");
        ds.setServerName("HIEP-FK\\SQLEXPRESS");
        ds.setPortNumber(1433);
        ds.setDatabaseName("QuanLyKS");

        try(Connection conn = ds.getConnection()) {
            System.out.println("Thành công ");
            System.out.println(conn.getCatalog());
        } catch (SQLServerException throwables) {
            throwables.printStackTrace();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }
}
