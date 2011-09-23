/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import dao.Dao;
import entidades.Pais;
import entidades.Usuario;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import upload.Upload;

/**
 *
 * @author João
 */
public class ServletEditaPerfil extends HttpServlet {

    Dao<Usuario> daoUsuario = new Dao<Usuario>(Usuario.class);
    public String dir = "/files/";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario u = (Usuario) session.getAttribute("usuario");

        String mensagem = request.getParameter("mensagem");
        u.setMensagem(mensagem);
        daoUsuario.update(u);
        response.sendRedirect("home.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario u = (Usuario) session.getAttribute("usuario");
        dir += ("temp/"+u.getId());
        Upload upload = new Upload(getServletContext().getRealPath(dir));

        List list = upload.processRequest(request);

        Map<String, String> map = upload.getFormValues(list);


        String nome = map.get("nome");
        String dataNascimento = map.get("dataNascimento");
        char sexo = map.get("sexo").charAt(0);
        String descricao = map.get("descricao");
        String cidade = map.get("cidade");
        int pais = Integer.parseInt(map.get("pais"));
        String imagem = map.get("imagem");


        u.setNome(nome);
        u.setDataNascimento(util.Util.StringToDate(dataNascimento));
        u.setSexo(sexo);
        u.setDescricao(descricao);
        u.setCidade(cidade);
        u.setImagem(imagem);

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
