package sample.Control;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.collections.transformation.SortedList;
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
import javafx.stage.Stage;
import sample.Dm.Admin;
import sample.Dm.Infor;
import sample.Dm.Room;
import sample.Dm.User;

import java.io.*;
import java.net.URL;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

public class Admin_CT implements Initializable {
    private Connection con ;

//  Khách hàng
    @FXML
    private TableColumn<User, String> idUserColumn;
    @FXML
    private TableColumn<User, String> nameUserColumn;
    @FXML
    private TableColumn<User, String> passUserColumn;
    @FXML
    private TextField idUserText;
    @FXML
    private TextField nameUserText;
    @FXML
    private TextField passUserText;
    @FXML
    private TextField searchKH;

//  Room
    @FXML
    private TableColumn<Room, String> idRoomColumn;
    @FXML
    private TableColumn<Room, String> statusRoomColumn;
    @FXML
    private TableColumn<Room, String> typeRoomColumn;
    @FXML
    private TableColumn<Room, String> UserEdColumn;
    @FXML
    private TextField idRoomText;
    @FXML
    private TextField typeRoomText;
    @FXML
    private TextField statusText;
    @FXML
    private TextField searchRoom;

// Admin
    @FXML
    private TableColumn<Admin, String> idAdminColumn;
    @FXML
    private TableColumn<Admin, String> nameAdminColumn;
    @FXML
    private TableColumn<Admin, String> passAdminColumn;
    @FXML
    private TextField idAdminText;
    @FXML
    private TextField nameAdminText;
    @FXML
    private TextField passAdminText;


    @FXML
    private TableView<User> table1;

    @FXML
    private TableView<Room> table2;

    @FXML
    private TableView<Admin> table3;

    ObservableList<User> tb_User = FXCollections.observableArrayList();

    ObservableList<Room> tb_Room = FXCollections.observableArrayList();

    ObservableList<Admin> tb_Admin = FXCollections.observableArrayList();

    ObservableList<Infor> tb_Ed = FXCollections.observableArrayList();


    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        // Khách hàng :
        idUserColumn.setCellValueFactory(new PropertyValueFactory<>("Id_User"));
        nameUserColumn.setCellValueFactory(new PropertyValueFactory<>("Name_User"));
        passUserColumn.setCellValueFactory(new PropertyValueFactory<>("pass"));
        table1.setItems(tb_User);
        table1.setOnMouseClicked(mouseEvent -> {
            User selected = table1.getSelectionModel().getSelectedItem();
            nameUserText.setText("" + selected.getName_User());
            idUserText.setText("" + selected.getId_User());
            passUserText.setText("" + selected.getPass());
        });

        // Tìm Kiếm khách hàng
        FilteredList<User> filteredKH = new FilteredList<>(tb_User, b -> true);
        searchKH.textProperty().addListener((observable, oldValue, newValue) -> {
            filteredKH.setPredicate(kh -> {
                if (newValue == null || newValue.isEmpty()) {
                    return true;
                }
                String lowerCaseFilter = newValue.toLowerCase();
                if (kh.getName_User().toLowerCase().contains(lowerCaseFilter)) {
                    return true;
                } else if (kh.getId_User().toLowerCase().contains(lowerCaseFilter)) {
                    return true;
                } ;
                return false;
            });
        });
        SortedList<User> sortedData = new SortedList<>(filteredKH);
        sortedData.comparatorProperty().bind(table1.comparatorProperty());
        table1.setItems(sortedData);

        // Room
        idRoomColumn.setCellValueFactory(new PropertyValueFactory<>("Id_Room"));
        typeRoomColumn.setCellValueFactory(new PropertyValueFactory<>("type"));
        statusRoomColumn.setCellValueFactory(new PropertyValueFactory<>("status"));
        UserEdColumn.setCellValueFactory(new PropertyValueFactory<>("Id_User"));

        table2.setItems(tb_Room);
        table2.setOnMouseClicked(mouseEvent -> {
            Room selected = table2.getSelectionModel().getSelectedItem();
            idRoomText.setText("" + selected.getId_Room());
            typeRoomText.setText("" + selected.getType());
            statusText.setText("" + selected.getStatus());
        });

