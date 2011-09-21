package controle;

import dao.Dao;
import entidades.Usuario;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class NovoUsuario extends HttpServlet {

    Dao<Usuario> daoUsuario = new Dao<Usuario>(Usuario.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Usuario> usuarios = daoUsuario.list();
        String login = request.getParameter("usuario");
        String email = request.getParameter("email");
        String senha = request.getParameter("password");

        HttpSession session = request.getSession(true);
        String mensagem = new String();
        for (Usuario u : usuarios) {
            if (u.getEmail().equalsIgnoreCase(email)) {
                mensagem = "Email ja cadastrado <br />";
            }
            if (u.getLogin().equalsIgnoreCase(login)) {
                mensagem += "Login ja cadastrado";
            }
        }

        if (mensagem.isEmpty()) {
            Usuario u = new Usuario();

            u.setLogin(login);
            u.setEmail(email);
            u.setSenha(senha);

            daoUsuario.insert(u);

            session.setAttribute("usuario", u);
                                 
            try {
                Email.sendEmail(email, "Obrigado por partiipar do Delv",
                        "Olá "+login+", \nObrigado por fazer a sua conta no Delv Galerias® "
                        + " \n\nA sua senha é: "+ senha +" \n\nAtenciosamente, Administrador.");
            } catch (Exception ex) {
                Logger.getLogger(NovoUsuario.class.getName()).log(Level.SEVERE, null, ex);
            }
         
            response.sendRedirect("editarperfil.jsp");
        } else {
            session.setAttribute("mensagem", mensagem);
            session.setAttribute("login", login);
            session.setAttribute("email", email);

            response.sendRedirect("cadastro.jsp");
        }


    }
}
