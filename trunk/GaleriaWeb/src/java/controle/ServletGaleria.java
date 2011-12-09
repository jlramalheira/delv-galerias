package controle;

import dao.Dao;
import dao.DaoAtualizacao;
import dao.DaoComentario;
import dao.DaoImagem;
import entidades.Atualizacao;
import entidades.Comentario;
import entidades.Galeria;
import entidades.Imagem;
import entidades.Usuario;
import java.io.IOException;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ServletGaleria extends HttpServlet {

    Dao<Galeria> daoGaleria = new Dao<Galeria>(Galeria.class);
    DaoImagem daoImagem = new DaoImagem(Imagem.class);
    DaoComentario daoComentario = new DaoComentario(Comentario.class);
    DaoAtualizacao daoAtualizacao = new DaoAtualizacao(Atualizacao.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String op = request.getParameter("op");
        int id = Integer.parseInt(request.getParameter("id"));
        if (op.equals("excluir")) {
            daoComentario.removeAllComentarisFromImages(id);
            daoImagem.removeAllImagesFromGalery(id);
            daoGaleria.remove(id);
            response.sendRedirect("galerias.jsp");
        }
        if (op.equals("editar")) {
            Galeria g = daoGaleria.get(id);
            if (g != null) {
                System.out.println(g.getNome());
                session.setAttribute("galeria", g);
            }
            response.sendRedirect("gerenciagaleria.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        int id = Integer.parseInt(request.getParameter("idGaleria"));
        if (id == 0) {
            String nome = request.getParameter("nome");
            String descricao = request.getParameter("descricao");

            Galeria g = new Galeria();
            g.setNome(nome);
            g.setDescricao(descricao);
            g.setUsuario(usuario);
            g.setDia(Calendar.getInstance().getTime());

            daoGaleria.insert(g);
            response.sendRedirect("exibegaleria.jsp?idGaleria=" + g.getId());
        } else {
            String nome = request.getParameter("nome");
            String descricao = request.getParameter("descricao");

            Galeria g = daoGaleria.get(id);
            g.setNome(nome);
            g.setDescricao(descricao);
            g.setUsuario(usuario);
            g.setDia(Calendar.getInstance().getTime());

            daoGaleria.update(g);

            response.sendRedirect("exibegaleria.jsp?idGaleria=" + g.getId());
        }


    }
}
