package bds.javafx.data;

import bds.javafx.api.SQLInjectionView;
import bds.javafx.exceptions.DataAccessException;
import bds.javafx.config.DataSourceConfig;
import bds.javafx.controllers.SQLInjectionController;
import javafx.scene.control.Alert;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class SQLInjectionRepository {

    public void ErrorDialog() {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Error Dialog");
        alert.setHeaderText("Error");
        alert.setContentText("Ooops, something is wrong!");

        alert.showAndWait();
    }
    public List<SQLInjectionView> findByIDStatement(String id) {
    String sqlResult = "SELECT employee_id, email, name FROM dummy_table WHERE employee_id=" + id ;
        try (Connection connection = DataSourceConfig.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sqlResult)) {
            List<SQLInjectionView> SQLInjectionViews = new ArrayList<>();
            while (resultSet.next()) {
                SQLInjectionViews.add(mapToSQLInjectionView(resultSet));
            }
            return SQLInjectionViews;
        } catch (SQLException e) {
            throw new DataAccessException("Find employee failed.", e);
        }
    }

    private SQLInjectionView mapToSQLInjectionView(ResultSet resultSet) throws SQLException {
        SQLInjectionView sqlInjectionView = new SQLInjectionView();
        sqlInjectionView.setId(resultSet.getLong("employee_id"));
        sqlInjectionView.setEmail(resultSet.getString("email"));
        sqlInjectionView.setName(resultSet.getString("name"));
        return sqlInjectionView;
    }
}
