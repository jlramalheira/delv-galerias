/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import dao.Dao;
import dao.DaoUsuario;
import entidades.Usuario;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Login extends HttpServlet {

    Dao<Usuario> daoUsuario = new Dao<Usuario>(Usuario.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        session.invalidate();
        response.sendRedirect("home.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String login = request.getParameter("login");
        String senha = request.getParameter("password");

        List<Usuario> usuarios = new DaoUsuario(Usuario.class).listByLogin(login);

        HttpSession session = request.getSession(true);
        String mensagem = new String();

        if (usuarios.isEmpty()) {
            mensagem = "Login invalido <br />";
        } else {
            Usuario u = usuarios.get(0);
            if (u.getSenha().equals(senha)) {
                session.setAttribute("usuario", u);
                
            } else {
                mensagem += "Senha invalida";
            }

        }

        if (mensagem.isEmpty()) {
            response.sendRedirect("home.jsp");
        } else {
            session.setAttribute("mensagem", mensagem);
            session.setAttribute("login", login);

            response.sendRedirect("login.jsp");
        }

    }
}