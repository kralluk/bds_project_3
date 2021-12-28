package bds.javafx.controllers;


import bds.javafx.api.SQLInjectionView;
import bds.javafx.data.SQLInjectionRepository;
import bds.javafx.services.SQLInjectionService;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.TableColumn;
import javafx.scene.control.cell.PropertyValueFactory;

import java.util.List;

public class SQLInjectionController {

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
        injectionRepository = new SQLInjectionRepository();
        injectionService = new SQLInjectionService(injectionRepository);

        Long findedId = Long.valueOf(findTextField.getText());

        id.setCellValueFactory(new PropertyValueFactory<SQLInjectionView, Long>("id"));
        name.setCellValueFactory(new PropertyValueFactory<SQLInjectionView, String>("name"));
        email.setCellValueFactory(new PropertyValueFactory<SQLInjectionView, String>("email"));

        ObservableList<SQLInjectionView> observableEmployeesList = initializeEmployeesData(findedId);
        employeesTableView.setItems(observableEmployeesList);
    }
    private ObservableList<SQLInjectionView> initializeEmployeesData(Long findedId) {
        List<SQLInjectionView> employees = injectionService.findByIDStatement(findedId);
        return FXCollections.observableArrayList(employees);
    }
}
