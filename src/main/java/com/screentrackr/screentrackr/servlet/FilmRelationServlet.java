package com.screentrackr.screentrackr.servlet;

import com.screentrackr.screentrackr.dao.UserFilmRelationDAO;
import com.screentrackr.screentrackr.model.UserFilmRelation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/FilmRelationServlet")
public class FilmRelationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserFilmRelationDAO userFilmRelationDAO;

    public void init() {
        userFilmRelationDAO = new UserFilmRelationDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getSession().getAttribute("userId").toString()); // Assuming the user ID is stored in the session
        String filmId = request.getParameter("filmId");
        String relationType = request.getParameter("relationType");
        double hoursWatched = Double.parseDouble(request.getParameter("hoursWatched"));
        double rating = Double.parseDouble(request.getParameter("rating"));

        UserFilmRelation relation = new UserFilmRelation(userId, filmId, relationType, hoursWatched, rating);

        try {
            userFilmRelationDAO.addOrUpdateRelation(relation);
            // Redirect to the page showing user's films
            response.sendRedirect(request.getContextPath() + "/pages/tracker/tracker.jsp");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error processing film relation: " + e.getMessage());
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
        }
    }
}

