/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import dao.DaoAtualizacao;
import dao.DaoComentario;
import dao.DaoImagem;
import dao.DaoUsuario;
import entidades.Atualizacao;
import entidades.Comentario;
import entidades.Imagem;
import entidades.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author João
 */
public class ServletComentario extends HttpServlet {
    DaoUsuario daoUsuario = new DaoUsuario(Usuario.class);
    DaoComentario daoComentario = new DaoComentario(Comentario.class);
    DaoAtualizacao daoAtualizacao = new DaoAtualizacao(Atualizacao.class);
    DaoImagem daoImagem = new DaoImagem(Imagem.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("local");
        int idComentario = Integer.parseInt(request.getParameter("idComentario"));
        daoComentario.remove(idComentario);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario u = (Usuario) session.getAttribute("usuario");
        String texto = request.getParameter("comentario");
        String op = request.getParameter("btComentario");
        if (op.equalsIgnoreCase("perfil")){
            //comentario de perfil
            int idDest = Integer.parseInt(request.getParameter("idDest"));
            Comentario c = new Comentario();
            c.setRemetente(u);
            c.setDestinatinatario((Usuario)daoUsuario.get(idDest));
            c.setComentario(texto);
            c.setDia(Calendar.getInstance().getTime());
            
            daoComentario.insert(c);
            
            Atualizacao att = new Atualizacao();
            att.setComentario(c);
            att.setDestinatario((Usuario)daoUsuario.get(idDest));
            att.setRemetente(u);
            att.setTipo("deicou um recado pra voce");
            
            daoAtualizacao.insert(att);
            
            response.sendRedirect("paginaRecados.jsp?idUsuario"+idDest);
        } else {
            int idDest = Integer.parseInt(request.getParameter("idDest"));
            int idImage = Integer.parseInt(request.getParameter("idImage"));
            Comentario c = new Comentario();
            c.setRemetente(u);
            c.setDestinatinatario((Usuario)daoUsuario.get(idDest));
            c.setComentario(texto);
            c.setImagem((Imagem)daoImagem.get(idImage));
            c.setDia(Calendar.getInstance().getTime());
            
            daoComentario.insert(c);
            
            Atualizacao att = new Atualizacao();
            att.setComentario(c);
            att.setDestinatario((Usuario)daoUsuario.get(idDest));
            att.setRemetente(u);
            att.setImagem((Imagem)daoImagem.get(idImage));
            att.setTipo("deicou um recado pra voce");
            
            daoAtualizacao.insert(att);
            
            response.sendRedirect("exibeImagem.jsp?idUsuario"+idDest+"&idImagem="+((Imagem)daoImagem.get(idImage)).getId());
        }
    }

}
