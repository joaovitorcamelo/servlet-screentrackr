package com.screentrackr.screentrackr.servlet;

import com.screentrackr.screentrackr.dao.UserDAO;
import com.screentrackr.screentrackr.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/GetUserProfileServlet")
public class GetUserProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdParam = request.getParameter("userId");
        if (userIdParam == null || userIdParam.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"status\":\"error\",\"message\":\"Missing userId parameter\"}");
            }
            return;
        }

        int userId;
        try {
            userId = Integer.parseInt(userIdParam);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"status\":\"error\",\"message\":\"Invalid userId format\"}");
            }
            return;
        }

        try {
            User user = userDAO.getUserById(userId);
            System.out.println(user);
            System.out.println(user.getName());
            System.out.println(user.getBio());
            if (user != null) {
                response.setContentType("application/json");
                try (PrintWriter out = response.getWriter()) {
                    out.print("{\"status\":\"success\",");
                    out.print("\"name\":\"" + user.getName() + "\",");
                    out.print("\"bio\":\"" + user.getBio() + "\"}");
                }
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.setContentType("application/json");
                try (PrintWriter out = response.getWriter()) {
                    out.print("{\"status\":\"error\",\"message\":\"User not found\"}");
                }
            }
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
            }
        }
    }
}
