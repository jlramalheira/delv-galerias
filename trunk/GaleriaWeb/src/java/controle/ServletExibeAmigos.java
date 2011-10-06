/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import entidades.Usuario;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author João
 */
public class ServletExibeAmigos extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int pagina = Integer.parseInt(request.getParameter("pagina"));
        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        List<Usuario> amigos = usuario.getAmigos();
        int quantidade = 0;
        if (amigos.size()%20 == 0){
            quantidade = amigos.size()/20;
        } else {
            quantidade = (amigos.size()/20)+1;
        }
        session.removeAttribute("quantidadepaginas");
        session.setAttribute("quantidadepaginas", quantidade);
        session.removeAttribute("paginaatual");
        session.setAttribute("paginaatual", pagina);
        session.removeAttribute("amigos");
        session.setAttribute("amigos", amigos);
        
        response.sendRedirect("exibeAmigos.jsp");
        
    }

 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        String nomeamigo = request.getParameter("nomeamigo");
        int quantidade = 0;
        int pagina = 1;
        List<Usuario> amigos = new ArrayList<Usuario>() {};
        for (Usuario u : usuario.getAmigos()) {
            if (u.getNome().contains(nomeamigo)){
                amigos.add(u);
            }
        }
        if (amigos.size()%20 == 0){
            quantidade = amigos.size()/20;
        } else {
            quantidade = (amigos.size()/20)+1;
        }
        session.removeAttribute("quantidadepaginas");
        session.setAttribute("quantidadepaginas", quantidade);
        session.removeAttribute("paginaatual");
        session.setAttribute("paginaatual", pagina);
        session.removeAttribute("amigos");
        session.setAttribute("amigos", amigos);
        
        response.sendRedirect("exibeAmigos.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
