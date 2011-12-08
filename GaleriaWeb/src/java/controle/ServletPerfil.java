/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import dao.Dao;
import dao.DaoAtualizacao;
import entidades.Atualizacao;
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
    DaoAtualizacao daoAtualizacao = new DaoAtualizacao(Atualizacao.class);

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
        if (request.getParameter("btAdd") != null) {
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
            boolean agoraeh = true;
            
            Atualizacao a = new Atualizacao();
            a.setTipo("é seu novo amigo!");
            a.setRemetente(usuario);
            a.setDestinatario(novoamigo);
            daoAtualizacao.insert(a);
            
            session.setAttribute("perfil", novoamigo);
            session.setAttribute("agoraeh", agoraeh);

            response.sendRedirect("confirmacaoAmigos.jsp");
        } else {
            int id = Integer.parseInt(request.getParameter("btRemove"));
            HttpSession session = request.getSession(false);
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            Usuario inimigo = daoUsuario.get(id);
            List<Usuario> listamigos = usuario.getAmigos();
            if (inimigo != null) {
                listamigos.remove(inimigo);
                usuario.setAmigos(listamigos);
                session.removeAttribute("confirmacaoAmigos.jsp");
            }

            daoUsuario.update(usuario);
            boolean agoraeh = false;
            session.setAttribute("perfil", inimigo);
            session.setAttribute("agoraeh", agoraeh);
            response.sendRedirect("confirmacaoAmigos.jsp");
        }



    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
