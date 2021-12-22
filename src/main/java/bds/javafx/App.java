package bds.javafx;


import bds.javafx.exceptions.ExceptionHandler;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

import java.io.IOException;



public class App extends Application {

    private FXMLLoader loader;
    private VBox mainStage;
    public static void main(String[] args) {
        launch(args);
    }
    @Override
    public void start(Stage stage){
        try {
            loader = new FXMLLoader(getClass().getResource("/bds.javafx/App.fxml"));
            mainStage = loader.load();
            Scene scene = new Scene(mainStage);
            stage.setTitle("Hello!");
            stage.setScene(scene);
            stage.show();
        }
        catch (Exception ex) {
            ExceptionHandler.handleException(ex);
        }
        }

}
