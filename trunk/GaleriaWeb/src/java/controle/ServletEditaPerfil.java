/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import dao.Dao;
import entidades.Pais;
import entidades.Usuario;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.imageio.ImageIO;
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
    public String dir1 = "/files/temp";
    public String dir2 = "/files/images";

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

        //criando pastas
        //criando pastas necessarias se elas nao existirem
        String caminhosauxiliares = getServletContext().getRealPath(dir);
        File criapastafiles = new File(caminhosauxiliares);
        if (!criapastafiles.exists()) {
            criapastafiles.mkdir();

        }
        caminhosauxiliares = getServletContext().getRealPath(dir1);
        File criapastatemp = new File(caminhosauxiliares);
        if (!criapastatemp.exists()) {
            criapastatemp.mkdir();

        }
        caminhosauxiliares = getServletContext().getRealPath(dir2);
        File criapastaimages = new File(caminhosauxiliares);
        if (!criapastaimages.exists()) {
            criapastaimages.mkdir();

        }


        Upload upload = new Upload(getServletContext().getRealPath(dir + "temp/" + u.getId()));

        List list = upload.processRequest(request);

        Map<String, String> map = upload.getFormValues(list);

        String nome = map.get("nome");
        String dataNascimento = map.get("dataNascimento");
        char sexo = map.get("sexo").charAt(0);
        String descricao = map.get("descricao");
        String cidade = map.get("cidade");
        int pais = Integer.parseInt(map.get("pais"));
        String imagem = "";
        if (map.get("imagem") == null) {
            imagem = "images/pic.png";
        } else {
            imagem = "files/images/"+u.getId()+"/avatar.jpg";
        }


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

        //redimencionando
        String path1 = getServletContext().getRealPath("/files/temp/" + u.getId() + "/" + imagem);
        String path2 = getServletContext().getRealPath("/files/images/" + u.getId() + "/");

        try {
            BufferedImage imageb = ImageIO.read(new File(path1));
            Image image = imageb.getScaledInstance(150, 150, Image.SCALE_SMOOTH);
            BufferedImage imagemredimencionada = new BufferedImage(
                    150, 150, BufferedImage.TYPE_INT_BGR);
            imagemredimencionada.createGraphics().drawImage(image, 0, 0, null);
            File file = new File(path2);
            if (!file.exists()) {
                file.mkdir();
            }
            ImageIO.write(imagemredimencionada, "JPG", new File(path2 + "/avatar.jpg"));
        } catch (IOException ex) {
            System.out.println("erro");
        }

        response.sendRedirect("home.jsp");

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
