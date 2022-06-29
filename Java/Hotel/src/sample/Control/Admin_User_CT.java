package sample.Control;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.text.Text;
import javafx.stage.Stage;
import sample.Dm.Admin;
import sample.Dm.Infor;
import sample.Dm.Room;
import sample.Dm.User;

import java.io.*;
import java.net.URL;
import java.sql.*;
import java.util.ResourceBundle;

public class Admin_User_CT implements Initializable{
    private Connection con ;

    @FXML
    private TableView<Room> table3;
    @FXML
    private TableColumn<Room, String> IdColumn;
    @FXML
    private TableColumn<Room, String> statusColumn;
    @FXML
    private TableColumn<Room, String> typeColumn;

    @FXML
    private Text id;
    @FXML
    private Text name;

    @FXML
    private TableView<Room> table4;
    @FXML
    private TableColumn<Room, String> idEd;
    @FXML
    private TableColumn<Room, String> typeEd;

    ObservableList<Room> tb_Room = FXCollections.observableArrayList();
    ObservableList<Room> tb_RoomNot = FXCollections.observableArrayList();
    ObservableList<Room> tb_RoomEd = FXCollections.observableArrayList();

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        IdColumn.setCellValueFactory(new PropertyValueFactory<>("Id_Room"));
        typeColumn.setCellValueFactory(new PropertyValueFactory<>("type"));
        statusColumn.setCellValueFactory(new PropertyValueFactory<>("status"));
        table3.setItems(tb_RoomNot);
//        locPhongTrong();

        idEd.setCellValueFactory(new PropertyValueFactory<>("Id_Room"));
        typeEd.setCellValueFactory(new PropertyValueFactory<>("type"));
        table4.setItems(tb_RoomEd);
        Read_SQL();
    }
    public Admin_User_CT(){
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databasename=QuanLyKS;"
                    + "username=sa;password=1");
            System.out.println("Thành công ");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void set(User k) {
        name.setText(String.valueOf(k.getName_User()));
        id.setText(String.valueOf(k.getId_User()));
    }
    public void locPhongTrong(){
        tb_RoomNot.clear();
        String sql2 = "SELECT * FROM KhachSan where status=0";
        try {
            PreparedStatement ps2 = con.prepareStatement(sql2);
            ResultSet rs2 = ps2.executeQuery();
            while(rs2.next()){
                Room s = new Room();
                s.setId_Room(rs2.getString("Id_Room"));
                s.setType(rs2.getString("type"));
                s.setStatus(rs2.getString("status"));
                tb_RoomNot.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

   public void back(ActionEvent e) throws IOException {
       Stage stage = (Stage) ((Node) e.getSource()).getScene().getWindow();
       FXMLLoader loader = new FXMLLoader();
       loader.setLocation(getClass().getResource("/sample/Layout/Admin.fxml"));
       Parent sampleParent = loader.load();
       Scene scene = new Scene(sampleParent);
       stage.setScene(scene);
    }
    public String type(String idRoom){
        for ( Room k : tb_Room ){
            if(k.getId_Room().equals(idRoom))
            {
                return k.getType();
            }
        }
        return "Test";
    }

    public void Update(String Id_Room , String a) {
        String sql = "Update [KhachSan] set  status= ?   where Id_Room=?";
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, a);
            pst.setString(2,Id_Room);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void dk() {
        String sql = "INSERT INTO User_Ed(Id_User,Id_Room)"
                + " VALUES(?,?)";
        Room selected = table3.getSelectionModel().getSelectedItem();
        String Id_User = id.getText();
        String Id_Room = selected.getId_Room();
        String type = selected.getType();
        tb_RoomEd.add(new Room(Id_Room,type));
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, Id_User);
            pst.setString(2, Id_Room);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        Update(Id_Room,"1");
//        tb_RoomNot.remove(selected);

        Read_SQL();

    }
    public  void huy() {
        String sql = "DELETE FROM [User_Ed] where Id_User=? and Id_Room=? ";
        Room selected = table4.getSelectionModel().getSelectedItem();
        String Id_Room = selected.getId_Room();
        String Id_User = id.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, Id_User);
            pst.setString(2, Id_Room);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        Update(Id_Room,"0");

        Read_SQL();

    }

    public void Read_SQL() {
        // Đọc khách hàng ed , và danh sách phòng đã đăng kí
        tb_RoomEd.clear();
        String sql = "SELECT * FROM [User_Ed] where Id_User=? ";
        String Id_User = id.getText();

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1 , Id_User);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Room s = new Room();
                s.setId_Room(rs.getString("Id_Room"));
                s.setType(type(rs.getString("Id_Room")));
                tb_RoomEd.add(s);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        tb_Room.clear();
        String sql2 = "SELECT * FROM KhachSan";
        try {
            PreparedStatement ps2 = con.prepareStatement(sql2);
            ResultSet rs2 = ps2.executeQuery();
            while(rs2.next()){
                Room s = new Room();
                s.setId_Room(rs2.getString("Id_Room"));
                s.setType(rs2.getString("type"));
                s.setStatus(rs2.getString("status"));
                tb_Room.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        locPhongTrong();
    }

}
