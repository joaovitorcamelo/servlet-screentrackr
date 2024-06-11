package com.screentrackr.screentrackr.servlet;

import com.screentrackr.screentrackr.dao.UserDAO;
import com.screentrackr.screentrackr.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UpdateNameServlet")
public class UpdateNameServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String userIdStr = request.getParameter("userId");

        if (userIdStr != null && !userIdStr.isEmpty() && name != null && !name.trim().isEmpty()) {
            try {
                int userId = Integer.parseInt(userIdStr);
                userDAO.updateUserName(userId, name);

                // Atualizar o nome do usuário na sessão
                User user = (User) request.getSession().getAttribute("user");
                if (user != null && user.getId() == userId) {
                    user.setName(name);
                }

                response.setContentType("application/json");
                response.getWriter().write("{\"status\": \"success\"}");
            } catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"status\": \"error\", \"message\": \"Failed to update name.\"}");
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Invalid request.\"}");
        }
    }
}
