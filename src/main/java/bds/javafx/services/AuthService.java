package bds.javafx.services;

import at.favre.lib.crypto.bcrypt.BCrypt;
import bds.javafx.api.EmployeeAuthView;
import bds.javafx.data.EmployeeRepository;
import bds.javafx.exceptions.ResourceNotFoundException;

public class AuthService {
    private EmployeeRepository employeeRepository;

    public AuthService(EmployeeRepository employeeRepository) {
        this.employeeRepository = employeeRepository;
    }

    private EmployeeAuthView findEmployeeByEmail(String email) {
        return employeeRepository.findEmployeeByEmail(email);
    }

    public boolean authenticate(String username, String password) {
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            return false;
        }

        EmployeeAuthView employeeAuthView = findEmployeeByEmail(username);
        if (employeeAuthView == null) {
            throw new ResourceNotFoundException("Provided username is not found.");
        }

        BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), employeeAuthView.getPassword());
        return result.verified;
    }
}