        // Tìm Kiếm room
        FilteredList<Room> filteredRoom = new FilteredList<>(tb_Room, b -> true);
        searchRoom.textProperty().addListener((observable, oldValue, newValue) -> {
            filteredRoom.setPredicate(room -> {
                if (newValue == null || newValue.isEmpty()) {
                    return true;
                }
                String lowerCaseFilter = newValue.toLowerCase();
                if (room.getId_Room().toLowerCase().contains(lowerCaseFilter)) {
                    return true;
                } else if (String.valueOf(room.getStatus()).contains(lowerCaseFilter)) {
                    return true;
                } else return room.getType().toLowerCase().contains(lowerCaseFilter);
            });
        });
        SortedList<Room> sortedData2 = new SortedList<>(filteredRoom);
        sortedData2.comparatorProperty().bind(table2.comparatorProperty());
        table2.setItems(sortedData2);

        // Admin
        idAdminColumn.setCellValueFactory(new PropertyValueFactory<>("Id"));
        nameAdminColumn.setCellValueFactory(new PropertyValueFactory<>("Name"));
        passAdminColumn.setCellValueFactory(new PropertyValueFactory<>("Pass"));
        table3.setItems(tb_Admin);
        table3.setOnMouseClicked(mouseEvent -> {
            Admin selected = table3.getSelectionModel().getSelectedItem();
            idAdminText.setText("" + selected.getId());
            nameAdminText.setText("" + selected.getName());
            passAdminText.setText("" + selected.getPass());
        });

