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
import java.util.List;

@WebServlet("/LoadUserFilmsServlet")
public class LoadUserFilmsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserFilmRelationDAO userFilmRelationDAO;

    public void init() {
        userFilmRelationDAO = new UserFilmRelationDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obter o userId da requisição
        int userId = Integer.parseInt(request.getParameter("userId"));

        List<UserFilmRelation> relations = userFilmRelationDAO.getAllRelationsForUser(userId);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(relations));
        out.flush();
    }
}
