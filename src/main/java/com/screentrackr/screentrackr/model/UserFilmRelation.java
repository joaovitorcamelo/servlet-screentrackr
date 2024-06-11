package com.screentrackr.screentrackr.model;

import java.io.Serializable;

public class UserFilmRelation implements Serializable {
    private static final long serialVersionUID = 1L;

    private int userId;
    private String filmId;
    private String relationType;
    private boolean isFavorite;
    private String posterImgUrl;
    private String title;
    private String year;
    private String director;
    private String rating;
    private String votes;
    private String plot;

    public UserFilmRelation() {
    }

    public UserFilmRelation(int userId, String filmId, String relationType, boolean isFavorite, String posterImgUrl, String title, String year, String director, String rating, String votes, String plot) {
        this.userId = userId;
        this.filmId = filmId;
        this.relationType = relationType;
        this.isFavorite = isFavorite;
        this.posterImgUrl = posterImgUrl;
        this.title = title;
        this.year = year;
        this.director = director;
        this.rating = rating;
        this.votes = votes;
        this.plot = plot;
    }

    public UserFilmRelation(int userId, String filmId, String relationType, boolean isFavorite, String posterImgUrl) {
    }

    // Getters and setters for all fields
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

    public boolean isFavorite() {
        return isFavorite;
    }

    public void setFavorite(boolean isFavorite) {
        this.isFavorite = isFavorite;
    }

    public String getPosterImgUrl() {
        return posterImgUrl;
    }

    public void setPosterImgUrl(String posterImgUrl) {
        this.posterImgUrl = posterImgUrl;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public String getVotes() {
        return votes;
    }

    public void setVotes(String votes) {
        this.votes = votes;
    }

    public String getPlot() {
        return plot;
    }

    public void setPlot(String plot) {
        this.plot = plot;
    }
}
