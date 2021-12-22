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
             ResultSet resultSet = preparedStatement.executeQuery()) {
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
    public EmployeeDetailView findEmployeeDetailedView(Long employeeId) {
        try (Connection connection = DataSourceConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "SELECT e.employee_id, e.first_name, e.surname, e.email, b.building_name, j.job_type,j.salary," +
                             " ehc.contract_expiration, eha.address_type, a.city, a.street, a.street_number, a.zip_code" +
                             "FROM employee e LEFT JOIN building b ON e.building_id = b.building_id " +
                             "JOIN employee_has_contract ehc ON ehc.employee_id = e.employee_ID" +
                             "JOIN job j ON j.job_id = ehc.job_id" +
                             "LEFT JOIN employee_has_address eha ON eha.employee_id = e.employee_ID" +
                             "LEFT JOIN address a ON a.address_id = eha.address_id"+
                             " WHERE e.employee_id = ?")
        ) {
            preparedStatement.setLong(1, employeeId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return mapToEmployeeDetailView(resultSet);
                }
            }
        } catch (SQLException e) {
            throw new DataAccessException("Find employee by ID with addresses failed.", e);
        }
        return null;
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
    private EmployeeDetailView mapToEmployeeDetailView(ResultSet rs) throws SQLException {
        EmployeeDetailView employeeDetailView = new EmployeeDetailView();
        employeeDetailView.setEmployeeId(rs.getLong("employee_id"));
        employeeDetailView.setEmail(rs.getString("email"));
        employeeDetailView.setFirstName(rs.getString("first_name"));
        employeeDetailView.setSurname(rs.getString("surname"));
        employeeDetailView.setBuilding(rs.getString("building_name"));
        employeeDetailView.setCity(rs.getString("city"));
        employeeDetailView.setSalary(rs.getLong("salary"));
        employeeDetailView.setContractExpiration("contract_expiration");
        employeeDetailView.setAddressType("address_type");
        employeeDetailView.setJobType(rs.getString("job_type"));
        employeeDetailView.setStreet(rs.getString("street"));
        employeeDetailView.setStreetNumber(rs.getLong("street_number"));
        employeeDetailView.setZipCode(rs.getLong("zip_code"));
        return employeeDetailView;
    }
}
