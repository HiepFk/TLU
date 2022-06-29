package sample;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class Main extends Application {

//    @Override
//    public void start(Stage primaryStage) throws Exception{
//        Parent root = FXMLLoader.load(getClass().getResource("layout/main.fxml"));
//
//        primaryStage.setTitle("Quản lý");
//        primaryStage.setScene(new Scene(root, 600, 400));
//        primaryStage.show();
//    }
        @Override
        public void start(Stage primaryStage) throws Exception {
            try{
                Parent root = FXMLLoader.load(this.getClass().getResource("layout/Login.fxml"));
                Scene scene = new Scene(root);
                primaryStage.setTitle("QUẢN LÝ");
                primaryStage.setScene(scene);
                primaryStage.show();
            }catch (Exception e){
                System.out.println(e);
            }
        }
    public static void main(String[] args) {
        launch(args);
    }
}
