package com.screentrackr.screentrackr.dao;

import com.screentrackr.screentrackr.model.UserFilmRelation;
import java.sql.*;

public class UserFilmRelationDAO {

    private String jdbcURL = "jdbc:postgresql://localhost:5432/screentrackr";
    private String jdbcUsername = "postgres";
    private String jdbcPassword = "postgres";

    public UserFilmRelationDAO() {
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

    public void addOrUpdateRelation(UserFilmRelation relation) throws SQLException {
        String sql = "INSERT INTO user_film_relations (user_id, film_id, relation_type, hours_watched, rating) VALUES (?, ?, ?, ?, ?) ON CONFLICT (user_id, film_id) DO UPDATE SET relation_type = EXCLUDED.relation_type, hours_watched = EXCLUDED.hours_watched, rating = EXCLUDED.rating";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, relation.getUserId());
            preparedStatement.setString(2, relation.getFilmId());
            preparedStatement.setString(3, relation.getRelationType());
            preparedStatement.setDouble(4, relation.getHoursWatched());
            preparedStatement.setDouble(5, relation.getRating());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            // Handle SQL exception
            e.printStackTrace();
            throw e;
        }
    }

    public UserFilmRelation findRelationByUserIdAndFilmId(int userId, String filmId) {
        UserFilmRelation relation = null;
        String sql = "SELECT * FROM user_film_relations WHERE user_id = ? AND film_id = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setString(2, filmId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                relation = new UserFilmRelation(
                        resultSet.getInt("user_id"),
                        resultSet.getString("film_id"),
                        resultSet.getString("relation_type"),
                        resultSet.getDouble("hours_watched"),
                        resultSet.getDouble("rating")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return relation;
    }
}
