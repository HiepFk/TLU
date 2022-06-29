package sample.Control;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.io.IOException;
import java.sql.*;

public class Login_CT {
    private Connection con;
    private PreparedStatement pl;
    private ResultSet rs;

    @FXML
    private Label lblStatus;
    @FXML
    private TextField txtUser;
    @FXML
    private TextField txtPass;

    public Login_CT() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433; databasename=QuanLySV;"
                    + "username=sa;password=1");
            System.out.println("Thành công ");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String getUser() {
        String user = "";
        try {
            pl = con.prepareStatement("Select id_User from Table_User where id_User =?");
            pl.setString(1, txtUser.getText());
            rs = pl.executeQuery();
            if (rs.next()) {
                user = rs.getString(1);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    private String getUser1() {
        String user = "";
        try {
            pl = con.prepareStatement("Select id_Sv from Table_Sv where id_Sv =?");
            pl.setString(1, txtUser.getText());
            rs = pl.executeQuery();
            if (rs.next()) {
                user = rs.getString(1);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    private String getPass1() {
        String pass ="";
        try {
            pl = con.prepareStatement("Select pass from Table_Sv where pass =?");
            pl.setString(1, txtPass.getText());
            rs = pl.executeQuery();
            if (rs.next()) {
                pass = rs.getString(1);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pass;
    }

    private String getPass() {
        String pass ="";
        try {
            pl = con.prepareStatement("Select pass_User from Table_User where pass_User =?");
            pl.setString(1, txtPass.getText());
            rs = pl.executeQuery();
            if (rs.next()) {
                pass = rs.getString(1);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pass;
    }

    public void Login(ActionEvent event) throws IOException {
        Stage stage = (Stage) ((Node) event.getSource()).getScene().getWindow();
        FXMLLoader loader = new FXMLLoader();
        loader.setLocation(getClass().getResource("/sample/Layout/Admin.fxml"));
        Parent sampleParent = loader.load();
        Scene scene = new Scene(sampleParent);
        stage.setScene(scene);
        stage.setTitle("ADMIN");
//        if(txtUser.getText().equals("") || txtPass.getText().equals(""))
//        {
//            lblStatus.setText("Nhập đủ thông tin");
//        }
//        else if(txtUser.getText().equals(getUser1()) && txtPass.getText().equals(getPass1()))
//        {
//            Stage stage = (Stage) ((Node) event.getSource()).getScene().getWindow();
//            FXMLLoader loader = new FXMLLoader();
//            loader.setLocation(getClass().getResource("/sample/Layout/SinhVien.fxml"));
//            Parent sampleParent = loader.load();
//            Scene scene = new Scene(sampleParent);
//
//            SinhVien_CT controller = loader.getController();
//            controller.set(txtUser.getText());
//
//            controller.Read_SQL();
//
//            stage.setScene(scene);
//            stage.setTitle("SINH VIÊN");
//        }
//        else if (txtUser.getText().equals(getUser()) && txtPass.getText().equals(getPass())) {
//            Stage stage = (Stage) ((Node) event.getSource()).getScene().getWindow();
//            FXMLLoader loader = new FXMLLoader();
//            loader.setLocation(getClass().getResource("/sample/Layout/Admin.fxml"));
//            Parent sampleParent = loader.load();
//            Scene scene = new Scene(sampleParent);
//            stage.setScene(scene);
//            stage.setTitle("ADMIN");
//        } else {
//            lblStatus.setText("Nhập sai");
//            txtUser.setText("");
//            txtPass.setText("");
//        }

    }

}
