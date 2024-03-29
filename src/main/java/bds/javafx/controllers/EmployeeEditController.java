package bds.javafx.controllers;

import de.jensd.fx.glyphs.GlyphsDude;
import de.jensd.fx.glyphs.fontawesome.FontAwesomeIcon;
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
import bds.javafx.api.EmployeeBasicView;
import  bds.javafx.api.EmployeeEditView;
import  bds.javafx.data.EmployeeRepository;
import  bds.javafx.services.EmployeeService;
import org.controlsfx.validation.ValidationSupport;
import org.controlsfx.validation.Validator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Optional;

public class EmployeeEditController {
    private static final Logger logger = LoggerFactory.getLogger(EmployeeEditController.class);

    @FXML
    public Label exitButton;
    @FXML
    public Label minimizeButton;
    @FXML
    public ComboBox<String> buildingComboBox;
    @FXML
    public Button editEmployeeButton;
    @FXML
    public TextField idTextField;
    @FXML
    private TextField emailTextField;
    @FXML
    private TextField firstNameTextField;
    @FXML
    private TextField surnameTextField;
    @FXML
    private TextField buildingTextField;

    private EmployeeService employeeService;
    private EmployeeRepository employeeRepository;
    private ValidationSupport validation;

    // used to reference the stage and to get passed data through it
    public Stage stage;

    public void setStage(Stage stage) {
        this.stage = stage;
    }

    @FXML
    public void initialize() {
        GlyphsDude.setIcon(exitButton, FontAwesomeIcon.CLOSE, "1.3em");
        GlyphsDude.setIcon(minimizeButton, FontAwesomeIcon.MINUS, "1.3em");
        employeeRepository = new EmployeeRepository();
        employeeService = new EmployeeService(employeeRepository);


        ObservableList<String> buildings = FXCollections.observableArrayList("výroba","účetnictví", "headquarters", "závodní jídelna", "odpadová hala", "strojírenství");
        buildingComboBox.setItems(buildings);
        validation = new ValidationSupport();
        validation.registerValidator(idTextField, Validator.createEmptyValidator("The id must not be empty."));
        idTextField.setEditable(false);
        validation.registerValidator(emailTextField, Validator.createEmptyValidator("The email must not be empty."));
        validation.registerValidator(firstNameTextField, Validator.createEmptyValidator("The first name must not be empty."));
        validation.registerValidator(surnameTextField, Validator.createEmptyValidator("The last name must not be empty."));
        validation.registerValidator(buildingComboBox, Validator.createEmptyValidator("The building must not be empty."));

        editEmployeeButton.disableProperty().bind(validation.invalidProperty());

        loadEmployeesData();

        logger.info("PersonsEditController initialized");
    }

    /**
     * Load passed data from Persons controller. Check this tutorial explaining how to pass the data between controllers: https://dev.to/devtony101/javafx-3-ways-of-passing-information-between-scenes-1bm8
     */
    private void loadEmployeesData() {
        Stage stage = this.stage;
        if (stage.getUserData() instanceof EmployeeBasicView) {
            EmployeeBasicView employeeBasicView = (EmployeeBasicView) stage.getUserData();
            idTextField.setText(String.valueOf(employeeBasicView.getEmployeeId()));
            emailTextField.setText(employeeBasicView.getEmail());
            firstNameTextField.setText(employeeBasicView.getFirstName());
            surnameTextField.setText(employeeBasicView.getSurname());
            buildingComboBox.setValue(employeeBasicView.getBuilding());
           // buildingTextField.setText(employeeBasicView.getBuilding());
        }
    }

    @FXML
    public void handleEditEmployeeButton(ActionEvent event) {
        Long id = Long.valueOf(idTextField.getText());
        String email = emailTextField.getText();
        String firstName = firstNameTextField.getText();
        String lastName = surnameTextField.getText();
       // String building = buildingTextField.getText();
        int building = buildingComboBox.getSelectionModel().getSelectedIndex()+1;

        EmployeeEditView employeeEditView = new EmployeeEditView();
        employeeEditView.setId(id);
        employeeEditView.setEmail(email);
        employeeEditView.setFirstName(firstName);
        employeeEditView.setSurname(lastName);
        employeeEditView.setBuilding(building);

        employeeService.editEmployee(employeeEditView);

        employeeEditedConfirmationDialog();
    }

    private void employeeEditedConfirmationDialog() {
        Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
        alert.setTitle("Employee Edited Confirmation");
        alert.setHeaderText("Your employee was successfully edited.");

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
