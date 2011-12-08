/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import dao.DaoAtualizacao;
import entidades.Atualizacao;
import entidades.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author João
 */
public class ServletFavorito extends HttpServlet {
    DaoAtualizacao daoAtualizacao = new DaoAtualizacao(Atualizacao.class);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (request.getParameter("btAdd") != null) {
            int id = Integer.parseInt(request.getParameter("btAdd"));
            
            response.sendRedirect("confirmacaoAmigos.jsp");
        } else {
            int id = Integer.parseInt(request.getParameter("btRemove"));

            response.sendRedirect("confirmacaoAmigos.jsp");
        }
    }

}
