package com.screentrackr.screentrackr.dao;

import com.screentrackr.screentrackr.model.UserFilmRelation;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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
        String sql = "INSERT INTO user_film_relations (user_id, film_id, relation_type, favorite, poster_img) VALUES (?, ?, ?, ?, ?) ON CONFLICT (user_id, film_id) DO UPDATE SET relation_type = EXCLUDED.relation_type, favorite = EXCLUDED.favorite, poster_img = EXCLUDED.poster_img";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, relation.getUserId());
            preparedStatement.setString(2, relation.getFilmId());
            preparedStatement.setString(3, relation.getRelationType());
            preparedStatement.setBoolean(4, relation.isFavorite());
            preparedStatement.setString(5, relation.getPosterImgUrl()); // Adicionar URL do pôster

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            // Handle SQL exception
            e.printStackTrace();
            throw e;
        }
    }

    public List<UserFilmRelation> getAllRelationsForUser(int userId) {
        List<UserFilmRelation> relations = new ArrayList<>();
        String sql = "SELECT * FROM user_film_relations WHERE user_id = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                UserFilmRelation relation = new UserFilmRelation(
                        resultSet.getInt("user_id"),
                        resultSet.getString("film_id"),
                        resultSet.getString("relation_type"),
                        resultSet.getBoolean("favorite"),
                        resultSet.getString("poster_img")
                );
                relations.add(relation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return relations;
    }

    public void deleteRelation(int userId, String filmId) throws SQLException {
        String sql = "DELETE FROM user_film_relations WHERE user_id = ? AND film_id = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setString(2, filmId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            // Handle SQL exception
            e.printStackTrace();
            throw e;
        }
    }
}
