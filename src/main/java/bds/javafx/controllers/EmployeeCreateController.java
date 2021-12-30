package bds.javafx.controllers;

import bds.javafx.App;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.stage.Stage;
import javafx.util.Duration;
import bds.javafx.api.EmployeeCreateView;
import bds.javafx.data.EmployeeRepository;
import bds.javafx.services.EmployeeService;
import org.controlsfx.validation.ValidationSupport;
import org.controlsfx.validation.Validator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.swing.*;
import java.util.Optional;

public class EmployeeCreateController {

    private static final Logger logger = LoggerFactory.getLogger(EmployeeCreateController.class);

    @FXML
    public Label exitButton;
    @FXML
    public Label minimizeButton;
    @FXML
    private ComboBox<String> newEmployeeBuilding ;

    @FXML
    public Button newEmployeeCreateEmployee;
    @FXML
    private TextField newEmployeeEmail;

    @FXML
    private TextField newEmployeeFirstName;

    @FXML
    private TextField newEmployeeSurname;

    @FXML
    private TextField newEmployeePwd;

    private EmployeeService employeeService;
    private EmployeeRepository employeeRepository;
    private ValidationSupport validation;

    @FXML
    public void initialize() {

        employeeRepository = new EmployeeRepository();
        employeeService = new EmployeeService(employeeRepository);
        ObservableList<String> buildings = FXCollections.observableArrayList("výroba","účetnictví", "headquarters", "závodní jídelna", "odpadová hala", "strojírenství");
        newEmployeeBuilding.setItems(buildings);
        validation = new ValidationSupport();
        validation.registerValidator(newEmployeeEmail, Validator.createEmptyValidator("The email must not be empty."));
        validation.registerValidator(newEmployeeFirstName, Validator.createEmptyValidator("The first name must not be empty."));
        validation.registerValidator(newEmployeeSurname, Validator.createEmptyValidator("The surname must not be empty."));
        validation.registerValidator(newEmployeeBuilding, Validator.createEmptyValidator("The building must not be empty."));
        validation.registerValidator(newEmployeePwd, Validator.createEmptyValidator("The password must not be empty."));

        newEmployeeCreateEmployee.disableProperty().bind(validation.invalidProperty());

        logger.info("EmployeeCreateController initialized");
    }


    @FXML
    void handleCreateNewEmployee(ActionEvent event) {
        String email = newEmployeeEmail.getText();
        String firstName = newEmployeeFirstName.getText();
        String surname = newEmployeeSurname.getText();
        int buildingID = newEmployeeBuilding.getSelectionModel().getSelectedIndex()+1;//Long.valueOf(newEmployeeBuildingID.getText());
        String password = newEmployeePwd.getText();

        EmployeeCreateView employeeCreateView = new EmployeeCreateView();
        employeeCreateView.setPwd(password.toCharArray());
        employeeCreateView.setEmail(email);
        employeeCreateView.setFirstName(firstName);
        employeeCreateView.setSurname(surname);
        employeeCreateView.setBuildingID(buildingID);

        employeeService.createEmployee(employeeCreateView);

        employeeCreatedConfirmationDialog();
    }

    private void employeeCreatedConfirmationDialog() {
        Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
        alert.setTitle("Employee Created Confirmation");
        alert.setHeaderText("Your employee was successfully created.");

        Timeline idlestage = new Timeline(new KeyFrame(Duration.seconds(3), new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent event) {
                alert.setResult(ButtonType.CANCEL);
                alert.hide();
            }
        }));
        idlestage.setCycleCount(1);
        idlestage.play();
        Optional<ButtonType> result = alert.showAndWait();
    }
    @FXML
    private void handleClose(javafx.scene.input.MouseEvent mouseEvent) {
        if (mouseEvent.getSource() == exitButton) {
            Stage stage = (Stage)((Label)mouseEvent.getSource()).getScene().getWindow();
            stage.close();
        }
    }
    @FXML
    private void handleMinimize(javafx.scene.input.MouseEvent mouseEvent) {
        if (mouseEvent.getSource() == minimizeButton) {
            Stage stage = (Stage)((Label)mouseEvent.getSource()).getScene().getWindow();
            stage.setIconified(true);
        }
    }

}

