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
    public List<EmployeeBasicView> getEmployeesByName(String firstname) {
        System.out.println(firstname);
        try (Connection connection = DataSourceConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     " SELECT e.employee_id, e.first_name, e.surname, e.email, b.building_name FROM employee e " +
                             " LEFT JOIN building b ON e.building_id = b.building_id WHERE e.first_name =?");
        ) {
            preparedStatement.setString(1, firstname);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    List<EmployeeBasicView> employeeBasicViews = new ArrayList<>();
                    while (resultSet.next()) {
                        employeeBasicViews.add(mapToEmployeeBasicView(resultSet));
                    }
                    return employeeBasicViews;
                }
            } catch(SQLException e){
                throw new DataAccessException("Employee basic view could not be loaded.", e);
            }

    }
   /* public List<EmployeeBasicView> findAll() {
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
    }*/
    public EmployeeDetailView findEmployeeDetailedView(Long employeeId) {
        try (Connection connection = DataSourceConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                 /*    "SELECT e.employee_id, e.first_name, e.surname, e.email, b.building_name FROM employee e" +
                             " LEFT JOIN building b ON e.building_id = b.building_id WHERE e.employee_id = ?")*/
                     "SELECT e.employee_id, first_name, surname, email, building_name, job_type,salary," +
                        "contract_expiration, address_type, city, street, street_number, zip_code" +
                             " FROM employee e LEFT JOIN building b ON e.building_id = b.building_id " +
                             " LEFT JOIN employee_has_contract ehc ON ehc.employee_id = e.employee_id" +
                             " LEFT JOIN job j ON j.job_id = ehc.job_id" +
                             " LEFT JOIN employee_has_address eha ON eha.employee_id = e.employee_id" +
                             " LEFT JOIN address a ON a.address_id = eha.address_id"+
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
    public void editEmployee(EmployeeEditView employeeEditView) {
        String insertEmployeeSQL = "UPDATE employee e SET email = ?, first_name = ?, surname = ? WHERE e.employee_id = ?";
        String checkIfExists = "SELECT email FROM employee e WHERE e.employee_id = ?";
        try (Connection connection = DataSourceConfig.getConnection();
             // would be beneficial if I will return the created entity back
             PreparedStatement preparedStatement = connection.prepareStatement(insertEmployeeSQL, Statement.RETURN_GENERATED_KEYS)) {
            // set prepared statement variables
            preparedStatement.setString(1, employeeEditView.getEmail());
            preparedStatement.setString(2, employeeEditView.getFirstName());
            preparedStatement.setString(3, employeeEditView.getSurname());
           // preparedStatement.setString(3, employeeEditView.getBuilding());
            preparedStatement.setLong(4, employeeEditView.getId());

            try {
                connection.setAutoCommit(false);
                try (PreparedStatement ps = connection.prepareStatement(checkIfExists, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setLong(1, employeeEditView.getId());
                    ps.execute();
                } catch (SQLException e) {
                    throw new DataAccessException("This employee for edit do not exists.");
                }

                int affectedRows = preparedStatement.executeUpdate();

                if (affectedRows == 0) {
                    throw new DataAccessException("Creating employee failed, no rows affected.");
                }
                connection.commit();
            } catch (SQLException e) {
                connection.rollback();
            } finally {
                connection.setAutoCommit(true);
            }
        } catch (SQLException e) {
            throw new DataAccessException("Creating employee failed operation on the database failed.");
        }
    }

    public void createEmployee(EmployeeCreateView employeeCreateView) {
        String insertPersonSQL = "INSERT INTO employee (email, first_name, surname, building_id, pwd) VALUES (?,?,?,?,?)";
        try (Connection connection = DataSourceConfig.getConnection();
             // would be beneficial if I will return the created entity back
             PreparedStatement preparedStatement = connection.prepareStatement(insertPersonSQL, Statement.RETURN_GENERATED_KEYS)) {
            // set prepared statement variables
            preparedStatement.setString(1, employeeCreateView.getEmail());
            preparedStatement.setString(2, employeeCreateView.getFirstName());
            preparedStatement.setString(3, employeeCreateView.getSurname());
            preparedStatement.setLong(4, employeeCreateView.getBuildingID());
            preparedStatement.setString(5, String.valueOf(employeeCreateView.getPwd()));

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows == 0) {
                throw new DataAccessException("Creating employee failed, no rows affected.");
            }
        } catch (SQLException e) {
            throw new DataAccessException("Creating employee failed operation on the database failed.");
        }
    }
    public void deleteEmployee(EmployeeBasicView employeeBasicView) {
        String deleteEmployeeSQL = "DELETE FROM employee WHERE employee_id = ?";
        try (Connection connection = DataSourceConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(deleteEmployeeSQL, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setLong(1, employeeBasicView.getEmployeeId());

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows == 0) {
                throw new DataAccessException("Deleting employee failed, no rows affected.");
            }
        } catch (SQLException e) {
            throw new DataAccessException("Deleting employee failed operation on the database failed.");
        }
    }
    private EmployeeAuthView mapToEmployeeAuth(ResultSet rs) throws SQLException {
        EmployeeAuthView employee = new EmployeeAuthView();
        employee.setEmail(rs.getString("email"));
        employee.setPassword(rs.getString("pwd"));
        return employee;
    }

    private EmployeeBasicView mapToEmployeeBasicView(ResultSet rs) throws SQLException {
        EmployeeBasicView employeeBasicView = new EmployeeBasicView();
        employeeBasicView.setEmployeeId(rs.getLong("employee_id"));
        employeeBasicView.setFirstName(rs.getString("first_name"));
        employeeBasicView.setSurname(rs.getString("surname"));
        employeeBasicView.setEmail(rs.getString("email"));
        employeeBasicView.setBuilding(rs.getString("building_name"));
        return employeeBasicView;
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
        employeeDetailView.setContractExpiration(rs.getString("contract_expiration"));
        employeeDetailView.setAddressType(rs.getString("address_type"));
        employeeDetailView.setJobType(rs.getString("job_type"));
        employeeDetailView.setStreet(rs.getString("street"));
        employeeDetailView.setStreetNumber(rs.getLong("street_number"));
        employeeDetailView.setZipCode(rs.getLong("zip_code"));
        return employeeDetailView;
    }
}
