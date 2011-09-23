<%-- 
    Document   : home
    Created on : 02/09/2011, 09:37:00
    Author     : aluno
--%>

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
        if (session.getAttribute("usuario")==null){
            response.sendRedirect("login.jsp");
        } else {
            Usuario u = (Usuario)(session.getAttribute("usuario"));
            String mensagem = "";
            if (u.getMensagem() != null){
                mensagem = u.getMensagem();
            }
        %>
        <h1> Bem Vindo!! <%=(u.getNome())%> </h1>
        <a href="editarperfil.jsp">Editar</a>
        <a href="Login">Sair</a>
        <form name="formMensagem" action="ServletEditaPerfil" method="GET">
            <label for="mensagem">Mensagem:
                <input type="text" name="mensagem" value="<%=mensagem%>" />
                <input type="submit" value="Ok" name="btMensagem" />
            </label>
        </form>
        <form name="formBuscaUsuario" action="ServletEditaPerfil" method="GET">
            <label for="mensagem">Mensagem:
                <input type="text" name="mensagem" value="<%=mensagem%>" />
                <input type="submit" value="Ok" name="btMensagem" />
            </label>
        </form>
        
        
        <%
        }
        %>
    </body>
</html>
