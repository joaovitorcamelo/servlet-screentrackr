package com.screentrackr.screentrackr.model;

import java.io.Serializable;

public class UserFilmRelation implements Serializable {
    private static final long serialVersionUID = 1L;

    private int userId;
    private String filmId;
    private String relationType;
    private boolean isFavorite;
    private String posterImgUrl; // Novo campo para armazenar a URL do pôster

    // Default constructor
    public UserFilmRelation() {
        // Constructor body can be empty
    }

    // Parameterized constructor
    public UserFilmRelation(int userId, String filmId, String relationType, boolean isFavorite, String posterImgUrl) {
        this.userId = userId;
        this.filmId = filmId;
        this.relationType = relationType;
        this.isFavorite = isFavorite;
        this.posterImgUrl = posterImgUrl; // Inicialização do novo campo
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
}
