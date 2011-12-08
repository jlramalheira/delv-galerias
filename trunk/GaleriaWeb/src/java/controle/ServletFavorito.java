/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import dao.DaoAtualizacao;
import dao.DaoImagem;
import dao.DaoUsuario;
import entidades.Atualizacao;
import entidades.Imagem;
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
 * @author João
 */
public class ServletFavorito extends HttpServlet {
    DaoAtualizacao daoAtualizacao = new DaoAtualizacao(Atualizacao.class);
    DaoImagem daoImagem = new DaoImagem(Imagem.class);
    DaoUsuario daoUsuario = new DaoUsuario(Usuario.class);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        List<Imagem> favoritas = usuario.getFavoritos();
        if (request.getParameter("btAdd") != null) {
            int id = Integer.parseInt(request.getParameter("btAdd"));
            favoritas.add((Imagem)daoImagem.get(id));
            
            Atualizacao att = new Atualizacao();
            att.setDestinatario((Usuario)daoUsuario.get(idUsuario));
            att.setRemetente(usuario);
            att.setImagem((Imagem)daoImagem.get(id));
            att.setTipo(" favoritou sua imagem ");
            daoAtualizacao.insert(att);
            
            
            response.sendRedirect("exibeImagem.jsp?idImagem="+id+"&idUsuario="+idUsuario);
        } else {
            int id = Integer.parseInt(request.getParameter("btRemove"));
            favoritas.remove((Imagem)daoImagem.get(id));
            response.sendRedirect("exibeImagem.jsp?idImagem="+id+"&idUsuario="+idUsuario);
        }
    }

}
