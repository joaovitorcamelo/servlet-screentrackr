package com.screentrackr.screentrackr.dao;

import com.screentrackr.screentrackr.model.User;

import java.sql.*;


public class UserDAO {

    private String jdbcURL = "jdbc:postgresql://localhost:5432/screentrackr";
    private String jdbcUsername = "postgres";
    private String jdbcPassword = "postgres";

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
        String sql = "INSERT INTO users (email, password) VALUES (?, ?)";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
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

    public User checkLogin(String email, String password) {
        User user = null;
        String sql = "SELECT id, email, auth_token, name FROM users WHERE email = ? AND password = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = new User();
                user.setId(resultSet.getInt("id"));
                user.setEmail(resultSet.getString("email"));
                user.setAuthToken(resultSet.getString("auth_token"));
                user.setName(resultSet.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public void updateUserAuthToken(String userEmail, String authToken) throws SQLException {
        String sql = "UPDATE users SET auth_token = ? WHERE email = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, authToken);
            preparedStatement.setString(2, userEmail);

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public void updateUserName(int userId, String name) throws SQLException {
        String sql = "UPDATE users SET name = ? WHERE id = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, name);
            preparedStatement.setInt(2, userId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public User getUserByAuthToken(String authToken) {
        User user = null;
        String sql = "SELECT id, email, name, auth_token FROM users WHERE auth_token = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, authToken);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = new User();
                user.setId(resultSet.getInt("id"));
                user.setEmail(resultSet.getString("email"));
                user.setName(resultSet.getString("name"));
                user.setAuthToken(resultSet.getString("auth_token"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    // Método para atualizar a bio do usuário
    public void updateUserBio(int userId, String bio) throws SQLException {
        String sql = "UPDATE users SET bio = ? WHERE id = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, bio);
            preparedStatement.setInt(2, userId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public User getUserById(int userId) throws SQLException {
        String sql = "SELECT id, name, bio FROM users WHERE id = ?";
        User user = null;

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = new User();
                user.setId(resultSet.getInt("id"));
                user.setName(resultSet.getString("name"));
                user.setBio(resultSet.getString("bio"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return user;
    }
}

