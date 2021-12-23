package bds.javafx.controllers;

import bds.javafx.api.EmployeeDetailView;
import javafx.fxml.FXML;
import javafx.scene.control.TextField;
import javafx.stage.Stage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class EmployeesDetailViewController {

    private static final Logger logger = LoggerFactory.getLogger(EmployeesDetailViewController.class);

    @FXML
    private TextField idTextField;

    @FXML
    private TextField firstnameTextField;

    @FXML
    private TextField surnameTextField;
    @FXML
    private TextField emailTextField;

    @FXML
    private TextField buildingTextField;

    @FXML
    private TextField jobtypeTextField;

    @FXML
    private TextField salaryTextField;

    @FXML
    private TextField contractexpirationTextField;

    @FXML
    private TextField addresstypeTextField;

    @FXML
    private TextField cityTextField;

    @FXML
    private TextField streetTextField;

    @FXML
    private TextField streetnumberTextField;

    @FXML
    private TextField zipcodeTextField;

    public Stage stage;

    public void setStage(Stage stage) {
        this.stage = stage;
    }

    @FXML
    public void initialize() {
        idTextField.setEditable(false);
        emailTextField.setEditable(false);
        firstnameTextField.setEditable(false);
        surnameTextField.setEditable(false);
        buildingTextField.setEditable(false);
        cityTextField.setEditable(false);
        salaryTextField.setEditable(false);
        streetTextField.setEditable(false);
        jobtypeTextField.setEditable(false);
        contractexpirationTextField.setEditable(false);
        addresstypeTextField.setEditable(false);
        streetnumberTextField.setEditable(false);
        zipcodeTextField.setEditable(false);

        loadEmployeesData();

        logger.info("EmployeeDetailViewController initialized");
    }

    private void loadEmployeesData() {
        Stage stage = this.stage;
        if (stage.getUserData() instanceof EmployeeDetailView) {
            EmployeeDetailView employeeDetailView = (EmployeeDetailView) stage.getUserData();
            idTextField.setText(String.valueOf(employeeDetailView.getEmployeeId()));
            emailTextField.setText(employeeDetailView.getEmail());
            firstnameTextField.setText(employeeDetailView.getFirstName());
            surnameTextField.setText(employeeDetailView.getSurname());
            buildingTextField.setText(employeeDetailView.getBuilding());
            salaryTextField.setText(String.valueOf(employeeDetailView.getSalary()));
            cityTextField.setText(employeeDetailView.getCity());
            jobtypeTextField.setText(employeeDetailView.getJobType());
            streetTextField.setText(employeeDetailView.getStreet());
            contractexpirationTextField.setText(employeeDetailView.getContractExpiration());
            addresstypeTextField.setText(employeeDetailView.getAddressType());
            streetnumberTextField.setText(String.valueOf(employeeDetailView.getStreetNumber()));
            zipcodeTextField.setText(String.valueOf(employeeDetailView.getZipCode()));
        }
    }
    /*private void loadEmployeesData() {
        Stage stage = this.stage;
        if (stage.getUserData() instanceof EmployeeDetailView) {
            EmployeeDetailView employeeBasicView = (EmployeeDetailView) stage.getUserData();
            idTextField.setText(String.valueOf(employeeBasicView.getEmployeeId()));
            emailTextField.setText(employeeBasicView.getEmail());
            firstnameTextField.setText(employeeBasicView.getFirstName());
            surnameTextField.setText(employeeBasicView.getSurname());
            buildingTextField.setText(employeeBasicView.getBuilding());
            salaryTextField.setText(String.valueOf(employeeBasicView.getSalary()));
            cityTextField.setText(employeeBasicView.getCity());
            jobtypeTextField.setText(employeeBasicView.getJobType());
            streetTextField.setText(employeeBasicView.getStreet());
            contractexpirationTextField.setText(employeeBasicView.getContractExpiration());
            addresstypeTextField.setText(employeeBasicView.getAddressType());
            streetnumberTextField.setText(String.valueOf(employeeBasicView.getStreetNumber()));
            zipcodeTextField.setText(String.valueOf(employeeBasicView.getZipCode()));
        }
    }*/
}
