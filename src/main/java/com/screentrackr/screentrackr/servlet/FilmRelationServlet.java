package com.screentrackr.screentrackr.servlet;

import com.google.gson.Gson;
import com.screentrackr.screentrackr.dao.UserFilmRelationDAO;
import com.screentrackr.screentrackr.model.UserFilmRelation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/FilmRelationServlet")
public class FilmRelationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserFilmRelationDAO userFilmRelationDAO;

    public void init() {
        userFilmRelationDAO = new UserFilmRelationDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obter dados diretamente da requisição
        int userId = Integer.parseInt(request.getParameter("userId"));
        String filmId = request.getParameter("filmId");
        String relationType = request.getParameter("relationType");
        boolean isFavorite = Boolean.parseBoolean(request.getParameter("favorite"));
        String posterImgUrl = request.getParameter("posterImgUrl");
        String title = request.getParameter("title");
        String year = request.getParameter("year");
        String director = request.getParameter("director");
        String rating = request.getParameter("rating");
        String votes = request.getParameter("votes");
        String plot = request.getParameter("plot");

        // Cria um objeto UserFilmRelation com todos os campos
        UserFilmRelation relation = new UserFilmRelation(userId, filmId, relationType, isFavorite, posterImgUrl, title, year, director, rating, votes, plot);

        try {
            userFilmRelationDAO.addOrUpdateRelation(relation);
            updateFilmRelationsInSession(request.getSession(), relation);

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"status\":\"success\"}");
            out.flush();
        } catch (Exception e) {
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            PrintWriter out = response.getWriter();
            out.print("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
            out.flush();
        }
    }

    private void updateFilmRelationsInSession(HttpSession session, UserFilmRelation relation) {
        List<UserFilmRelation> relations = (List<UserFilmRelation>) session.getAttribute("filmRelations");
        if (relations == null) {
            relations = new ArrayList<>();
        }
        // Remove existing relation if present, then add the updated one
        relations.removeIf(r -> r.getFilmId().equals(relation.getFilmId()) && r.getUserId() == relation.getUserId());
        relations.add(relation);
        session.setAttribute("filmRelations", relations);
    }
}
