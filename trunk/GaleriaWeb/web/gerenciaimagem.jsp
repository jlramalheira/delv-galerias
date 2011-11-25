<%-- 
    Document   : gerenciaimagem
    Created on : 25/11/2011, 11:16:17
    Author     : a968501
--%>

<%@page import="entidades.Imagem"%>
<%@page import="entidades.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Usuario u = (Usuario) (session.getAttribute("usuario"));
            if (u == null) {
                response.sendRedirect("login.jsp");
            } else {
                Imagem i = (Imagem) session.getAttribute("imagem");
                int id = 0;
                if (i != null){
                    id = i.getId();
                    String nome = "";
                    String descricao = "";
                    if (descricao != null){
                        descricao = i.getDescricao();
                    }
                    if (nome != null){
                        nome = i.getNome();
                    }
                }
        %>
        
        <form name="formEditaPerfil" action="ServletImagem" method="post" enctype="multipart/form-data" class="formulario">
            <p><label for="imagem">Imagem:</label>
                        <input name="imagem" type="file" maxlength="60" id="imagem"/>
                        <input type="submit" name="upload" value="insert" hidden="true"/></p>
            <p><label for="nome">Nome:</label><input type="text" name="nome" value="" id="nome"/></p>
            <p><label for="descricao">Descricao:</label><textarea name="descricao" id="descricao"></textarea></p>
            <p><p><input type="submit" value="" name="btImagem" /></p></p>
        </form>
        
        <%
            }
        %>
    </body>
</html>