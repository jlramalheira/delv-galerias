/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import dao.Dao;
import entidades.Usuario;
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

/**
 *
 * @author a968501
 */
public class ServletImagem extends HttpServlet {

    Dao<Usuario> daoUsuario = new Dao<Usuario>(Usuario.class);
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
        //fez upload de zip
        if (imagem.substring(imagem.lastIndexOf(".")).equalsIgnoreCase(".zip")) {

            try {
                System.out.println("Example of ZIP file decompression.");

                // Specify file to decompress
                String inFileName = getServletContext().getRealPath("/files/temp/" + u.getId() + "/" + imagem);
                // Specify destination where file will be unzipped
                String destinationDirectory = getServletContext().getRealPath("/files/images/" + u.getId() + "/");

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
                }
                zipFile.close();
            } catch (IOException ioe) {
                System.out.println("ERRO");
            }
        }
        //teste
    }
}

