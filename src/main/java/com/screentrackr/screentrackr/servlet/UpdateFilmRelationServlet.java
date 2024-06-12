package com.screentrackr.screentrackr.servlet;

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

@WebServlet("/UpdateFilmRelationServlet")
public class UpdateFilmRelationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserFilmRelationDAO userFilmRelationDAO;

    public void init() {
        userFilmRelationDAO = new UserFilmRelationDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obter dados diretamente da requisição
        int userId;
        String filmId = request.getParameter("filmId");
        String relationType = request.getParameter("relationType");
        boolean isFavorite;

        try {
            userId = Integer.parseInt(request.getParameter("userId"));
            isFavorite = Boolean.parseBoolean(request.getParameter("favorite"));
        } catch (NumberFormatException e) {
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            PrintWriter out = response.getWriter();
            out.print("{\"status\":\"error\", \"message\":\"Invalid userId or isFavorite format: " + e.getMessage() + "\"}");
            out.flush();
            return;
        }

        // Cria um objeto UserFilmRelation para a atualização
        UserFilmRelation relation = new UserFilmRelation(userId, filmId, relationType, isFavorite, null, null, null, null, null, null, null);

        try {
            userFilmRelationDAO.updateRelation(relation);
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
        // Atualiza a relação existente ou adiciona uma nova se não existir
        relations.removeIf(r -> r.getFilmId().equals(relation.getFilmId()) && r.getUserId() == relation.getUserId());
        relations.add(relation);
        session.setAttribute("filmRelations", relations);
    }
}
