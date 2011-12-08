
package controle;

import dao.DaoImagem;
import entidades.Imagem;
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
public class ServletEditaImagem extends HttpServlet {
    DaoImagem daoImagem = new DaoImagem(Imagem.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario u = (Usuario) session.getAttribute("usuario");
        
        int idImagem = Integer.parseInt(request.getParameter("idImagem"));
        String nome = request.getParameter("nome");
        String decricao = request.getParameter("descricao");
        
        Imagem i = (Imagem)daoImagem.get(idImagem);
        if (i != null){
            i.setNome(nome);
            i.setDescricao(decricao);
            daoImagem.update(i);
        }
        
        response.sendRedirect("exibeImagem.jsp?idImagem="+i.getId()+"&idUsuario="+u.getId());
    }

}
