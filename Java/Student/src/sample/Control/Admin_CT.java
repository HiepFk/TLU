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
import sample.Dm.MonHoc;
import sample.Dm.SinhVien;
import sample.Dm.SinhVien_ed;
import sample.Dm.User;

import java.io.*;
import java.net.URL;
import java.sql.*;
import java.util.ResourceBundle;

public class Admin_CT implements Initializable {
    private Connection con ;


    // Quản lý Sinh viên
    @FXML
    private TableView<SinhVien> table1;
    @FXML
    private TableColumn<SinhVien, String> idColumn;
    @FXML
    private TableColumn<SinhVien, String> nameSvColumn;
    @FXML
    private TableColumn<SinhVien, String> passColumn;
    @FXML
    private TableColumn<SinhVien, String> classColumn;
    @FXML
    private TableColumn<SinhVien, String> gpaCoulm;

    @FXML
    private TextField iDtext;

    @FXML
    private TextField nameText;

    @FXML
    private TextField passText;

    @FXML
    private TextField lopText;

    @FXML
    private TextField searchSv;

    // Quản lý Môn học
    @FXML
    private TableView<MonHoc> table2;

    @FXML
    private TableColumn<MonHoc, String> maMhColumn;

    @FXML
    private TableColumn<MonHoc, String> tenMhColumn;

    @FXML
    private TableColumn<MonHoc, Integer> tinChiColumn;

    @FXML
    private TextField idMhText;

    @FXML
    private TextField tenMhText;

    @FXML
    private TextField tinChiText;

    @FXML
    private TextField searchMh;

    // Quản lý User
    @FXML
    private TableView<User> table3;

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

    ObservableList<SinhVien> tb_Sv = FXCollections.observableArrayList();

    ObservableList<SinhVien_ed> tb_ed = FXCollections.observableArrayList();

    ObservableList<MonHoc> tb_Mh = FXCollections.observableArrayList();

    ObservableList<User> tb_User = FXCollections.observableArrayList();


    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        // Sinh Viên :
        idColumn.setCellValueFactory(new PropertyValueFactory<>("Id_Sv"));
        nameSvColumn.setCellValueFactory(new PropertyValueFactory<>("Name_Sv"));
        passColumn.setCellValueFactory(new PropertyValueFactory<>("Mk"));
        classColumn.setCellValueFactory(new PropertyValueFactory<>("Lop"));
        gpaCoulm.setCellValueFactory(new PropertyValueFactory<>("Gpa"));
        tinChiColumn.setCellValueFactory(new PropertyValueFactory<>("sum_tin"));
        table1.setItems(tb_Sv);
        table1.setOnMouseClicked(mouseEvent -> {

            SinhVien selected = table1.getSelectionModel().getSelectedItem();
            nameText.setText("" + selected.getName_Sv());
            iDtext.setText("" + selected.getId_Sv());
            passText.setText("" + selected.getMk());
            lopText.setText(""+selected.getLop());

        });

        // Tìm Kiếm sinh viên
        FilteredList<SinhVien> filteredSV = new FilteredList<>(tb_Sv, b -> true);
        searchSv.textProperty().addListener((observable, oldValue, newValue) -> {
            filteredSV.setPredicate(sv -> {
                if (newValue == null || newValue.isEmpty()) {
                    return true;
                }
                String lowerCaseFilter = newValue.toLowerCase();
                if (sv.getName_Sv().toLowerCase().contains(lowerCaseFilter)) {
                    return true;
                } else if (sv.getLop().toLowerCase().contains(lowerCaseFilter)) {
                    return true;
                } else if (sv.getGpa().toLowerCase().contains(lowerCaseFilter)) {
                    return true;
                } else return sv.getId_Sv().toLowerCase().contains(lowerCaseFilter);
            });
        });
        SortedList<SinhVien> sortedData = new SortedList<>(filteredSV);
        sortedData.comparatorProperty().bind(table1.comparatorProperty());
        table1.setItems(sortedData);

        // Môn Học
        maMhColumn.setCellValueFactory(new PropertyValueFactory<>("Id_Mh"));
        tenMhColumn.setCellValueFactory(new PropertyValueFactory<>("Name_Mh"));
        tinChiColumn.setCellValueFactory(new PropertyValueFactory<>("TinChi"));
        table2.setItems(tb_Mh);
        table2.setOnMouseClicked(mouseEvent -> {
            MonHoc selected = table2.getSelectionModel().getSelectedItem();
            tenMhText.setText("" + selected.getName_Mh());
            idMhText.setText("" + selected.getId_Mh());
            tinChiText.setText("" + selected.getTinChi());

        });

