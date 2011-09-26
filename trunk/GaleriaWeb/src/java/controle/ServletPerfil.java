/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import dao.Dao;
import entidades.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author a968501
 */
public class ServletPerfil extends HttpServlet {

    Dao<Usuario> daoUsuario = new Dao<Usuario>(Usuario.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        Usuario perfil = daoUsuario.get(id);

        List<Usuario> listamigos = usuario.getAmigos();
        boolean amigos = false;

        for (Usuario u : listamigos) {
            if (u == perfil) {
                amigos = true;
                break;
            }
        }
        session.setAttribute("amigos", amigos);
        session.setAttribute("perfil", perfil);

        response.sendRedirect("exibeperfil.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("btAdd"));
        HttpSession session = request.getSession(false);

        Usuario usuario = (Usuario) session.getAttribute("usuario");
        Usuario novoamigo = daoUsuario.get(id);
        List<Usuario> listamigos = usuario.getAmigos();
        if (novoamigo != null) {
            listamigos.add(novoamigo);
            usuario.setAmigos(listamigos);
            session.removeAttribute("amigos");
        }
        
        daoUsuario.update(usuario);

        response.sendRedirect("exibeperfil.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
