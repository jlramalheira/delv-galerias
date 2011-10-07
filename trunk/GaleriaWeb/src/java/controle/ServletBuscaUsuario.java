/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import dao.Dao;
import dao.DaoUsuario;
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
public class ServletBuscaUsuario extends HttpServlet {
    DaoUsuario daoUsuario = new DaoUsuario(Usuario.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int pagina = Integer.parseInt(request.getParameter("pagina"));
        HttpSession session = request.getSession(false);
        
        session.removeAttribute("paginaatual");
        session.setAttribute("paginaatual", pagina);
        
        response.sendRedirect("listaUsuarios.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nome = request.getParameter("nomeUsuario");
        List<Usuario> usuarios = daoUsuario.listByNome(nome);
        HttpSession session = request.getSession(false);
        int quantidade = 0;
        int pagina = 1;
        if (usuarios.size()%20 == 0){
            quantidade = usuarios.size()/20;
        } else {
            quantidade = (usuarios.size()/20)+1;
        }
        session.removeAttribute("quantidadepaginas");
        session.setAttribute("quantidadepaginas", quantidade);
        session.removeAttribute("paginaatual");
        session.setAttribute("paginaatual", pagina);
        
        session.setAttribute("usuarios", usuarios);
        
        response.sendRedirect("listaUsuarios.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
