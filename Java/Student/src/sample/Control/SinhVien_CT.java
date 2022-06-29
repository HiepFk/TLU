package sample.Control;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.text.Text;
import javafx.stage.Stage;
import sample.Dm.*;
import javafx.fxml.FXML;

import java.io.IOException;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ResourceBundle;

public class SinhVien_CT implements Initializable {
    private Connection con;

    @FXML
    private TableView<SinhVien_ed> table3;

    @FXML
    private TableColumn<SinhVien_CT, String> idMon_ed;

    @FXML
    private TableColumn<SinhVien_CT, String> nameMon_ed;

    @FXML
    private TableColumn<SinhVien_CT, Float> diemMon_ed;

    @FXML
    private TableColumn<SinhVien_CT, Integer> tinChi_ed;

    @FXML
    private TableView<MonHoc> table4;

    @FXML
    private TableColumn<MonHoc, String> idMon;

    @FXML
    private TableColumn<MonHoc, String> nameMon;

    @FXML
    private TableColumn<MonHoc, String> tinChi;

    @FXML
    private Text nameSv_text;

    @FXML
    private Text idSv_text;

    @FXML
    private Text gpa_text;

    @FXML
    private Text tinChi_text;

    ObservableList<MonHoc> tb_MH_not_ed = FXCollections.observableArrayList();

    ObservableList<MonHoc> tb_Mh = FXCollections.observableArrayList();

    ObservableList<SinhVien_ed> tb_MH_ed = FXCollections.observableArrayList();

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        idMon.setCellValueFactory(new PropertyValueFactory<>("Id_Mh"));
        nameMon.setCellValueFactory(new PropertyValueFactory<>("Name_Mh"));
        tinChi.setCellValueFactory(new PropertyValueFactory<>("TinChi"));
        table4.setItems(tb_MH_not_ed);

        idMon_ed.setCellValueFactory(new PropertyValueFactory<>("Id_Mh_ed"));
        nameMon_ed.setCellValueFactory(new PropertyValueFactory<>("Name_Mh_ed"));
        tinChi_ed.setCellValueFactory(new PropertyValueFactory<>("TC_ed"));
        diemMon_ed.setCellValueFactory(new PropertyValueFactory<>("diem"));
        table3.setItems(tb_MH_ed);

    }

    public SinhVien_CT() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databasename=QuanLySV;"
                    + "username=sa;password=1");
            System.out.println("Thành công ");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void set(String k) {
        idSv_text.setText(k);
        String sql2 = "SELECT * FROM Table_Sv where Id_Sv=?";
        String Id_Sv = idSv_text.getText();
        try {
            PreparedStatement ps2 = con.prepareStatement(sql2);
            ps2.setString(1 , Id_Sv);
            ResultSet rs2 = ps2.executeQuery();
            while(rs2.next()){
                nameSv_text.setText(rs2.getString("Name_Sv"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public  void Dk()
    {
        String sql = "INSERT INTO Table_SV_ed(Id_Sv,Id_Mh,point)"
                + " VALUES(?,?,?)";
        MonHoc selected =table4.getSelectionModel().getSelectedItem();
        String Id_Sv = idSv_text.getText();
        String Id_Mh = selected.getId_Mh();
        double point =  0;
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, Id_Sv);
            pst.setString(2, Id_Mh);
            pst.setDouble(3, point);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        tb_MH_not_ed.remove(selected);
        Read_SQL();
    }
    public  void HuyMon()
    {
        String sql = "DELETE FROM Table_SV_ed where Id_Mh=? and Id_Sv=? ";
        SinhVien_ed selected = table3.getSelectionModel().getSelectedItem();
        String Id_Mh = selected.getId_Mh_ed();
        String Id_Sv = idSv_text.getText();
        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, Id_Mh);
            pst.setString(2, Id_Sv);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        Read_SQL();
    }
    public void Logout_ed (ActionEvent event ) throws IOException {
        Stage stage = (Stage)((Node) event.getSource()).getScene().getWindow();
        FXMLLoader loader = new FXMLLoader();
        loader.setLocation(getClass().getResource("/sample/Layout/Login.fxml"));
        Parent sampleParent = loader.load();
        Scene scene = new Scene(sampleParent);
        stage.setScene(scene);
        stage.setTitle("Welcome");
    }

    public MonHoc timMon(String id_mh )
    {
        MonHoc l = new MonHoc();
        for(MonHoc k : tb_Mh)
        {
            if(k.getId_Mh().equals(id_mh))
            {
                return k ;
            }
        }
        return l  ;
    }

    public String timMon2(String id_mh )
    {
        for(SinhVien_ed k : tb_MH_ed)
        {
            if(k.getId_Mh_ed().equals(id_mh))
            {
                return k.getId_Mh_ed() ;
            }
        }
        return "dm"  ;
    }

    public void Read_SQL() {
        int dem =0;
        float Sum_diem=0;
        int Sum_tiChi = 0 ;

        // Đọc all môn học
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

        // Đọc sinh viên ed , và danh sách môn đã đăng kí
        tb_MH_ed.clear();
        String sql = "SELECT * FROM Table_SV_ed where Id_Sv=? ";
        String Id_Sv = idSv_text.getText();

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1 , Id_Sv);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SinhVien_ed s = new SinhVien_ed();
                s.setId_Mh_ed(rs.getString("Id_Mh"));
                s.setName_Mh_ed(timMon(rs.getString("Id_Mh")).getName_Mh());

                dem =dem +1;
                float diem = Float.parseFloat(rs.getString("Point")); Sum_diem=Sum_diem+diem;
                int tin = Integer.parseInt(timMon(rs.getString("Id_Mh")).getTinChi()); Sum_tiChi=Sum_tiChi+tin;

                s.setDiem(diem);
                s.setTC_ed(timMon(rs.getString("Id_Mh")).getTinChi());
                tb_MH_ed.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        gpa_text.setText(String.valueOf(Sum_diem/dem));
        tinChi_text.setText(String.valueOf(Sum_tiChi));

        //Đọc  môn học chưa đăng kí
        tb_MH_not_ed.clear();
        for(MonHoc k : tb_Mh)
        {
            if(k.getId_Mh().compareTo(timMon2(k.getId_Mh()) ) !=0)
            {
                tb_MH_not_ed.add(k);
            }
        }
    }

}