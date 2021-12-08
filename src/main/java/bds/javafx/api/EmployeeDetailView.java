package bds.javafx.api;

import javafx.beans.property.LongProperty;
import javafx.beans.property.SimpleLongProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;

public class EmployeeDetailView {
    private LongProperty id = new SimpleLongProperty();
    private StringProperty firstname = new SimpleStringProperty();
    private StringProperty surname = new SimpleStringProperty();
    private StringProperty email = new SimpleStringProperty();
    private StringProperty building = new SimpleStringProperty();
    private StringProperty job_type = new SimpleStringProperty();
    private LongProperty salary = new SimpleLongProperty();
    private StringProperty contract_expiration = new SimpleStringProperty();
    private StringProperty address_type = new SimpleStringProperty();
    private StringProperty city = new SimpleStringProperty();
    private StringProperty street = new SimpleStringProperty();
    private LongProperty street_number = new SimpleLongProperty();
    private LongProperty zip_code = new SimpleLongProperty();

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

    public String getJobType() {
        return job_typeProperty().get();
    }

    public void setJobType(String job_type) {
        this.job_typeProperty().setValue(job_type);
    }

    public Long getSalary() {
        return salaryProperty().get();
    }

    public void setSalary(Long salary) {
        this.salaryProperty().setValue(salary);
    }

    public String getContractExpiration() {
        return contract_expirationProperty().get();
    }

    public void setContractExpiration(String contract_expiration) {
        this.contract_expirationProperty().setValue(contract_expiration);
    }

    public String getAddressType() {
        return address_typeProperty().get();
    }

    public void setAddressType(String address_type) {
        this.address_typeProperty().setValue(address_type);
    }

    public String getCity() {
        return cityProperty().get();
    }

    public void setCity(String city ) {
        this.cityProperty().setValue(city);
    }

    public String getStreet() {
        return streetProperty().get();
    }

    public void setStreet(String street ) {
        this.streetProperty().setValue(street);
    }

    public Long getStreetNumber() {
        return street_numberProperty().get();
    }

    public void setStreetNumber(Long street_number) {
        this.street_numberProperty().setValue(street_number);
    }

    public Long getZipCode() {
        return zip_codeProperty().get();
    }

    public void setZipCode(Long zip_code) {
        this.zip_codeProperty().setValue(zip_code);
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

    public StringProperty job_typeProperty() {return job_type;}

    public LongProperty salaryProperty() {return salary;}

    public StringProperty contract_expirationProperty() {return contract_expiration;}

    public StringProperty address_typeProperty() {return address_type;}

    public StringProperty cityProperty() {return city;}

    public StringProperty streetProperty() {return street;}

    public LongProperty street_numberProperty() {return street_number;}

    public LongProperty zip_codeProperty() {return zip_code;}




}
