package bds.javafx.api;

import javafx.beans.property.LongProperty;
import javafx.beans.property.SimpleLongProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;

public class EmployeeBasicView {
    private LongProperty id = new SimpleLongProperty();
    private StringProperty firstname = new SimpleStringProperty();
    private StringProperty surname = new SimpleStringProperty();
    private StringProperty email = new SimpleStringProperty();
    private StringProperty building = new SimpleStringProperty();

    public Long getEmployeeId() {
        return idProperty().get();
    }

    public void setEmployeeId(Long id) {
        this.idProperty().setValue(id);
    }

    public String getFirstName() {
        return firstnameProperty().get();
    }

    public void setFirstName(String firstname) {
        this.firstnameProperty().setValue(firstname);
    }

    public String getEmail() {
        return emailProperty().get();
    }

    public void setEmail(String email) {
        this.emailProperty().setValue(email);
    }

    public String getSurname() {
        return surnameProperty().get();
    }

    public void setSurname(String surname) {
        this.surnameProperty().setValue(surname);
    }

    public String getBuilding() {
        return buildingProperty().get();
    }

    public void setBuilding(String building) {
        this.buildingProperty().setValue(building);
    }


    public LongProperty idProperty() {
        return id;
    }

    public StringProperty firstnameProperty() {
        return firstname;
    }

    public StringProperty emailProperty() {
        return email;
    }

    public StringProperty surnameProperty() {
        return surname;
    }

    public StringProperty buildingProperty() {
        return building;
    }


}
