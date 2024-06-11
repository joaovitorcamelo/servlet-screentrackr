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
import java.util.List;

@WebServlet("/DeleteFilmRelationServlet")
public class DeleteFilmRelationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserFilmRelationDAO userFilmRelationDAO;

    public void init() {
        userFilmRelationDAO = new UserFilmRelationDAO();
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obter dados diretamente da requisição
        int userId = Integer.parseInt(request.getParameter("userId"));
        String filmId = request.getParameter("filmId");

        try {
            userFilmRelationDAO.deleteRelation(userId, filmId);
            removeFilmRelationFromSession(request.getSession(), filmId, userId);

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

    private void removeFilmRelationFromSession(HttpSession session, String filmId, int userId) {
        List<UserFilmRelation> relations = (List<UserFilmRelation>) session.getAttribute("filmRelations");
        if (relations != null) {
            relations.removeIf(rel -> rel.getFilmId().equals(filmId) && rel.getUserId() == userId);
            session.setAttribute("filmRelations", relations);
        }
    }
}
