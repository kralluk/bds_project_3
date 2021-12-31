package bds.javafx.services;

import at.favre.lib.crypto.bcrypt.BCrypt;
import bds.javafx.api.ManagerAuthView;
import bds.javafx.data.EmployeeRepository;
import bds.javafx.exceptions.ResourceNotFoundException;

public class AuthService {
    private EmployeeRepository employeeRepository;

    public AuthService(EmployeeRepository employeeRepository) {
        this.employeeRepository = employeeRepository;
    }

    private ManagerAuthView findManagerByEmail(String email) {
        return employeeRepository.findManagerByEmail(email);
    }

    public boolean authenticate(String username, String password) {
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            return false;
        }

        ManagerAuthView managerAuthView = findManagerByEmail(username);
        if (managerAuthView == null) {
            throw new ResourceNotFoundException("Provided username is not found.");
        }

        BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), managerAuthView.getPassword());
        return result.verified;
    }
}