        // Tìm Kiếm môn học
        FilteredList<MonHoc> filteredMh = new FilteredList<>(tb_Mh, b -> true);
        searchMh.textProperty().addListener((observable, oldValue, newValue) -> {
            filteredMh.setPredicate(mh -> {
                if (newValue == null || newValue.isEmpty()) {
                    return true;
                }
                String lowerCaseFilter = newValue.toLowerCase();
                if (mh.getName_Mh().toLowerCase().contains(lowerCaseFilter)) {
                    return true;
                } else if (String.valueOf(mh.getTinChi()).contains(lowerCaseFilter)) {
                    return true;
                } else return mh.getId_Mh().toLowerCase().contains(lowerCaseFilter);
            });
        });
        SortedList<MonHoc> sortedData2 = new SortedList<>(filteredMh);
        sortedData2.comparatorProperty().bind(table2.comparatorProperty());
        table2.setItems(sortedData2);

        // User
        idUserColumn.setCellValueFactory(new PropertyValueFactory<>("Id_User"));
        nameUserColumn.setCellValueFactory(new PropertyValueFactory<>("Name_User"));
        passUserColumn.setCellValueFactory(new PropertyValueFactory<>("pass_User"));
        table3.setItems(tb_User);
        table3.setOnMouseClicked(mouseEvent -> {
            User selected = table3.getSelectionModel().getSelectedItem();
            idUserText.setText("" + selected.getId_User());
            nameUserText.setText("" + selected.getName_User());
            passUserText.setText("" + selected.getPass_User());
        });

