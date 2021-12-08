package bds.javafx.data;

import bds.javafx.api.*;
import bds.javafx.exceptions.DataAccessException;
import bds.javafx.config.DataSourceConfig;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeRepository {

    public EmployeeAuthView findEmployeeByEmail(String email) {
        try (Connection connection = DataSourceConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "SELECT email, pwd" +
                             " FROM employee e" +
                             " WHERE e.email = ?")
        ) {
            preparedStatement.setString(1, email);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return mapToEmployeeAuth(resultSet);
                }
            }
        } catch (SQLException e) {
            throw new DataAccessException("Find employee by ID with addresses failed.", e);
        }
        return null;
    }
    public List<EmployeeBasicView> getEmployeesBasicView() {
        try (Connection connection = DataSourceConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "SELECT e.employee_id, e.first_name, e.surname, e.email, b.building_name FROM employee e LEFT JOIN building b ON e.building_id = b.building_id ");
             ResultSet resultSet = preparedStatement.executeQuery();) {
            List<EmployeeBasicView> employeeBasicViews = new ArrayList<>();
            while (resultSet.next()) {
                employeeBasicViews.add(mapToEmployeeBasicView(resultSet));
            }
            return employeeBasicViews;
        } catch (SQLException e) {
            throw new DataAccessException("Employee basic view could not be loaded.", e);
        }
    }
    public List<EmployeeBasicView> findAll() {
        try (Connection connection = DataSourceConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "SELECT employee_id, first_name, surname, first_name, surname, email, building_id FROM employee");
             ResultSet resultSet = preparedStatement.executeQuery()) {
            List<EmployeeBasicView> employees = new ArrayList<>();
            while (resultSet.next()) {
                employees.add(mapToEmployeeBasicView(resultSet));
            }
            return employees;
        } catch (SQLException e) {
            throw new DataAccessException("Find all users SQL failed.", e);
        }
    }
    private EmployeeAuthView mapToEmployeeAuth(ResultSet rs) throws SQLException {
        EmployeeAuthView employee = new EmployeeAuthView();
        employee.setEmail(rs.getString("email"));
        employee.setPassword(rs.getString("pwd"));
        return employee;
    }

    private EmployeeBasicView mapToEmployeeBasicView(ResultSet rs) throws SQLException {
        EmployeeBasicView employee = new EmployeeBasicView();
        employee.setEmployeeId(rs.getLong("employee_id"));
        employee.setFirstName(rs.getString("first_name"));
        employee.setSurname(rs.getString("surname"));
        employee.setEmail(rs.getString("email"));
        employee.setBuilding(rs.getString("building_name"));
        return employee;
    }
}
