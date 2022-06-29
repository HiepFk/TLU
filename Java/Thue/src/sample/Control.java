package sample;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.text.Text;
import java.net.URL;
import java.text.DecimalFormat;
import java.util.ResourceBundle;

public class Control<group> implements Initializable  {

    @FXML
    private RadioButton nam ;

    @FXML
    private RadioButton nu ;

    @FXML
    private TextField tienText;

    @FXML
    private TextField nguoiText;

    @FXML
    private Text thueText;

    @FXML
    private TableView<Table> Bang;

    @FXML
    private TableColumn<Table, Integer> bacColumn;

    @FXML
    private TableColumn<Table, String> thuNhapColumn;

    @FXML
    private TableColumn<Table, String> thueSuatColumn;

    @FXML
    private ListView<String> bangPro;

    ObservableList<String> CacTinh = FXCollections.observableArrayList();

    //Hiển thị số đẹp
    DecimalFormat decimalFormat = new DecimalFormat("###,###.###");
    double tien=0;

    ObservableList<Table> tb1 = FXCollections.observableArrayList(
            new Table(1, "0 đến 5 ","5%"),
            new Table(2, "Trên 5 đến 10","10%"),
            new Table(3, "Trên 10 đến 18","15%"),
            new Table(4, "Trên 18 đến 32","20%"),
            new Table(5, "Trên 32 đến 52","25%"),
            new Table(6, "Trên 52 đến 80","30%"),
            new Table(7, "Trên 80 ","35%")
    );
    ObservableList<Table> tb2 = FXCollections.observableArrayList(
            new Table(1, "0 đến 60 ","5%"),
            new Table(2, "Trên 60 đến 120","10%"),
            new Table(3, "Trên 120 đến 216","15%"),
            new Table(4, "Trên 216 đến 384","20%"),
            new Table(5, "Trên 384 đến 624","25%"),
            new Table(6, "Trên 624 đến 960","30%"),
            new Table(7, "Trên 960 ","35%")
    );

    @FXML
    void setToggle(ActionEvent event){
        // ToggleGroup: trong cg 1 nhóm 1 thời điểm chỉ được chọn 1 lần
        ToggleGroup dm = new ToggleGroup();
        nam.setToggleGroup(dm);
        nu.setToggleGroup(dm);
        if(nam.isSelected())
        {
            {Bang.setItems(tb1);}
        }
        if(nu.isSelected())
        {
            {Bang.setItems(tb2);}
        }

    }

    public void initialize(URL url, ResourceBundle resourceBundle) {
        bacColumn.setCellValueFactory(new PropertyValueFactory<>("Bac"));
        thuNhapColumn.setCellValueFactory(new PropertyValueFactory<>("thuNhap"));
        thueSuatColumn.setCellValueFactory(new PropertyValueFactory<>("thuSuat"));
        thueText.setText("0 Đồng");
        bangPro.setItems(CacTinh);
    }

    @FXML
    public void LamDepSo(){
        tien = Double.parseDouble(tienText.getText());
        tienText.setText(decimalFormat.format(tien));
    }

    public void Reset()
    {
        tienText.setText("");
        nguoiText.setText("");
        thueText.setText("0 Đồng");
        CacTinh.clear();
    }

    public void Tinh() {
        try{
        LamDepSo();
        CacTinh.clear();
        long Tong = 0, nguoi = 0;
        int dem = 0;
        int a =1 ;
        if (nguoiText.getText().equals("")) {
                nguoi = 0;
                nguoiText.setText("0");
            }else{
                nguoi = Long.parseLong(nguoiText.getText());
            }
        if(nam.isSelected()){a=1;}
        else{a=12;}
        long tienChiuThue = (long) (tien - nguoi * 4400000*a - 11000000*a);
        long[]S = {0, 5000000*a, 10000000*a, 18000000*a, 32000000*a, 52000000*a, 80000000*a};
        double[] P = {0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35};
                if (tienChiuThue <= 0) {
                    CacTinh.add("Không phải nộp");
                    thueText.setText("0 Đồng");
                } else {
                    CacTinh.add("Giảm trừ bản thân : "+ decimalFormat.format(11000000*a) +"đồng");
                    CacTinh.add("Giảm trừ người phụ thuộc : " + nguoi+"* " +decimalFormat.format(4400000*a)+ " = " + decimalFormat.format(nguoi * 4400000*a) + " đồng");
                    CacTinh.add("Tiền chịu thuế : " + decimalFormat.format(tien) +" - "+ decimalFormat.format(11000000*a) +" - "+ decimalFormat.format(nguoi *a* 4400000)  + " = " + decimalFormat.format(tienChiuThue) + " đồng");
                    CacTinh.add("Tiền thuế từng bậc : ");
                    while (tienChiuThue > S[dem]) {
                        if (tienChiuThue < S[dem + 1]) {
                            break;
                        }
                        Tong = (long) (P[dem] * (S[dem + 1] - S[dem]) + Tong);
                        CacTinh.add("Bậc " + (dem + 1) + ":  (" + decimalFormat.format(S[dem + 1]) + " - " + decimalFormat.format(S[dem]) + " )* " + P[dem] + " = " + decimalFormat.format((S[dem + 1] - S[dem]) * P[dem]) + " đồng");
                        dem++;
                        if (dem == 6) {
                            break;
                        }
                    }
                    Tong = (long) ((tienChiuThue - S[dem]) * P[dem] + Tong);
                    CacTinh.add("Bậc " + (dem + 1) + ":  (" + decimalFormat.format(tienChiuThue) + " - " + decimalFormat.format(S[dem]) + " )* " + P[dem] + " = " + decimalFormat.format((tienChiuThue - S[dem]) * P[dem]) + " đồng");
                    CacTinh.add("Tổng tiền phải nộp : " + decimalFormat.format(Tong) + " Đồng");
                    thueText.setText(decimalFormat.format(Tong) + " Đồng");
                    if(a==1){CacTinh.add("Năm : " + decimalFormat.format(Tong*12) + " Đồng"); }
                    else{CacTinh.add("Tháng : " + decimalFormat.format(Tong/12) + " Đồng"); }
                }
        }catch (NumberFormatException e){
            Alert alert = new Alert(Alert.AlertType.WARNING,"Nhập sai\n");
            alert.show();
        }
    }
}
