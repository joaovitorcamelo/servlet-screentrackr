package com.screentrackr.screentrackr.dao;

import com.screentrackr.screentrackr.model.User;

import java.sql.*;

public class UserDAO {

    private String jdbcURL = "jdbc:postgresql://localhost:5432/screentrackr";
    private String jdbcUsername = "postgres";
    private String jdbcPassword = "postgres";

    private static final String INSERT_USERS_SQL = "INSERT INTO users" +
            "  (email, password) VALUES " +
            " (?, ?);";

    public UserDAO() {
    }

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException e) {
            // Handle SQL exception
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            // Handle class not found exception
            e.printStackTrace();
        }
        return connection;
    }

    public void registerUser(User user) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USERS_SQL)) {
            preparedStatement.setString(1, user.getEmail());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            // Handle SQL exception
            e.printStackTrace();
            throw e;
        }
    }

    public boolean emailExists(String email) {
        boolean emailTaken = false;
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                emailTaken = resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return emailTaken;
    }

    // Outros métodos CRUD podem ser adicionados aqui (ex: selectUser, updateUser, deleteUser...)
}