        allUser();
        allRoom();
        allAdmin();
    }


    // Kết nối
    public Admin_CT(){
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databasename=QuanLyKS;"
                    + "username=sa;password=1");
            System.out.println("Thành công ");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Điều chỉnh
    public  void Detail(ActionEvent e) throws IOException {
        Stage stage = (Stage)((Node) e.getSource()).getScene().getWindow();
        FXMLLoader loader = new FXMLLoader();
        loader.setLocation(getClass().getResource("/sample/Layout/User.fxml"));
        Parent studentViewParent = loader.load();
        Scene scene = new Scene(studentViewParent);
        Admin_User_CT controller = loader.getController();
        User selected = table1.getSelectionModel().getSelectedItem();
        controller.set(selected);
        controller.Read_SQL();
        stage.setScene(scene);
        System.out.println("Detail");
    }


    // Quản Lý người dùng

    public  void allUser(){
        tb_User.clear();
        String sql = "SELECT * FROM [User]";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                User s = new User();
                s.setId_User(rs.getString("Id_User"));
                s.setName_User(rs.getString("Name_User"));
                s.setPass(rs.getString("pass"));
                tb_User.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        nameUserText.setText("");
        idUserText.setText("");
        passUserText.setText("");

    }


    public void AddUser() // thêm vào màn hình và cả database
    {
        String sql = "INSERT INTO [User](Id_User,Name_User,pass)"
            +" VALUES(?,?,?)";
        String Id_User = idUserText.getText();
        String Name_User = nameUserText.getText();
        String pass = passUserText.getText();
        User k = new User(Id_User,Name_User,pass);
        tb_User.add(k);
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, Id_User);
            pst.setString(2, Name_User);
            pst.setString(3, pass);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
       allUser();
    }

    public  void allEd(){
        tb_Ed.clear();
        String sql = "SELECT * FROM [User_Ed]  ";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Infor s = new Infor();
                s.setId_User(rs.getString("Id_User"));
                s.setId_Room(rs.getString("Id_Room"));
                tb_Ed.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public String searchUser(String Id_Room){
        allEd();
        for(Infor k : tb_Ed){
            if(k.getId_Room().equals(Id_Room)){
               return k.getId_User();
            }
        }
        return "";
    }

    List<String> Room_ed = new ArrayList<>();
    public void searchRoom(String Id_User){
        allEd();
        for(Infor k : tb_Ed){
            if(k.getId_User().equals(Id_User)){
                Room_ed.add(k.getId_Room());
            }
        }
    }

    public void DeleteUser() {
        //Xoá user mà user đang thuê phòng thì phải update lại cả trạng thái của phòng là 0
        searchRoom(idUserText.getText());
        for(String k : Room_ed){
            String sl = "Update [KhachSan] set  status= ?   where Id_Room=?";
            try {
                PreparedStatement pst = con.prepareStatement(sl);
                pst.setString(1, "0");
                pst.setString(2,k);
                pst.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        Room_ed.clear();
//      sau khi cập nhật lại trạng thái thì xoá user đó khỏi user_ed
        String sq = "DELETE FROM [User_Ed] where Id_User=?";
        String Id_Usered = idUserText.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sq);
            pst.setString(1, Id_Usered);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
//        Xoá ở bảng chính
        String sql = "DELETE FROM [User] where Id_User=?";
        String Id_User = idUserText.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sql);

            pst.setString(1, Id_User);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        allUser();
        allRoom();

        User selected = table1.getSelectionModel().getSelectedItem();
        tb_User.remove((selected));

    }
    public void EditUser() {
        String sql = "Update [User] set  Name_User= ?, pass = ?   where Id_User=?";
        String Id_User = idUserText.getText();
        String Name_User = nameUserText.getText();
        String pass = passUserText.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, Name_User);
            pst.setString(2,pass);
            pst.setString(3, Id_User);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        allUser();
    }

    // Quản lý phòng
    public void AddRoom() // thêm vào màn hình vả cả database
    {
        String sql = "INSERT INTO KhachSan(Id_Room,type,status)"
                +" VALUES(?,?,?)";
        String Id_Room = idRoomText.getText();
        String type = typeRoomText.getText();
        String status = "0";
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, Id_Room);
            pst.setString(2, type);
            pst.setString(3,status);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        allRoom();
    }
    public void DeleteRoom() {
        String sq = "DELETE FROM [User_Ed] where Id_Room=?";
        String Id_M = idRoomText.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sq);

            pst.setString(1, Id_M);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        String sql = "DELETE FROM KhachSan where Id_Room=?";
        String Id_Room = idRoomText.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sql);

            pst.setString(1, Id_Room);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        allRoom();

    }
    public void EditRoom()
    {
        String sql = "Update KhachSan set  type= ?, status=? where Id_Room=?";
        String Id_Room = idRoomText.getText();
        String type = typeRoomText.getText();
        String status = statusText.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, type);
            pst.setString(2,status);
            pst.setString(3, Id_Room);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        allRoom();
    }
    public  void allRoom(){
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
                s.setId_User(searchUser(rs2.getString("Id_Room")));
                tb_Room.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        idRoomText.setText("");
        typeRoomText.setText("");
        statusText.setText("");
    }
    public void locPhongKoTrong(ActionEvent event)
    {
        tb_Room.clear();
        String sql2 = "SELECT * FROM KhachSan where status=1";
        try {
            PreparedStatement ps2 = con.prepareStatement(sql2);
            ResultSet rs2 = ps2.executeQuery();
            while(rs2.next()){
                Room s = new Room();
                s.setId_Room(rs2.getString("Id_Room"));
                s.setType(rs2.getString("type"));
                s.setStatus(rs2.getString("status"));
                s.setId_User(searchUser(rs2.getString("Id_Room")));
                tb_Room.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
     }
    public void locPhongTrong(ActionEvent event){
        tb_Room.clear();
        String sql2 = "SELECT * FROM KhachSan where status=0";
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
    }


    // Quản lý Admin

    public  void allAdmin(){
        tb_Admin.clear();
        String sql3 = "SELECT * FROM Admin";
        try {
            PreparedStatement ps3 = con.prepareStatement(sql3);
            ResultSet rs3 = ps3.executeQuery();
            while(rs3.next()){
                Admin s = new Admin();
                s.setId(rs3.getString("Id"));
                s.setName(rs3.getString("Name"));
                s.setPass(rs3.getString("Pass"));
                tb_Admin.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        idAdminText.setText("");
        nameAdminText.setText("");
        passAdminText.setText("");

    }

    public void addAdmin() // thêm vào màn hình vả cả database
    {
        String sql = "INSERT INTO Admin(Id,Name,Pass)"
                +" VALUES(?,?,?)";
        String ID = idAdminText.getText();
        String Name = nameAdminText.getText();
        String Pass = passAdminText.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, ID);
            pst.setString(2, Name);
            pst.setString(3,Pass);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        allAdmin();
    }
    public void deleteAdmin() {

        String sql = "DELETE FROM Admin where Id=?";
        String Id = idAdminText.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, Id);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        allAdmin();

    }
    public void editAdmin()
    {
        String sql = "Update Admin set  Name= ?, Pass=? where Id=?";
        String Id = idAdminText.getText();
        String Name = nameAdminText.getText();
        String Pass = passAdminText.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, Name);
            pst.setString(2,Pass);
            pst.setString(3, Id);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        allAdmin();
    }

    public void Logout (ActionEvent event ) throws IOException {
            Stage stage = (Stage)((Node) event.getSource()).getScene().getWindow();
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(getClass().getResource("/sample/Layout/Login.fxml"));
            Parent sampleParent = loader.load();
            Scene scene = new Scene(sampleParent);
            stage.setScene(scene);
            stage.setTitle("Welcome");
    }
}
