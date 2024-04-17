package com.screentrackr.screentrackr.servlet;

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
        if (user != null) {
            String currentToken = user.getAuthToken();

            String newAuthToken = UUID.randomUUID().toString();

            try {
                userDAO.updateUserAuthToken(user.getEmail(), newAuthToken);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

            request.getSession().setAttribute("authToken", newAuthToken);
            request.getSession().setAttribute("user", user);

            if (currentToken == null) {
                response.sendRedirect(request.getContextPath() + "/pages/after_first_log/after_first_log.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/tracker/tracker.jsp");
            }
        } else {
            request.setAttribute("message", "Credenciais inválidas.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

}
