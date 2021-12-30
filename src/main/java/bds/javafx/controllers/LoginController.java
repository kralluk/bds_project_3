package bds.javafx.controllers;

import bds.javafx.App;
import bds.javafx.data.EmployeeRepository;
import bds.javafx.exceptions.DataAccessException;
import bds.javafx.exceptions.ExceptionHandler;
import bds.javafx.exceptions.ResourceNotFoundException;
import bds.javafx.services.AuthService;
import de.jensd.fx.glyphs.GlyphsDude;
import de.jensd.fx.glyphs.fontawesome.FontAwesomeIcon;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.input.KeyCode;
import javafx.stage.Stage;
import javafx.stage.StageStyle;
import javafx.util.Duration;
import org.controlsfx.validation.ValidationSupport;
import org.controlsfx.validation.Validator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.swing.*;
import java.io.IOException;
import java.util.Optional;

public class LoginController {

    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    @FXML
    public Label usernameLabel;
    @FXML
    public Label passwordLabel;
    @FXML
    private Button signInButton;
    @FXML
    private Label exitButton;
    @FXML
    public Label minimizeButton;
    @FXML
    private TextField usernameTextfield;
    @FXML
    private PasswordField passwordTextField;

    private EmployeeRepository employeeRepository;
    private AuthService authService;

    private ValidationSupport validation;

    public LoginController() {
    }
    @FXML
    private void initialize() {
        GlyphsDude.setIcon(exitButton, FontAwesomeIcon.CLOSE, "1.3em");
        GlyphsDude.setIcon(minimizeButton, FontAwesomeIcon.MINUS, "1.3em");
        GlyphsDude.setIcon(signInButton, FontAwesomeIcon.SIGN_IN, "1em");
        GlyphsDude.setIcon(usernameLabel, FontAwesomeIcon.USER, "2em");
        GlyphsDude.setIcon(passwordLabel, FontAwesomeIcon.USER_SECRET, "2em");
        usernameTextfield.setOnKeyPressed(event -> {
            if (event.getCode() == KeyCode.ENTER) {
                handleSignIn();
            }
        });
        passwordTextField.setOnKeyPressed(event -> {
            if (event.getCode() == KeyCode.ENTER) {
                handleSignIn();
            }
        });

       // initializeLogos();
        initializeServices();
        initializeValidations();

        logger.info("LoginController initialized");
    }

    private void initializeValidations() {
        validation = new ValidationSupport();
        validation.registerValidator(usernameTextfield, Validator.createEmptyValidator("The username must not be empty."));
        validation.registerValidator(passwordTextField, Validator.createEmptyValidator("The password must not be empty."));
        signInButton.disableProperty().bind(validation.invalidProperty());
    }

    private void initializeServices() {
        employeeRepository = new EmployeeRepository();
        authService = new AuthService(employeeRepository);
    }

    /*private void initializeLogos() {
        Image vutImage = new Image(App.class.getResourceAsStream("logos/vut-logo-eng.png"));
        ImageView vutLogoImage = new ImageView(vutImage);
        vutLogoImage.setFitHeight(85);
        vutLogoImage.setFitWidth(150);
        vutLogoImage.setPreserveRatio(true);
        vutLogo.setGraphic(vutLogoImage);
    }*/

    public void signInActionHandler(ActionEvent event) {
        handleSignIn();
    }

    private void handleSignIn() {
        String username = usernameTextfield.getText();
        String password = passwordTextField.getText();

        try {
            boolean authenticated = authService.authenticate(username, password);
            if (authenticated) {
                showEmployeesView();
            } else {
                showInvalidPaswordDialog();
            }
        } catch (ResourceNotFoundException | DataAccessException e) {
            showInvalidPaswordDialog();
        }
    }

    private void showEmployeesView() {
        try {
            FXMLLoader fxmlLoader = new FXMLLoader();
            fxmlLoader.setLocation(App.class.getResource("/bds.javafx/fxml/Employees.fxml"));
            Scene scene = new Scene(fxmlLoader.load());
            Stage stage = new Stage();
            stage.initStyle(StageStyle.UNDECORATED);
            stage.setTitle("Database of Employees");
            stage.setScene(scene);

            Stage stageOld = (Stage) signInButton.getScene().getWindow();
            stageOld.close();

           // stage.getIcons().add(new Image(App.class.getResourceAsStream("logos/vut.jpg")));
            authConfirmDialog();

            stage.show();
        } catch (IOException ex) {
            ExceptionHandler.handleException(ex);
        }
    }

    private void showInvalidPaswordDialog() {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Unauthenticated");
        alert.setHeaderText("The user is not authenticated");
        alert.setContentText("Please provide a valid username and password");//ww  w . j  a  va2s  .  co  m

        alert.showAndWait();
    }


    private void authConfirmDialog() {
        Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
        alert.setTitle("Logging confirmation");
        alert.setHeaderText("You were successfully logged in.");

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

        if (result.get() == ButtonType.OK) {
            System.out.println("ok clicked");
        } else if (result.get() == ButtonType.CANCEL) {
            System.out.println("cancel clicked");
        }
    }
    @FXML
    private void handleClose(javafx.scene.input.MouseEvent mouseEvent) {
        if (mouseEvent.getSource() == exitButton) {
            System.exit(0);
        }
    }
    @FXML
    private void handleMinimize(javafx.scene.input.MouseEvent mouseEvent) {
        if (mouseEvent.getSource() == minimizeButton) {
            Stage stage = (Stage)((Label)mouseEvent.getSource()).getScene().getWindow();
            stage.setIconified(true);
        }
    }
    public void handleOnEnterActionPassword(ActionEvent dragEvent) {
        handleSignIn();
    }
}
