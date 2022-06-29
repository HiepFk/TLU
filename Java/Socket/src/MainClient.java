import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.collections.transformation.SortedList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import lop.SinhVien;

import java.net.*;
import java.io.*;
import java.util.ResourceBundle;

public class MainClient implements Initializable {
    private DataOutputStream dos;
    private DataInputStream dis;
    //  private Socket s1;

    @FXML
    private TextField host_text;

    @FXML
    private TextField port_text;
    @FXML
    private TableView<SinhVien> table;

    @FXML
    private TableColumn<?, ?> idColumn;

    @FXML
    private TableColumn<?, ?> nameColumn;

    @FXML
    private TableColumn<?, ?> sexColumn;

    @FXML
    private TableColumn<?, ?> nsColumn;

    @FXML
    private TableColumn<?, ?> lopCoulm;

    @FXML
    private TableColumn<?, ?> dtColumn;

    @FXML
    private TableColumn<?, ?> emailColumn;

    @FXML
    private TableColumn<?, ?> diemColumn;

    @FXML
    private TextField iDtext;

    @FXML
    private TextField nameText;

    @FXML
    private TextField searchSv;

    @FXML
    private TextField nsText;

    @FXML
    private TextField sexText;

    @FXML
    private TextField lopText;

    @FXML
    private TextField dtText;

    @FXML
    private TextField emailText;

    @FXML
    private TextField diemText;

    @FXML
    private TextField loctext;

    ObservableList<SinhVien> data_sv = FXCollections.observableArrayList();

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {

        // Sinh Viên :
        idColumn.setCellValueFactory(new PropertyValueFactory<>("maSV"));
        nameColumn.setCellValueFactory(new PropertyValueFactory<>("ten"));
        sexColumn.setCellValueFactory(new PropertyValueFactory<>("gioiTinh"));
        nsColumn.setCellValueFactory(new PropertyValueFactory<>("ngaySinh"));
        lopCoulm.setCellValueFactory(new PropertyValueFactory<>("lop"));
        dtColumn.setCellValueFactory(new PropertyValueFactory<>("sdt"));
        emailColumn.setCellValueFactory(new PropertyValueFactory<>("email"));
        diemColumn.setCellValueFactory(new PropertyValueFactory<>("diemTB"));


        table.setItems(data_sv);

        table.setOnMouseClicked(mouseEvent -> {
            SinhVien selected = table.getSelectionModel().getSelectedItem();
            iDtext.setText("" + selected.getMaSV());
            nameText.setText("" + selected.getTen());
            sexText.setText("" + selected.getGioiTinh());
            nsText.setText("" + selected.getNgaySinh());
            lopText.setText("" + selected.getLop());
            dtText.setText("" + selected.getSdt());
            emailText.setText("" + selected.getEmail());
            diemText.setText("" + selected.getDiemTB());

//          Tím kiếm sinh viên
            FilteredList<SinhVien> filteredSV = new FilteredList<>(data_sv, b -> true);
            searchSv.textProperty().addListener((observable, oldValue, newValue) -> {
                filteredSV.setPredicate(sv -> {
                    if (newValue == null || newValue.isEmpty()) {
                        return true;
                    }
                    String lowerCaseFilter = newValue.toLowerCase();
                    if (sv.getMaSV().toLowerCase().contains(lowerCaseFilter)) {
                        return true;
                    } else if (sv.getTen().toLowerCase().contains(lowerCaseFilter)) {
                        return true;
                    } else if (sv.getLop().toLowerCase().contains(lowerCaseFilter)) {
                        return true;
                    } else return Double.toString(sv.getDiemTB()).toLowerCase().contains(lowerCaseFilter);
                });
            });
            SortedList<SinhVien> sortedData = new SortedList<>(filteredSV);
            sortedData.comparatorProperty().bind(table.comparatorProperty());
            table.setItems(sortedData);


        });


    }

    public void Connect() throws IOException {
        Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
        try {
            String local = host_text.getText();
            int port = Integer.parseInt(port_text.getText());
            Socket s1 = new Socket(local, port);
            OutputStream s1out = s1.getOutputStream();
            dos = new DataOutputStream(s1out);

            InputStream s1In = s1.getInputStream();
            dis = new DataInputStream(s1In);
        } catch (UnknownHostException e) {
            alert.setTitle("Lỗi ");
            alert.setHeaderText("Don't know about host");
            alert.show();
            System.err.println("Don't know about host ");
            return;
        } catch (IOException e) {
            alert.setTitle("Lỗi ");
            alert.setHeaderText("Couldn't get I/O for the connection ");
            alert.show();
            System.err.println("Couldn't get I/O for the connection");
            return;
        }
        Ket_noi();
        port_text.setEditable(false);
        host_text.setEditable(false);
    }

    public void Ket_noi() throws IOException {
        String st = "";
        st = dis.readUTF();
        show(st);

    }

    public void show(String data) {
        String[] listSV = data.split(";");
        String[] sv;
        for (String s : listSV) {
            sv = s.split(",");
            SinhVien k = new SinhVien(sv[0], sv[1], sv[2], sv[3], sv[4], sv[5], sv[6], Double.parseDouble(sv[7]));
            data_sv.add(k);
            for (String value : sv) {
                System.out.print(value + "   ");
            }
            System.out.println();
        }
    }

    public void Add() throws IOException {
        String st;
        st = "Them," + iDtext.getText() + "," + nameText.getText() + "," + sexText.getText() + "," + nsText.getText() + "," + lopText.getText() + "," +
                dtText.getText() + "," + emailText.getText() + "," + diemText.getText();
        dos.writeUTF(st);
        data_sv.clear();

        Ket_noi();

        Clear();

    }

    public void Delete() throws IOException {
        String st;
        st = "Xoa," + iDtext.getText() + "," + nameText.getText() + "," + sexText.getText() + "," + nsText.getText() + "," + lopText.getText() + "," +
                dtText.getText() + "," + emailText.getText() + "," + diemText.getText() + ",";
        dos.writeUTF(st);
        data_sv.clear();
        Ket_noi();
        Clear();
    }

    public void Edit() throws IOException {
        String st;
        SinhVien k = table.getSelectionModel().getSelectedItem();
        st = "Sua," + k.getMaSV() + "," + nameText.getText() + "," + sexText.getText() + "," + nsText.getText() + "," + lopText.getText() + "," +
                dtText.getText() + "," + emailText.getText() + "," + diemText.getText() + ",";
        dos.writeUTF(st);
        data_sv.clear();
        Ket_noi();
        Clear();
    }

    public void Dis() throws IOException {
        String st = "Stop";
        dos.writeUTF(st);
        data_sv.clear();
        Clear();
        port_text.setEditable(true);
        host_text.setEditable(true);
        port_text.setText("");
        host_text.setText("");

    }

    public void Clear() {
        iDtext.setText("");
        nameText.setText("");
        sexText.setText("");
        nsText.setText("");
        lopText.setText("");
        dtText.setText("");
        emailText.setText("");
        diemText.setText("");
    }

    public void Loc() throws IOException {
        data_sv.clear();
        dos.writeUTF("hihi");
        String st = "";
        st = dis.readUTF();
        String[] listSV = st.split(";");
        String[] sv;
        for (String s : listSV) {
            sv = s.split(",");
            SinhVien k = new SinhVien(sv[0], sv[1], sv[2], sv[3], sv[4], sv[5], sv[6], Double.parseDouble(sv[7]));
            if (k.getDiemTB() >= Double.parseDouble(loctext.getText())) {
                data_sv.add(k);
            }

        }
        loctext.setText("");
    }
}

