package bds.javafx.data;

import bds.javafx.api.SQLInjectionView;
import bds.javafx.exceptions.DataAccessException;
import bds.javafx.config.DataSourceConfig;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class SQLInjectionRepository {

    public List<SQLInjectionView> findByIDStatement(Long id) {
    String sqlResult = "SELECT employee_id, email, name FROM dummy_table WHERE employee_id='" + id + "'";
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
        sqlInjectionView.setFullName(resultSet.getString("name"));
        return sqlInjectionView;
    }
}
