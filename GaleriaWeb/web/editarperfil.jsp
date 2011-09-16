<%-- 
    Document   : editarperfil
    Created on : 09/09/2011, 11:09:52
    Author     : a968501
--%>

<%@page import="entidades.Perfil"%>
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
        Usuario u = (Usuario) session.getAttribute("usuario");
        
            if (u == null) {
                response.sendRedirect("login.jsp");
            } else {
                String nome = "";
                String dataNascimento = "";
                char sexo = '\0';
                String descricao = "";
                String cidade = "";
                
                Perfil p = (Perfil) session.getAttribute("perfil");
                
                if(p.getNome() != null){
                    nome = p.getNome();
                }
                if(p.getCidade() !=  null){
                    cidade = p.getCidade();
                }
                if(p.getDescricao() != null){
                    descricao = p.getDescricao();
                }
                if(p.getSexo() != '\0' ){
                    sexo = p.getSexo();
                }
                
                
                
                
                 

        %>
        <h1> Editar </h1>
        <a href="home.jsp">Voltar</a>
        <%
            }
        %>
    </body>
</html>
