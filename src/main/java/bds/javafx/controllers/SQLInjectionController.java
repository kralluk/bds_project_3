package bds.javafx.controllers;


import bds.javafx.api.SQLInjectionView;
import bds.javafx.config.DataSourceConfig;
import bds.javafx.data.SQLInjectionRepository;
import bds.javafx.exceptions.DataAccessException;
import bds.javafx.services.SQLInjectionService;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.util.Duration;

import java.lang.AutoCloseable;

import java.sql.*;
import java.util.List;
import java.util.Optional;

public class SQLInjectionController {
    @FXML
    public Label isEmptyLabel;
    @FXML
    public Button createTableButton;
    @FXML
    public Button findButton;
    @FXML
    public TextField findTextField;
    @FXML
    private TableColumn<SQLInjectionView, Long> id;
    @FXML
    private TableColumn<SQLInjectionView, String> name;
    @FXML
    private TableColumn<SQLInjectionView, String> email;
    @FXML
    private TableView<SQLInjectionView> employeesTableView;

    private SQLInjectionService injectionService;
    private SQLInjectionRepository injectionRepository;

    public void handleFindButton(ActionEvent actionEvent) {
        employeesTableView.refresh();
        injectionRepository = new SQLInjectionRepository();
        injectionService = new SQLInjectionService(injectionRepository);

        String findedId =findTextField.getText();

        id.setCellValueFactory(new PropertyValueFactory<SQLInjectionView, Long>("id"));
        name.setCellValueFactory(new PropertyValueFactory<SQLInjectionView, String>("name"));
        email.setCellValueFactory(new PropertyValueFactory<SQLInjectionView, String>("email"));

        ObservableList<SQLInjectionView> observableEmployeesList = initializeEmployeesData(findedId);
        if(observableEmployeesList.isEmpty()){
            isEmptyLabel.setText("There is no employee with this id.");
        }
        else
        {
            isEmptyLabel.setText("");
        }
        employeesTableView.setItems(observableEmployeesList);
    }
    private ObservableList<SQLInjectionView> initializeEmployeesData(String findedId) {
        List<SQLInjectionView> employees = injectionService.findByIDStatement(findedId);
        return FXCollections.observableArrayList(employees);
    }
    public void ErrorDialog() {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Error Dialog");
        alert.setHeaderText("Error");
        alert.setContentText("Ooops, something is wrong!");

        alert.showAndWait();
    }
    public void handleCreateTableButton(ActionEvent actionEvent){

        try (Connection connection = DataSourceConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(" CREATE TABLE IF NOT EXISTS bds.dummy_table(\n" +
                             " employee_id SERIAL PRIMARY KEY,\n" +
                             " name VARCHAR(40) NOT NULL,\n" +
                             " email VARCHAR(40) NOT NULL);\n" +
                             " DO $$\n" +
                             " BEGIN\n" +
                             " IF (SELECT EXISTS (TABLE bds.dummy_table)) = 'true' THEN raise notice 'hovno';\n" +
                             " else \n" +
                             " INSERT INTO bds.dummy_table (name,email) values ('Pepa Novák','pepa.novak@seznam.cz');\n" +
                             " INSERT INTO bds.dummy_table (name,email) values ('Aneta Žaneta','zaneta.aneta@seznam.cz');\n" +
                             " INSERT INTO bds.dummy_table (name,email) values ('Jaromír Rukavica','rukavicka.jara@seznam.cz');\n" +
                             " INSERT INTO bds.dummy_table (name,email) values ('Lucie Oranžová','oranzova.lucie@seznam.cz');\n" +
                             " END IF;\n" +
                             " END $$;");
             ResultSet resultSet =  preparedStatement.executeQuery()) {

        } catch (SQLException e) {
            System.out.println("Hovno");
            throw new DataAccessException("Table creating failed", e);
        }


    }
}
