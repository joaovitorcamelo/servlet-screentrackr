package com.screentrackr.screentrackr.servlet;

import com.google.gson.JsonObject;
import com.screentrackr.screentrackr.model.User;
import com.screentrackr.screentrackr.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.UUID;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDAO.checkLogin(email, password);
        JsonObject jsonResponse = new JsonObject();

        if (user != null) {
            boolean firstLogin = (user.getAuthToken() == null);

            String newAuthToken = UUID.randomUUID().toString();

            try {
                userDAO.updateUserAuthToken(user.getEmail(), newAuthToken);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

            request.getSession().setAttribute("authToken", newAuthToken);
            request.getSession().setAttribute("user", user);

            // Montar a resposta JSON
            jsonResponse.addProperty("status", "success");
            jsonResponse.addProperty("firstLogin", firstLogin);
            jsonResponse.addProperty("authToken", newAuthToken);
            jsonResponse.addProperty("userId", user.getId()); // Adicionar ID do usuário para identificação

            response.setContentType("application/json");
            response.getWriter().write(jsonResponse.toString());
        } else {
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", "Invalid credentials.");
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(jsonResponse.toString());
        }
    }
}
