package com.screentrackr.screentrackr.servlet;

import com.screentrackr.screentrackr.model.UserFilmRelation;
import com.screentrackr.screentrackr.dao.UserFilmRelationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.UUID;
@WebServlet("/FilmRelationServlet")
public class FilmRelationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserFilmRelationDAO userFilmRelationDAO;
    private final String API_KEY = "4408d32b"; // Substitua com sua chave de API

    public void init() {
        userFilmRelationDAO = new UserFilmRelationDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        if (title != null) {
            // Chamada à API OMDB para buscar filmes pelo título
            String url = "http://www.omdbapi.com/?s=" + URLEncoder.encode(title, "UTF-8") + "&apikey=" + API_KEY;
            // Processo de chamada HTTP para a API e parse do JSON omitido por simplicidade
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getSession().getAttribute("userId").toString());
        String filmId = request.getParameter("filmId");
        String relationType = request.getParameter("relationType");
        boolean favorite = Boolean.parseBoolean(request.getParameter("favorite"));

        UserFilmRelation relation = new UserFilmRelation(userId, filmId, relationType, favorite);

        try {
            userFilmRelationDAO.addOrUpdateRelation(relation);
            response.sendRedirect(request.getContextPath() + "/pages/tracker/tracker.jsp");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error processing film relation: " + e.getMessage());
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
        }
    }
}