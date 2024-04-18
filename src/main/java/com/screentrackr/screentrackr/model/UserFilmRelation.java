package com.screentrackr.screentrackr.model;

import java.io.Serializable;

public class UserFilmRelation implements Serializable {
    private static final long serialVersionUID = 1L;

    private int userId;
    private String filmId;
    private String relationType;
    private double hoursWatched;
    private double rating;

    public UserFilmRelation() {
    }

    public UserFilmRelation(int userId, String filmId, String relationType, double hoursWatched, double rating) {
        this.userId = userId;
        this.filmId = filmId;
        this.relationType = relationType;
        this.hoursWatched = hoursWatched;
        this.rating = rating;
    }

    // Getters and setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFilmId() {
        return filmId;
    }

    public void setFilmId(String filmId) {
        this.filmId = filmId;
    }

    public String getRelationType() {
        return relationType;
    }

    public void setRelationType(String relationType) {
        this.relationType = relationType;
    }

    public double getHoursWatched() {
        return hoursWatched;
    }

    public void setHoursWatched(double hoursWatched) {
        this.hoursWatched = hoursWatched;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }
}
