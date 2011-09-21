/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import dao.Dao;
import entidades.Pais;
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
public class ServletEditaPerfil extends HttpServlet {

    Dao<Usuario> daoUsuario = new Dao<Usuario>(Usuario.class);
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String dataNascimento = request.getParameter("dataNascimento");
        char sexo = request.getParameter("sexo").charAt(0);
        String descricao = request.getParameter("descricao");
        String cidade = request.getParameter("cidade");
        int pais = Integer.parseInt(request.getParameter("pais"));
        HttpSession session = request.getSession(false);
        Usuario u = (Usuario) session.getAttribute("usuario");
        u.setNome(nome);
        u.setDataNascimento(util.Util.StringToDate(dataNascimento));
        u.setSexo(sexo);
        u.setDescricao(descricao);
        u.setCidade(cidade);
        if (pais != -1) {
            u.setPais(new Dao<Pais>(Pais.class).get(pais));
        }
        
        daoUsuario.update(u);
        
        response.sendRedirect("home.jsp");

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
