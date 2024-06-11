package com.screentrackr.screentrackr.servlet;

import com.google.gson.Gson;
import com.screentrackr.screentrackr.dao.UserFilmRelationDAO;
import com.screentrackr.screentrackr.model.UserFilmRelation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/FilmDetailsServlet")
public class FilmDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserFilmRelationDAO userFilmRelationDAO;

    public void init() {
        userFilmRelationDAO = new UserFilmRelationDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obter os parâmetros userId e filmId da requisição
        int userId = Integer.parseInt(request.getParameter("userId"));
        String filmId = request.getParameter("filmId");

        // Recuperar a relação específica do usuário e filme
        UserFilmRelation relation = userFilmRelationDAO.getRelationByUserAndFilm(userId, filmId);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if (relation != null) {
            // Retornar a relação em formato JSON
            out.print(new Gson().toJson(relation));
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            out.print("{\"status\":\"error\", \"message\":\"Film not found for this user.\"}");
        }
        out.flush();
    }
}
