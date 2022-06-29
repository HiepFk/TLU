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
import sample.Dm.MonHoc;
import sample.Dm.SinhVien;
import sample.Dm.SinhVien_ed;

import java.io.IOException;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ResourceBundle;

public class Admin_SV_CT implements Initializable {
    private Connection con;

    @FXML
    private TableView<SinhVien_ed> table_ed;

    @FXML
    private TableColumn<SinhVien_ed, String> id_ed;

    @FXML
    private TableColumn<SinhVien_ed, String> name_ed;

    @FXML
    private TableColumn<SinhVien_ed, String> diem;

    @FXML
    private TableColumn<SinhVien_ed, String> tinChi_ed;

    @FXML
    private Text nameSvText;

    @FXML
    private Text idSvText;

    @FXML
    private Text gpaSVText;

    @FXML
    private Text sumText;

    @FXML
    private TableView<MonHoc> table_not_ed;

    @FXML
    private TableColumn<MonHoc, String> id_notEd;

    @FXML
    private TableColumn<MonHoc, String> name_notEd;

    @FXML
    private TableColumn<MonHoc, String> tinChi_notEd;

    @FXML
    private TextField diemText;


    ObservableList<MonHoc> tb_MH_not_ed = FXCollections.observableArrayList();

    ObservableList<MonHoc> tb_Mh = FXCollections.observableArrayList();

    ObservableList<SinhVien_ed> tb_MH_ed = FXCollections.observableArrayList();

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        id_ed.setCellValueFactory(new PropertyValueFactory<>("Id_Mh_ed"));
        name_ed.setCellValueFactory(new PropertyValueFactory<>("Name_Mh_ed"));
        diem.setCellValueFactory(new PropertyValueFactory<>("diem"));
        tinChi_ed.setCellValueFactory(new PropertyValueFactory<>("TC_ed"));
        table_ed.setItems(tb_MH_ed);

        id_notEd.setCellValueFactory(new PropertyValueFactory<>("Id_Mh"));
        name_notEd.setCellValueFactory(new PropertyValueFactory<>("Name_Mh"));
        tinChi_notEd.setCellValueFactory(new PropertyValueFactory<>("TinChi"));
        table_not_ed.setItems(tb_MH_not_ed);

    }

    // Kết nối
    public Admin_SV_CT() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databasename=QuanLySV;"
                    + "username=sa;password=1");
            System.out.println("Thành công ");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void DangKi() {
        String sql = "INSERT INTO Table_SV_ed(Id_Sv,Id_Mh,point)"
                + " VALUES(?,?,?)";
        MonHoc selected = table_not_ed.getSelectionModel().getSelectedItem();
        String Id_Sv = idSvText.getText();
        String Id_Mh = selected.getId_Mh();
        double point = 0;
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

    public void HuyMon() {
        String sql = "DELETE FROM Table_SV_ed where Id_Mh=? and Id_Sv=? ";
        SinhVien_ed selected = table_ed.getSelectionModel().getSelectedItem();
        String Id_Mh = selected.getId_Mh_ed();
        String Id_Sv = idSvText.getText();
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

    public void NhapDiem() {
        String sql = "Update Table_Sv_ed set  Point=?  where Id_Mh=? and Id_Sv=?";
        String Id_Sv = idSvText.getText();
        SinhVien_ed selected = table_ed.getSelectionModel().getSelectedItem();
        String Id_Mh = selected.getId_Mh_ed();
        double Point = Double.parseDouble(diemText.getText());

        try {
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setDouble(1, Point);
            pst.setString(2, Id_Mh);
            pst.setString(3, Id_Sv);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        Read_SQL();
        diemText.setText("");
    }

    public void set(SinhVien sv) {
        nameSvText.setText(String.valueOf(sv.getName_Sv()));
        idSvText.setText(String.valueOf(sv.getId_Sv()));
    }

    public void goBack(ActionEvent e) throws IOException {
        Stage stage = (Stage) ((Node) e.getSource()).getScene().getWindow();
        FXMLLoader loader = new FXMLLoader();
        loader.setLocation(getClass().getResource("/sample/Layout/Admin.fxml"));
        Parent sampleParent = loader.load();
        Scene scene = new Scene(sampleParent);
        stage.setScene(scene);
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
        String Id_Sv = idSvText.getText();

        try {
            PreparedStatement ps = con.prepareStatement(sql);
          ps.setString(1 , Id_Sv);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SinhVien_ed s = new SinhVien_ed();
                s.setId_Mh_ed(rs.getString("Id_Mh"));
                s.setName_Mh_ed(timMon(rs.getString("Id_Mh")).getName_Mh());
                s.setDiem(Float.parseFloat(rs.getString("Point")));
                s.setTC_ed(timMon(rs.getString("Id_Mh")).getTinChi());
                tb_MH_ed.add(s);

                dem =dem +1;
                float diem = Float.parseFloat(rs.getString("Point")); Sum_diem=Sum_diem+diem;
                int tin = Integer.parseInt(timMon(rs.getString("Id_Mh")).getTinChi()); Sum_tiChi=Sum_tiChi+tin;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        gpaSVText.setText(String.valueOf(Sum_diem/dem));
        sumText.setText(String.valueOf(Sum_tiChi));

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