        Read_SQL();
    }

    // Kết nối
    public Admin_CT(){
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databasename=QuanLySV;"
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
        loader.setLocation(getClass().getResource("/sample/Layout/Admin_SV.fxml"));
        Parent studentViewParent = loader.load();
        Scene scene = new Scene(studentViewParent);
        Admin_SV_CT controller = loader.getController();
        SinhVien selected = table1.getSelectionModel().getSelectedItem();
        controller.set(selected);
        controller.Read_SQL();
        stage.setScene(scene);
    }

    // Quản Lý Sinh viên
    public void Add() // thêm vào màn hình và cả database
    {
        String sql = "INSERT INTO Table_Sv(Id_Sv,Name_Sv,pass,lop)"
            +" VALUES(?,?,?,?)";
        String Id_Sv = iDtext.getText();
        String Name_Sv = nameText.getText();
        String pass = passText.getText();
        String lop = lopText.getText();
        SinhVien k = new SinhVien(Id_Sv,Name_Sv);
        tb_Sv.add(k);
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, Id_Sv);
            pst.setString(2, Name_Sv);
            pst.setString(3,pass);
            pst.setString(4, lop);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        Read_SQL();
    }
    public void Delete() {
        String sq = "DELETE FROM Table_SV_ed where Id_Sv=?";
        String Id_S = iDtext.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sq);
            pst.setString(1, Id_S);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        String sql = "DELETE FROM Table_Sv where Id_Sv=?";
        String Id_Sv = iDtext.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sql);

            pst.setString(1, Id_Sv);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        Read_SQL();

        SinhVien selected = table1.getSelectionModel().getSelectedItem();
        tb_Sv.remove((selected));

    }
    public void Edit() {
        String sql = "Update Table_Sv set  Name_Sv= ?, pass = ? , lop = ?  where Id_Sv=?";
        String Id_Sv = iDtext.getText();
        String Name_Sv = nameText.getText();
        String pass = passText.getText();
        String lop = lopText.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, Name_Sv);
            pst.setString(2,pass);
            pst.setString(3, lop);
            pst.setString(4, Id_Sv);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        Read_SQL();
    }

    // Quản lý Môn Học
    public void AddMh() // thêm vào màn hình vả cả database
    {
        String sql = "INSERT INTO Table_Mh(Id_Mh,Name_Mh,tinChi)"
                +" VALUES(?,?,?)";
        String Id_Mh = idMhText.getText();
        String Name_Mh = tenMhText.getText();
        int tinChi = Integer.parseInt(tinChiText.getText());
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, Id_Mh);
            pst.setString(2, Name_Mh);
            pst.setInt(3,tinChi);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        Read_SQL();
    }
    public void DeleteMh() {
        String sq = "DELETE FROM Table_SV_ed where Id_Mh=?";
        String Id_M = idMhText.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sq);

            pst.setString(1, Id_M);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        String sql = "DELETE FROM Table_Mh where Id_Mh=?";
        String Id_Mh = idMhText.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sql);

            pst.setString(1, Id_Mh);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        Read_SQL();

    }
    public void EditMh()
    {
        String sql = "Update Table_Mh set  Name_Mh= ?, tinChi=? where Id_Mh=?";
        String Id_Mh = idMhText.getText();
        String Name_Mh = tenMhText.getText();
        int tinChi = Integer.parseInt(tinChiText.getText());
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, Name_Mh);
            pst.setInt(2,tinChi);
            pst.setString(3, Id_Mh);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        Read_SQL();
    }


    // Quản lý User
    public void add_User() // thêm vào màn hình vả cả database
    {
        String sql = "INSERT INTO Table_User(id_User,name_User,pass_User)"
                +" VALUES(?,?,?)";
        String id_User = idUserText.getText();
        String name_User = nameUserText.getText();
        String pass_User = passUserText.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, id_User);
            pst.setString(2, name_User);
            pst.setString(3,pass_User);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        Read_SQL();
    }
    public void delete_User() {

        String sql = "DELETE FROM Table_User where id_User=?";
        String id_User = idUserText.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, id_User);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        Read_SQL();

    }
    public void edit_User()
    {
        String sql = "Update Table_User set  name_User= ?, pass_User=? where id_User=?";
        String id_User = idUserText.getText();
        String name_User = nameUserText.getText();
        String pass_User = passUserText.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, name_User);
            pst.setString(2,pass_User);
            pst.setString(3, id_User);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        Read_SQL();
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


    public String gpa(String dm)
    {
        float Sum = 0 , dem =0;
        for(SinhVien_ed k : tb_ed){
            if(k.getId_Sv_ed().equals(dm))
            {
                Sum = Sum + k.getDiem();
                dem=dem+1;
            }
        }
        return String.valueOf(Sum/dem);
    }

    public void Read_SQL()
    {
        // Đọc trong sinh viên đã đk môn để lất tín chỉ và gpa
        tb_ed.clear();
        String sqldm = "SELECT * FROM Table_SV_ed ";
        try {
            PreparedStatement ps = con.prepareStatement(sqldm);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SinhVien_ed s = new SinhVien_ed();
                s.setId_Mh_ed(rs.getString("Id_Mh"));
                s.setId_Sv_ed(rs.getString("Id_Sv"));
                s.setDiem(rs.getFloat("Point"));
                tb_ed.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Đọc sinh viên
        tb_Sv.clear();
        String sql = "SELECT * FROM Table_Sv";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                SinhVien s = new SinhVien();
                s.setId_Sv(rs.getString("Id_Sv"));
                s.setName_Sv(rs.getString("Name_Sv"));
                s.setMk(rs.getString("pass"));
                s.setLop(rs.getString("lop"));
                s.setGpa(gpa(rs.getString("Id_Sv")));
                tb_Sv.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        nameText.setText("");
        iDtext.setText("");
        passText.setText("");
        lopText.setText("");

        // Đọc môn học
        tb_Mh.clear();
        String sql2 = "SELECT * FROM Table_Mh";
        try {
            PreparedStatement ps2 = con.prepareStatement(sql2);
            ResultSet rs2 = ps2.executeQuery();
            while(rs2.next()){
                MonHoc s = new MonHoc();
                s.setId_Mh(rs2.getString("Id_Mh"));
                s.setName_Mh(rs2.getString("Name_Mh"));
                s.setTinChi(rs2.getString("tinChi"));
                tb_Mh.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        idMhText.setText("");
        tenMhText.setText("");
        tinChiText.setText("");

        // Đọc user
        tb_User.clear();
        String sql3 = "SELECT * FROM Table_User";
        try {
            PreparedStatement ps3 = con.prepareStatement(sql3);
            ResultSet rs3 = ps3.executeQuery();
            while(rs3.next()){
                User s = new User();
                s.setId_User(rs3.getString("id_User"));
                s.setName_User(rs3.getString("name_User"));
                s.setPass_User(rs3.getString("pass_User"));
                tb_User.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        idUserText.setText("");
        nameUserText.setText("");
        passUserText.setText("");
    }

}
