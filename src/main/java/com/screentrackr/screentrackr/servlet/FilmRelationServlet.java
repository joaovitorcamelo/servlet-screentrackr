package com.screentrackr.screentrackr.servlet;

import com.screentrackr.screentrackr.dao.UserFilmRelationDAO;
import com.screentrackr.screentrackr.model.User;
import com.screentrackr.screentrackr.model.UserFilmRelation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User is missing in session.");
            return;
        }

        int userId = user.getId();
        String filmId = request.getParameter("filmId");
        String relationType = request.getParameter("relationType");
        boolean isFavorite = Boolean.parseBoolean(request.getParameter("favorite"));

        UserFilmRelation relation = new UserFilmRelation(userId, filmId, relationType, isFavorite);

        try {
            userFilmRelationDAO.addOrUpdateRelation(relation);
            updateFilmRelationsInSession(session, relation);

            response.sendRedirect(request.getContextPath() + "/pages/tracker/tracker.jsp");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error processing film relation: " + e.getMessage());
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
        }
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User is missing.");
            return;
        }

        int userId = user.getId();
        String filmId = request.getParameter("filmId");

        try {
            userFilmRelationDAO.deleteRelation(userId, filmId);
            removeFilmRelationFromSession(request.getSession(), filmId, userId);

            response.getWriter().write("Relation deleted successfully");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error deleting film relation: " + e.getMessage());
        }
    }

    private void updateFilmRelationsInSession(HttpSession session, UserFilmRelation relation) {
        List<UserFilmRelation> relations = (List<UserFilmRelation>) session.getAttribute("filmRelations");
        if (relations == null) {
            relations = new ArrayList<>();
        }
        relations.add(relation);
        session.setAttribute("filmRelations", relations);
    }

    private void removeFilmRelationFromSession(HttpSession session, String filmId, int userId) {
        List<UserFilmRelation> relations = (List<UserFilmRelation>) session.getAttribute("filmRelations");
        if (relations != null) {
            relations.removeIf(rel -> rel.getFilmId().equals(filmId) && rel.getUserId() == userId);
            session.setAttribute("filmRelations", relations);
        }
    }
}
