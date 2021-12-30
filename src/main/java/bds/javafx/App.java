package bds.javafx;


import bds.javafx.exceptions.ExceptionHandler;
import javafx.application.Application;
import javafx.event.EventHandler;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import javafx.stage.StageStyle;

import java.io.IOException;



public class App extends Application {

    private FXMLLoader loader;
    private VBox mainStage;
    public static void main(String[] args) {
        launch(args);
    }
    private double xOffset = 0;
    private double yOffset = 0;
    @Override
    public void start(Stage stage){
        try {

            loader = new FXMLLoader(getClass().getResource("/bds.javafx/App.fxml"));
            mainStage = loader.load();
            //Scene scene = new Scene(mainStage);
            mainStage.setOnMousePressed(new EventHandler<MouseEvent>() {
                @Override
                public void handle(MouseEvent event) {
                    xOffset = event.getSceneX();
                    yOffset = event.getSceneY();
                }
            });
            mainStage.setOnMouseDragged(new EventHandler<MouseEvent>() {
                @Override
                public void handle(MouseEvent mouseEvent) {
                    stage.setX(mouseEvent.getSceneX() - xOffset);
                    stage.setY(mouseEvent.getSceneY() - yOffset);
                }
            });
            Scene scene = new Scene(mainStage);
            stage.initStyle(StageStyle.UNDECORATED);
            stage.setScene(scene);
            stage.show();
        }
        catch (Exception ex) {
            ExceptionHandler.handleException(ex);
        }
        }

}
