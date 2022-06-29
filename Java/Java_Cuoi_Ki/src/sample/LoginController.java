package sample;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import javax.swing.*;
import java.io.IOException;

public class LoginController {
    @FXML
    private Label  lblStatus;
    @FXML
    private TextField txtUser;
    @FXML
    private TextField txtPass;



    public void Login (ActionEvent event ) throws IOException {
        if(txtUser.getText().equals("a34729") && txtPass.getText().equals("12345"))
        {
            Stage stage = (Stage)((Node) event.getSource()).getScene().getWindow();
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(getClass().getResource("layout/main.fxml"));
            Parent sampleParent = loader.load();
            Scene scene = new Scene(sampleParent);
            stage.setScene(scene);
        }
        else{
            txtPass.setText("");
            txtUser.setText("");
            lblStatus.setText("Nhập sai");
        }
    }

}
