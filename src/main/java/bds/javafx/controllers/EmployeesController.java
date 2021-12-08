package bds.javafx.controllers;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.Scene;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;
import bds.javafx.App;
import bds.javafx.api.EmployeeBasicView;
import bds.javafx.api.EmployeeDetailView;
import bds.javafx.data.EmployeeRepository;
import bds.javafx.exceptions.ExceptionHandler;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.control.*;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import bds.javafx.services.EmployeeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import java.io.IOException;
import java.util.List;

public class EmployeesController {

    private static final Logger logger = LoggerFactory.getLogger(EmployeesController.class);

    @FXML
    private TableColumn<EmployeeBasicView, Long> employeeId;
    @FXML
    private TableColumn<EmployeeBasicView, String> FirstName;
    @FXML
    private TableColumn<EmployeeBasicView, String> Surname;
    @FXML
    private TableColumn<EmployeeBasicView, String> Email;
    @FXML
    private TableColumn<EmployeeBasicView, String> Building;
    @FXML
    private TableView<EmployeeBasicView> systemEmployeesTableView;
//    @FXML
// to už bylo zakomentovane   public MenuItem exitMenuItem;

    private EmployeeService employeeService;
    private EmployeeRepository employeeRepository;

    public EmployeesController() {
    }

    @FXML
    private void initialize() {
        employeeRepository = new EmployeeRepository();
        employeeService = new EmployeeService(employeeRepository);
//        GlyphsDude.setIcon(exitMenuItem, FontAwesomeIcon.CLOSE, "1em");

        employeeId.setCellValueFactory(new PropertyValueFactory<EmployeeBasicView, Long>("id"));
        FirstName.setCellValueFactory(new PropertyValueFactory<EmployeeBasicView, String>("firstname"));
        Surname.setCellValueFactory(new PropertyValueFactory<EmployeeBasicView, String>("surname"));
        Email.setCellValueFactory(new PropertyValueFactory<EmployeeBasicView, String>("email"));
        Building.setCellValueFactory(new PropertyValueFactory<EmployeeBasicView, String>("building"));


        ObservableList<EmployeeBasicView> observableEmployeesList = initializeEmployeesData();
        systemEmployeesTableView.setItems(observableEmployeesList);

        systemEmployeesTableView.getSortOrder().add(employeeId);

        //initializeTableViewSelection();
        //loadIcons();
        //DODĚLAT
        logger.info("EmployeesController initialized");
    }

   /* private void initializeTableViewSelection() {
        MenuItem edit = new MenuItem("Edit employee");
        MenuItem detailedView = new MenuItem("Detailed employee view");
        edit.setOnAction((ActionEvent event) -> {
            EmployeeBasicView employeeView = systemEmployeeTableView.getSelectionModel().getSelectedItem();
            try {
                FXMLLoader fxmlLoader = new FXMLLoader();
                fxmlLoader.setLocation(App.class.getResource("fxml/PersonEdit.fxml"));
                Stage stage = new Stage();
                stage.setUserData(employeeView);
                stage.setTitle("BDS JavaFX Edit Employee");

                EmployeeEditController controller = new EmployeeEditController();
                controller.setStage(stage);
                fxmlLoader.setController(controller);

                Scene scene = new Scene(fxmlLoader.load(), 600, 500);

                stage.setScene(scene);

                stage.show();
            } catch (IOException ex) {
                ExceptionHandler.handleException(ex);
            }
        });

        detailedView.setOnAction((ActionEvent event) -> {
            EmployeeBasicView personView = systemEmployeesTableView.getSelectionModel().getSelectedItem();
            try {
                FXMLLoader fxmlLoader = new FXMLLoader();
                fxmlLoader.setLocation(App.class.getResource("fxml/PersonsDetailView.fxml"));
                Stage stage = new Stage();

                Long personId = personView.getEmployeeId();
                PersonDetailView personDetailView = personService.getPersonDetailView(personId);

                stage.setUserData(personDetailView);
                stage.setTitle("BDS JavaFX Persons Detailed View");

                PersonsDetailViewController controller = new PersonsDetailViewController();
                controller.setStage(stage);
                fxmlLoader.setController(controller);

                Scene scene = new Scene(fxmlLoader.load(), 600, 500);

                stage.setScene(scene);

                stage.show();
            } catch (IOException ex) {
                ExceptionHandler.handleException(ex);
            }
        });


        ContextMenu menu = new ContextMenu();
        menu.getItems().add(edit);
        menu.getItems().addAll(detailedView);
        systemEmployeesTableView.setContextMenu(menu);
    }
*/
    private ObservableList<EmployeeBasicView> initializeEmployeesData() {
        List<EmployeeBasicView> persons = employeeService.getEmployeesBasicView();
        return FXCollections.observableArrayList(persons);
    }

    /*private void loadIcons() {
        Image vutLogoImage = new Image(App.class.getResourceAsStream("logos/vut-logo-eng.png"));
        ImageView vutLogo = new ImageView(vutLogoImage);
        vutLogo.setFitWidth(150);
        vutLogo.setFitHeight(50);
    }*/

    public void handleExitMenuItem(ActionEvent event) {
        System.exit(0);
    }

    public void handleAddPersonButton(ActionEvent actionEvent) {
        try {
            FXMLLoader fxmlLoader = new FXMLLoader();
            fxmlLoader.setLocation(App.class.getResource("fxml/PersonsCreate.fxml"));
            Scene scene = new Scene(fxmlLoader.load(), 600, 500);
            Stage stage = new Stage();
            stage.setTitle("BDS JavaFX Create Person");
            stage.setScene(scene);

//            Stage stageOld = (Stage) signInButton.getScene().getWindow();
//            stageOld.close();
//
//            stage.getIcons().add(new Image(App.class.getResourceAsStream("logos/vut.jpg")));
//            authConfirmDialog();

            stage.show();
        } catch (IOException ex) {
            ExceptionHandler.handleException(ex);
        }
    }

    public void handleRefreshButton(ActionEvent actionEvent) {
        ObservableList<EmployeeBasicView> observableEmployeesList = initializeEmployeesData();
        systemEmployeesTableView.setItems(observableEmployeesList);
        systemEmployeesTableView.refresh();
        systemEmployeesTableView.sort();
    }
}
