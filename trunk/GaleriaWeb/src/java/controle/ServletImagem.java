/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import dao.Dao;
import entidades.Galeria;
import entidades.Imagem;
import entidades.Usuario;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import upload.Upload;
import java.io.*;
import java.util.*;
import java.util.zip.*;
import java.text.*;
import javax.imageio.ImageIO;

/**
 *
 * @author a968501
 */
public class ServletImagem extends HttpServlet {

    Dao<Usuario> daoUsuario = new Dao<Usuario>(Usuario.class);
    Dao<Galeria> daoGaleria = new Dao<Galeria>(Galeria.class);
    Dao<Imagem> daoImagem = new Dao<Imagem>(Imagem.class);
    public String dir = "/files/";
    public String dir1 = "/files/temp";
    public String dir2 = "/files/images";
    static final int BUFFER = 2048;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

        String imagem = map.get("imagem");
        int idGaleria = Integer.parseInt(map.get("idGaleria"));
        //fez upload de zip
        if (imagem.substring(imagem.lastIndexOf(".")).equalsIgnoreCase(".zip")) {

            try {

                // Specify file to decompress
                String inFileName = getServletContext().getRealPath("/files/temp/" + u.getId() + "/" + imagem);
                // Specify destination where file will be unzipped
                String destinationDirectory = getServletContext().getRealPath("/files/temp/" + u.getId() + "/");
                String nome = "";
                String path2 = getServletContext().getRealPath("/files/images/" + u.getId() + "/");

                File sourceZipFile = new File(inFileName);
                File unzipDestinationDirectory = new File(destinationDirectory);

                // Open Zip file for reading
                ZipFile zipFile = new ZipFile(sourceZipFile, ZipFile.OPEN_READ);

                // Create an enumeration of the entries in the zip file
                Enumeration zipFileEntries = zipFile.entries();

                // Process each entry
                while (zipFileEntries.hasMoreElements()) {
                    // grab a zip file entry
                    ZipEntry entry = (ZipEntry) zipFileEntries.nextElement();

                    String currentEntry = entry.getName();

                    File destFile =
                            new File(unzipDestinationDirectory, currentEntry);
                    nome = destFile.getName();

                    // grab file's parent directory structure
                    File destinationParent = destFile.getParentFile();

                    // create the parent directory structure if needed
                    destinationParent.mkdirs();

                    // extract file if not a directory
                    if (!entry.isDirectory()) {
                        BufferedInputStream is =
                                new BufferedInputStream(zipFile.getInputStream(entry));


                        int currentByte;
                        // establish buffer for writing file
                        byte data[] = new byte[BUFFER];

                        // write the current file to disk
                        FileOutputStream fos = new FileOutputStream(destFile);
                        BufferedOutputStream dest =
                                new BufferedOutputStream(fos, BUFFER);

                        // read and write until last byte is encountered
                        while ((currentByte = is.read(data, 0, BUFFER)) != -1) {
                            dest.write(data, 0, currentByte);
                        }
                        dest.flush();
                        dest.close();
                        is.close();


                    }
                    //gerar miniatura
                    BufferedImage imageb = ImageIO.read(new File(destinationDirectory + "/" + nome));
                    Image image = imageb.getScaledInstance(150, 150, Image.SCALE_SMOOTH);
                    BufferedImage imagemredimencionada = new BufferedImage(
                            150, 150, BufferedImage.TYPE_INT_BGR);
                    imagemredimencionada.createGraphics().drawImage(image, 0, 0, null);
                    File file = new File(path2);
                    if (!file.exists()) {
                        file.mkdir();
                    }

                    Imagem i = new Imagem();
                    daoImagem.insert(i);
                    i.setNome("image" + i.getId());
                    i.setDescricao("Fotos " + imagem.substring(0, imagem.lastIndexOf(".")));
                    i.setDia(Calendar.getInstance().getTime());
                    i.setFiltro(false);
                    i.setGaleria(daoGaleria.get(idGaleria));
                    i.setImagem("files/images/" + u.getId() + "/" + i.getNome() + ".jpg");
                    daoImagem.update(i);
                    ImageIO.write(imagemredimencionada, "JPG", new File(path2 + "/" + "mini_" + i.getNome() + ".jpg"));

                    //escreve a normal
                    BufferedImage imagebg = ImageIO.read(new File(destinationDirectory + "/" + nome));
                    Image imageg = imagebg.getScaledInstance(600, 600, Image.SCALE_SMOOTH);
                    BufferedImage imagemredimencionadag = new BufferedImage(
                            600, 600, BufferedImage.TYPE_INT_BGR);
                    imagemredimencionadag.createGraphics().drawImage(imageg, 0, 0, null);
                    ImageIO.write(imagemredimencionadag, "JPG", new File(path2 + "/" + i.getNome() + ".jpg"));


                }
                zipFile.close();
            } catch (IOException ioe) {
                System.out.println("ERRO");
            }
        } else {

            String path1 = getServletContext().getRealPath("/files/temp/" + u.getId() + "/");
            String path2 = getServletContext().getRealPath("/files/images/" + u.getId() + "/");
            //gerar miniatura
            BufferedImage imageb = ImageIO.read(new File(path1 + "/" + imagem));
            Image image = imageb.getScaledInstance(150, 150, Image.SCALE_SMOOTH);
            BufferedImage imagemredimencionada = new BufferedImage(
                    150, 150, BufferedImage.TYPE_INT_BGR);
            imagemredimencionada.createGraphics().drawImage(image, 0, 0, null);
            File file = new File(path2);
            if (!file.exists()) {
                file.mkdir();
            }

            Imagem i = new Imagem();
            daoImagem.insert(i);
            i.setNome("image" + i.getId());
            i.setDescricao("Fotos " + imagem.substring(0, imagem.lastIndexOf(".")));
            i.setDia(Calendar.getInstance().getTime());
            i.setFiltro(false);
            i.setGaleria(daoGaleria.get(idGaleria));
            i.setImagem("files/images/" + u.getId() + "/" + i.getNome() + ".jpg");
            daoImagem.update(i);
            ImageIO.write(imagemredimencionada, "JPG", new File(path2 + "/" + "mini_" + i.getNome() + ".jpg"));

            //escreve a normal
            BufferedImage imagebg = ImageIO.read(new File(path1 + "/" + imagem));
            Image imageg = imagebg.getScaledInstance(600, 600, Image.SCALE_SMOOTH);
            BufferedImage imagemredimencionadag = new BufferedImage(
                    600, 600, BufferedImage.TYPE_INT_BGR);
            imagemredimencionadag.createGraphics().drawImage(imageg, 0, 0, null);
            ImageIO.write(imagemredimencionadag, "JPG", new File(path2 + "/" + i.getNome() + ".jpg"));
        }

    }
}
