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
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public void addOrUpdateRelation(UserFilmRelation relation) throws SQLException {
        String sql = "INSERT INTO user_film_relations (user_id, film_id, relation_type, favorite, poster_img, title, year, director, rating, votes, plot) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ON CONFLICT (user_id, film_id) DO UPDATE SET relation_type = EXCLUDED.relation_type, favorite = EXCLUDED.favorite, poster_img = EXCLUDED.poster_img, title = EXCLUDED.title, year = EXCLUDED.year, director = EXCLUDED.director, rating = EXCLUDED.rating, votes = EXCLUDED.votes, plot = EXCLUDED.plot";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, relation.getUserId());
            preparedStatement.setString(2, relation.getFilmId());
            preparedStatement.setString(3, relation.getRelationType());
            preparedStatement.setBoolean(4, relation.isFavorite());
            preparedStatement.setString(5, relation.getPosterImgUrl());
            preparedStatement.setString(6, relation.getTitle());
            preparedStatement.setString(7, relation.getYear());
            preparedStatement.setString(8, relation.getDirector());
            preparedStatement.setString(9, relation.getRating());
            preparedStatement.setString(10, relation.getVotes());
            preparedStatement.setString(11, relation.getPlot());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
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
                        resultSet.getString("poster_img"),
                        resultSet.getString("title"),
                        resultSet.getString("year"),
                        resultSet.getString("director"),
                        resultSet.getString("rating"),
                        resultSet.getString("votes"),
                        resultSet.getString("plot")
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
            e.printStackTrace();
            throw e;
        }
    }

    public UserFilmRelation getRelationByUserAndFilm(int userId, String filmId) {
        String sql = "SELECT * FROM user_film_relations WHERE user_id = ? AND film_id = ?";
        UserFilmRelation relation = null;

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
                        resultSet.getBoolean("favorite"),
                        resultSet.getString("poster_img"),
                        resultSet.getString("title"),
                        resultSet.getString("year"),
                        resultSet.getString("director"),
                        resultSet.getString("rating"),
                        resultSet.getString("votes"),
                        resultSet.getString("plot")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return relation;
    }

}
