package bds.javafx.api;

import java.util.Arrays;

public class EmployeeCreateView {
    private String email;
    private String firstName;
    private String surname;
    private Long buildingID;
    private char[] pwd;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public Long getBuildingID() {
        return buildingID;
    }

    public void setBuildingID(Long buildingID) {
        this.buildingID = buildingID;
    }

    public char[] getPwd() {
        return pwd;
    }

    public void setPwd(char[] pwd) {
        this.pwd = pwd;
    }

    @Override
    public String toString() {
        return "PersonCreateView{" +
                "email='" + email + '\'' +
                ", firstName='" + firstName + '\'' +
               ", buildingID='" + buildingID + '\'' +
                ", surname='" + surname + '\'' +
                ", pwd=" + Arrays.toString(pwd) +
                '}';
    }
}
