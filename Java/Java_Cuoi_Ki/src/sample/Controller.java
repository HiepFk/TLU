package sample;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;
import javafx.util.Callback;

import javax.swing.*;
import java.io.*;
import java.net.URL;
import java.util.*;

public class Controller implements Initializable {
    @FXML
    private TextField info_msv, info_tsv, info_mmh, info_tmh, info_diem, info_diemtb;
    @FXML
    private ListView<String> listViewSV, listViewDSSV;
    @FXML
    private ListView<String> listViewMH, listViewDSMH;

    List<SinhVien> sinhVienList = new ArrayList<>();
    List<MonHoc> monHocList = new ArrayList<>();
    List<SinhVien_MonHoc> sinhVienMonHocList = new ArrayList<>();

    ObservableList<String> dataSV = FXCollections.observableArrayList();
    ObservableList<String> dataMH = FXCollections.observableArrayList();
    ObservableList<String> dataSVfilter = FXCollections.observableArrayList();

    int pos1 = 999;
    int pos2 = 999;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle){
        //listViewSV
        for (int i = 0; i < sinhVienList.size(); i++){
            dataSV.add(sinhVienList.get(i).getTenSV() + " " + sinhVienList.get(i).getTenSV());
        }
        listViewSV.setItems(dataSV);

        listViewSV.setOnMouseClicked(new EventHandler<MouseEvent>() {
            @Override
            public void handle(MouseEvent mouseEvent) {

                ButtonType accept = new ButtonType("XÓA", ButtonBar.ButtonData.OK_DONE);
                ButtonType deny = new ButtonType("TRỞ LẠI", ButtonBar.ButtonData.CANCEL_CLOSE);
                Alert alert = new Alert(Alert.AlertType.WARNING,"Bạn có chắc chắn muốn xóa sinh viên \n"
                        + listViewSV.getSelectionModel().getSelectedItem(),
                        accept,
                        deny);
                alert.setTitle("Xác nhận XÓA");
                Optional<ButtonType> result = alert.showAndWait();

                if (result.orElse(deny) == accept) {
                    for (int i = 0; i < sinhVienList.size(); i++){
                        String compe = sinhVienList.get(i).getMaSV() + " " + sinhVienList.get(i).getTenSV();
                        if (compe.equals(listViewSV.getSelectionModel().getSelectedItem())){
                            sinhVienList.remove(i);
                            dataSV.remove(i);
                        }
                    }
                    System.out.println("XÓA");
                }else{
                    System.out.println("KO XÓA");
                }
            }
        });

        ////////////////////////////////////////////////////////////////////////////////
        //listViewMH
        for (int i = 0; i < monHocList.size(); i++){
            dataMH.add(monHocList.get(i).getMaMH() + " " + monHocList.get(i).getTenMH());
        }
        listViewMH.setItems(dataMH);

        listViewMH.setOnMouseClicked(new EventHandler<MouseEvent>() {
            @Override
            public void handle(MouseEvent mouseEvent) {

                ButtonType accept = new ButtonType("XÓA", ButtonBar.ButtonData.OK_DONE);
                ButtonType deny = new ButtonType("TRỞ LẠI", ButtonBar.ButtonData.CANCEL_CLOSE);
                Alert alert = new Alert(Alert.AlertType.WARNING,"Bạn có chắc chắn muốn xóa môn học \n"
                        + listViewMH.getSelectionModel().getSelectedItem(),
                        accept,
                        deny);
                alert.setTitle("Xác nhận XÓA");
                Optional<ButtonType> result = alert.showAndWait();

                if (result.orElse(deny) == accept) {
                    for (int i = 0; i < monHocList.size(); i++){
                        String compe = monHocList.get(i).getMaMH() + " " + monHocList.get(i).getTenMH();
                        if (compe.equals(listViewMH.getSelectionModel().getSelectedItem())){
                            monHocList.remove(i);
                            dataMH.remove(i);
                        }
                    }
                    System.out.println("XÓA");
                }else{
                    System.out.println("KO XÓA");
                }
            }
        });



        ////////////////////////////////////////////////////////////////////////////////
        //listViewDangKyHocSV
        listViewDSSV.setItems(dataSV);
        listViewDSSV.setOnMouseClicked(new EventHandler<MouseEvent>() {
            @Override
            public void handle(MouseEvent mouseEvent) {
                pos1 = listViewDSSV.getSelectionModel().getSelectedIndex();
               // System.out.println("pos1:" + pos1);

                dataMH.clear();
                for (int i = 0; i < monHocList.size(); i++){
                    dataMH.add(monHocList.get(i).getMaMH() + " " + monHocList.get(i).getTenMH());
                }
                listViewDSMH.setItems(dataMH);
            }
        });

        //ListViewDangKyHocMH
        listViewDSMH.setOnMouseClicked(new EventHandler<MouseEvent>() {
            @Override
            public void handle(MouseEvent mouseEvent) {
                pos2 = listViewDSMH.getSelectionModel().getSelectedIndex();
                //System.out.println("pos2:" + pos2);
            }
        });
    }

    public void btn_addSVClick(ActionEvent actionEvent) throws IOException {
        if (info_msv.getText().equals("") || info_tsv.getText().equals("")){
            Alert alert = new Alert(Alert.AlertType.INFORMATION);
            alert.setTitle("Lỗi");
            // Header Text: null
            alert.setHeaderText(null);
            alert.setContentText("Vui lòng nhập đầy đủ thông tin!");

            alert.showAndWait();
        }else{
            Boolean flag = true;
            for (SinhVien sv : sinhVienList) {
                if (info_msv.getText().equals(sv.getMaSV())){
                    flag = false;
                }
            }
            if (flag){
                sinhVienList.add(new SinhVien(info_msv.getText(), info_tsv.getText()));
                dataSV.add(info_msv.getText() + " " + info_tsv.getText());

                Alert alert = new Alert(Alert.AlertType.INFORMATION);
                alert.setTitle("Thành công");
                // Header Text: null
                alert.setHeaderText(null);
                alert.setContentText("Đã thêm sinh viên: " + info_tsv.getText());

                alert.showAndWait();

                info_msv.setText("");
                info_tsv.setText("");
            }else{
                ButtonType accept = new ButtonType("SỬA", ButtonBar.ButtonData.OK_DONE);
                ButtonType deny = new ButtonType("TRỞ LẠI", ButtonBar.ButtonData.CANCEL_CLOSE);
                Alert alert = new Alert(Alert.AlertType.INFORMATION,"Thông tin sinh viên \n"
                        + "Mã sinh viên: " + info_msv.getText() + "\nTên sinh viên: " + info_tsv.getText(),
                        accept,
                        deny);
                alert.setTitle("Sửa thông tin sinh viên " + info_msv.getText());
                Optional<ButtonType> result = alert.showAndWait();

                if (result.orElse(deny) == accept) {
                    for (int i = 0; i < sinhVienList.size(); i++){
                        if (sinhVienList.get(i).getMaSV().equals(info_msv.getText())){
                            sinhVienList.get(i).setTenSV(info_tsv.getText());
                            dataSV.remove(i);
                            dataSV.add(i, info_msv.getText() + " " + info_tsv.getText());
                        }
                    }
                    System.out.println("Sửa");
                }else{
                    System.out.println("KO Sửa");
                }
            }

            System.out.println("sinhVienList: ");
            for (int i = 0; i < sinhVienList.size(); i++){
                System.out.println(sinhVienList.get(i).getMaSV() + "-" + sinhVienList.get(i).getTenSV());
            }
        }
    }

    public void btn_addMHClick(ActionEvent actionEvent) throws IOException {
        if (info_mmh.getText().equals("") || info_tmh.getText().equals("")){
            Alert alert = new Alert(Alert.AlertType.INFORMATION);
            alert.setTitle("Lỗi");
            // Header Text: null
            alert.setHeaderText(null);
            alert.setContentText("Vui lòng nhập đầy đủ thông tin!");

            alert.showAndWait();
        }else{
            Boolean flag = true;
            for (MonHoc mh : monHocList) {
                if (info_mmh.getText().equals(mh.getMaMH())){
                    flag = false;
                }
            }
            if (flag){
                monHocList.add(new MonHoc(info_mmh.getText(), info_tmh.getText()));
                dataMH.add(info_mmh.getText() + " " + info_tmh.getText());

                Alert alert = new Alert(Alert.AlertType.INFORMATION);
                alert.setTitle("Thành công");
                // Header Text: null
                alert.setHeaderText(null);
                alert.setContentText("Đã thêm môn học: " + info_tmh.getText());

                alert.showAndWait();

                info_mmh.setText("");
                info_tmh.setText("");
            }else{
                ButtonType accept = new ButtonType("SỬA", ButtonBar.ButtonData.OK_DONE);
                ButtonType deny = new ButtonType("TRỞ LẠI", ButtonBar.ButtonData.CANCEL_CLOSE);
                Alert alert = new Alert(Alert.AlertType.INFORMATION,"Thông tin môn học \n"
                        + "Mã môn học: " + info_mmh.getText() + "\nTên môn học: " + info_tmh.getText(),
                        accept,
                        deny);
                alert.setTitle("Sửa thông tin môn học " + info_mmh.getText());
                Optional<ButtonType> result = alert.showAndWait();

                if (result.orElse(deny) == accept) {
                    for (int i = 0; i < monHocList.size(); i++){
                        if (monHocList.get(i).getMaMH().equals(info_mmh.getText())){
                            monHocList.get(i).setTenMH(info_tmh.getText());
                            dataMH.remove(i);
                            dataMH.add(i, info_mmh.getText() + " " + info_tmh.getText());
                        }
                    }
                    System.out.println("Sửa");
                }else{
                    System.out.println("KO Sửa");
                }
            }

            System.out.println("monHocList: ");
            for (int i = 0; i < monHocList.size(); i++){
                System.out.println(monHocList.get(i).getMaMH() + "-" + monHocList.get(i).getTenMH());
            }
        }
    }

    public void btn_DKHocClick(ActionEvent actionEvent){
        SinhVien_MonHoc newSVMH = new SinhVien_MonHoc();
        if ((pos1 != 999) && (pos2 != 999)){
            newSVMH.setMaSinhVien(sinhVienList.get(pos1).getMaSV());
            newSVMH.setMaMonHoc(monHocList.get(pos2).getMaMH());
        }else{
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Lỗi");
            // Header Text: null
            alert.setHeaderText(null);
            alert.setContentText("Vui lòng chọn đủ thông tin");

            alert.showAndWait();
        }

        Boolean flag = false;
        for (int i = 0; i < sinhVienMonHocList.size(); i++){
            if ((sinhVienMonHocList.get(i).getMaSinhVien().equals(newSVMH.getMaSinhVien()))
            && (sinhVienMonHocList.get(i).getMaMonHoc().equals(newSVMH.getMaMonHoc()))){
                flag = true;
            }
        }

        if (flag){
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Lỗi");
            alert.setHeaderText(null);
            alert.setContentText("Sinh viên " + newSVMH.getMaSinhVien().toUpperCase(Locale.ROOT) +
                    " đã học môn " + newSVMH.getMaMonHoc().toUpperCase(Locale.ROOT));

            alert.showAndWait();
            flag = false;
        }else {
            sinhVienMonHocList.add(newSVMH);
            Alert alert = new Alert(Alert.AlertType.INFORMATION);
            alert.setTitle("Thành công");
            alert.setHeaderText(null);
            alert.setContentText("Đã Đăng ký học " + newSVMH.getMaMonHoc().toUpperCase(Locale.ROOT)
                    + " cho sinh viên " + newSVMH.getMaSinhVien().toUpperCase(Locale.ROOT));
            alert.showAndWait();
        }

        System.out.println("sinhVienMonHocList: ");
        for (int i = 0; i < sinhVienMonHocList.size(); i++){
            System.out.println(sinhVienMonHocList.get(i).getMaSinhVien() + " - " +
                    sinhVienMonHocList.get(i).getMaMonHoc() + " - " +
                    sinhVienMonHocList.get(i).getDiem());
        }
    }

    public void btn_NhapDiemClick(ActionEvent actionEvent){
        // System.out.println("diem: " + info_diem.getText());
        SinhVien_MonHoc newSVMH = new SinhVien_MonHoc();
        if ((pos1 != 999) && (pos2 != 999)){
            newSVMH.setMaSinhVien(sinhVienList.get(pos1).getMaSV());
            newSVMH.setMaMonHoc(monHocList.get(pos2).getMaMH());
        }else{
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Lỗi");
            alert.setHeaderText(null);
            alert.setContentText("Vui lòng chọn đủ thông tin");

            alert.showAndWait();
        }

        Boolean flag = false;
        for (int i = 0; i < sinhVienMonHocList.size(); i++){
            if ((sinhVienMonHocList.get(i).getMaSinhVien().equals(newSVMH.getMaSinhVien()))
                    && (sinhVienMonHocList.get(i).getMaMonHoc().equals(newSVMH.getMaMonHoc()))){
                sinhVienMonHocList.get(i).setDiem(Float.parseFloat(info_diem.getText()));
                flag = true;
            }
        }

        if (flag){
            Alert alert = new Alert(Alert.AlertType.INFORMATION);
            alert.setTitle("Thành công");
            alert.setHeaderText(null);
            alert.setContentText("Đã nhập điểm cho sinh viên "
                    + newSVMH.getMaSinhVien().toUpperCase(Locale.ROOT));
            info_diem.setText("");
            alert.showAndWait();
            flag = false;
        }else{
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Lỗi");
            alert.setHeaderText(null);
            alert.setContentText("Sinh viên " + newSVMH.getMaSinhVien().toUpperCase(Locale.ROOT) +
                    " chưa học môn " + newSVMH.getMaMonHoc().toUpperCase(Locale.ROOT));

            alert.showAndWait();
        }

        System.out.println("sinhVienMonHocList: ");
        for (int i = 0; i < sinhVienMonHocList.size(); i++){
            System.out.println(sinhVienMonHocList.get(i).getMaSinhVien() + " - " +
                    sinhVienMonHocList.get(i).getMaMonHoc() + " - " +
                    sinhVienMonHocList.get(i).getDiem());
        }
    }

    public void btn_LocSVClick(ActionEvent actionEvent){
        float tongDiem = 0;
        int tongSoMon = 0;
        HashMap<String, Float> map = new HashMap<String, Float>();
        for (int i = 0; i < sinhVienList.size(); i++){
            for (int j = 0; j < sinhVienMonHocList.size(); j++){
                if (sinhVienMonHocList.get(j).getMaSinhVien().equals(sinhVienList.get(i).getMaSV())){
                    tongDiem = tongDiem + sinhVienMonHocList.get(j).getDiem();
                    tongSoMon = tongSoMon + 1;
                }
            }

            if (tongSoMon > 0){
                map.put(sinhVienList.get(i).getMaSV(), tongDiem/tongSoMon);
                tongDiem = 0;
                tongSoMon = 0;
            }
        }

        dataSVfilter.clear();
        for (Map.Entry<String, Float> entry : map.entrySet()) {
            if (entry.getValue() >= Float.parseFloat(info_diemtb.getText())) {
                dataSVfilter.add(entry.getKey() + " " + entry.getValue());
            }
        }

        if (info_diemtb.getText().equals("0") || info_diemtb.getText().equals("")) {
            listViewDSSV.setItems(dataSV);
        } else {
            listViewDSSV.setItems(dataSVfilter);
        }

    }

    public void btn_NhapClick(ActionEvent actionEvent) throws IOException { // Đọc file
        sinhVienList.clear();
        File fsv = new File("D:\\SinhVien.txt");
        FileReader frsv = new FileReader(fsv);
        BufferedReader bufferedReaderSV = new BufferedReader(frsv);

        boolean checkLine = true;
        String line;
        SinhVien addSVNew = new SinhVien("NONE","NONE");
        while ((line = bufferedReaderSV.readLine()) != null){
            if (checkLine){
                addSVNew.setMaSV(line);
                //System.out.println("line1: " + line);
            }else{
                addSVNew.setTenSV(line);
                //System.out.println("line2: " + line);
                sinhVienList.add(new SinhVien(addSVNew.getMaSV(), addSVNew.getTenSV()));
                //System.out.println("add:" + addSVNew.getMaSV() + " add:" + addSVNew.getTenSV());
                // checkLine = 0;
            }
            if (checkLine == true){
                checkLine = false;
            }else{
                checkLine = true;
            }

//            addSVNew.setMaSV("NONE");
//            addSVNew.setTenSV("NONE");
        }
        frsv.close();
        bufferedReaderSV.close();
        dataSV.clear();
        System.out.println("Sinh viên: ");
        for (int i = 0; i < sinhVienList.size(); i++){
            dataSV.add(sinhVienList.get(i).getMaSV() + " " + sinhVienList.get(i).getTenSV());
            System.out.println(sinhVienList.get(i).getMaSV() + " " + sinhVienList.get(i).getTenSV());
        }
        ////////////////////////////////////////////////////////////////////
        monHocList.clear();
        File fmh = new File("D:\\MonHoc.txt");
        FileReader frmh = new FileReader(fmh);
        BufferedReader bufferedReaderMH = new BufferedReader(frmh);

        boolean checkLineMH = true;
        String lineMH;
        MonHoc addMHNew = new MonHoc("NONE","NONE");
        while ((lineMH = bufferedReaderMH.readLine()) != null){
            if (checkLineMH){
                addMHNew.setMaMH(lineMH);
                //System.out.println("line1: " + lineMH);
            }else{
                addMHNew.setTenMH(lineMH);
                //System.out.println("line2: " + lineMH);
                monHocList.add(new MonHoc(addMHNew.getMaMH(), addMHNew.getTenMH()));
                //System.out.println("add:" + addMHNew.getMaMH() + " add:" + addMHNew.getTenMH());
                // checkLineMH = 0;
            }
            if (checkLineMH == true){
                checkLineMH = false;
            }else{
                checkLineMH = true;
            }

//            addSVNew.setMaSV("NONE");
//            addSVNew.setTenSV("NONE");
        }
        frmh.close();
        bufferedReaderMH.close();
        dataMH.clear();
        System.out.println("Môn học: ");
        for (int i = 0; i < monHocList.size(); i++){
            dataMH.add(monHocList.get(i).getMaMH() + " " + monHocList.get(i).getTenMH());
            System.out.println(monHocList.get(i).getMaMH() + " " + monHocList.get(i).getTenMH());
        }
        ////////////////////////////////////////////////////////////////////
        sinhVienMonHocList.clear();
        File fsvmh = new File("D:\\SinhVien_MonHoc.txt");
        FileReader frsvmh = new FileReader(fsvmh);
        BufferedReader bufferedReaderSVMH = new BufferedReader(frsvmh);

        int checkLineSVMH = 1;
        String lineSVMH;
        SinhVien_MonHoc addSVMHNew = new SinhVien_MonHoc("NONE","NONE", 0);
        while ((lineSVMH = bufferedReaderSVMH.readLine()) != null){
            if (checkLineSVMH == 1){
                addSVMHNew.setMaSinhVien(lineSVMH);
                //System.out.println("line1: " + lineSVMH);
            }
            if (checkLineSVMH == 2){
                addSVMHNew.setMaMonHoc(lineSVMH);
                //System.out.println("line1: " + lineSVMH);
            }
            if (checkLineSVMH == 3){
                addSVMHNew.setDiem(Float.parseFloat(lineSVMH));
                //System.out.println("line2: " + lineSVMH);
                sinhVienMonHocList.add(new SinhVien_MonHoc(addSVMHNew.getMaSinhVien(), addSVMHNew.getMaMonHoc(), addSVMHNew.getDiem()));
                //System.out.println("add:" + addSVMHNew.getMaSinhVien() + " add:" + addSVMHNew.getMaMonHoc() + " add:" + addSVMHNew.getDiem());
                checkLineSVMH = 0;
            }
            checkLineSVMH = checkLineSVMH + 1;

        }
        frmh.close();
        bufferedReaderSVMH.close();
        System.out.println("DS Đăng ký học:");
        for (int i = 0; i < sinhVienMonHocList.size(); i++){
            System.out.println(sinhVienMonHocList.get(i).getMaSinhVien() + " " + sinhVienMonHocList.get(i).getMaMonHoc() + " " + sinhVienMonHocList.get(i).getDiem());
        }

        System.out.println("NhapDuLieu");
    }

    public void btn_XuatClick(ActionEvent actionEvent) throws IOException { // lưu file
        File fp = new File("D:\\SinhVien.txt");
        FileWriter fwp = new FileWriter(fp);
//        fwp.write(Integer.toString(phongList.size()));
//        fwp.write("\n");
        for (int i = 0; i < sinhVienList.size(); i++){
            fwp.write(sinhVienList.get(i).getMaSV());
            fwp.write("\n");
            fwp.write(sinhVienList.get(i).getTenSV());
            fwp.write("\n");
        }
        fwp.close();

        File fkh = new File("D:\\MonHoc.txt");
        FileWriter fwkh = new FileWriter(fkh);
//        fwkh.write(Integer.toString(khachHangList.size()));
//        fwkh.write("\n");
        for (int i = 0; i < monHocList.size(); i++){
            fwkh.write(monHocList.get(i).getMaMH());
            fwkh.write("\n");
            fwkh.write(monHocList.get(i).getTenMH());
            fwkh.write("\n");
        }
        fwkh.close();

        File fpkh = new File("D:\\SinhVien_MonHoc.txt");
        FileWriter fwpkh = new FileWriter(fpkh);
//        fwpkh.write(Integer.toString(phongKhList.size()));
//        fwpkh.write("\n");
        for (int i = 0; i < sinhVienMonHocList.size(); i++){
            fwpkh.write(sinhVienMonHocList.get(i).getMaSinhVien());
            fwpkh.write("\n");
            fwpkh.write(sinhVienMonHocList.get(i).getMaMonHoc());
            fwpkh.write("\n");
            fwpkh.write(Float.toString(sinhVienMonHocList.get(i).getDiem()));
            fwpkh.write("\n");
        }
        fwpkh.close();

        System.out.println("XuatDuLieu");
    }
}
