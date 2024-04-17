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
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        User user = (User) request.getSession().getAttribute("user");
        if (user != null && name != null) {
            try {
                userDAO.updateUserName(user.getId(), name);
                user.setName(name);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/pages/tracker/tracker.jsp");
    }
}
