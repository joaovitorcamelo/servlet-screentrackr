package com.screentrackr.screentrackr.servlet;

import com.screentrackr.screentrackr.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/UpdateUserProfileServlet")
public class UpdateUserProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obter dados diretamente da requisição
        int userId = Integer.parseInt(request.getParameter("userId"));
        String name = request.getParameter("name");
        String bio = request.getParameter("bio");

        // Verifica se os parâmetros foram fornecidos
        if (name == null || bio == null || name.isEmpty() || bio.isEmpty()) {
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            PrintWriter out = response.getWriter();
            out.print("{\"status\":\"error\", \"message\":\"Name and Bio cannot be empty.\"}");
            out.flush();
            return;
        }

        try {
            // Atualiza o nome do usuário
            userDAO.updateUserName(userId, name);

            // Atualiza a bio do usuário
            userDAO.updateUserBio(userId, bio);

            // Configurar a resposta de sucesso
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"status\":\"success\", \"message\":\"User profile updated successfully.\"}");
            out.flush();
        } catch (Exception e) {
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            PrintWriter out = response.getWriter();
            out.print("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
            out.flush();
        }
    }
}
