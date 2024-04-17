package com.screentrackr.screentrackr.servlet;

import com.screentrackr.screentrackr.model.User;
import com.screentrackr.screentrackr.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        String errorMessage = "";
        boolean errorPresent = false;

        if (password == null || !password.equals(confirmPassword)) {
            errorMessage = "Passwords do not match. ";
            errorPresent = true;
        }

        if (userDAO.emailExists(email)) {
            errorMessage = "The email is already in use. ";
            errorPresent = true;
        }

        if (errorPresent) {
            request.getSession().setAttribute("errorMessage", errorMessage.trim());
            response.sendRedirect(request.getContextPath() + "/pages/register/register.jsp");
            return;
        }

        User user = new User();
        user.setEmail(email);
        user.setPassword(password);

        try {
            userDAO.registerUser(user);
            // Message to be displayed on the login page
            request.getSession().setAttribute("message", "Registration completed successfully! Please log in.");
            // Redirect to the login page
            response.sendRedirect(request.getContextPath() + "/pages/login/login.jsp");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error registering user: " + e.getMessage());
            request.getRequestDispatcher(request.getContextPath() + "/pages/register/register.jsp").forward(request, response);
        }
    }
}
