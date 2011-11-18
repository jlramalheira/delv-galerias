<%-- 
    Document   : newgaleria
    Created on : 18/11/2011, 10:31:21
    Author     : a968501
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
            Usuario u = (Usuario) (session.getAttribute("usuario"));
            if (u == null) {
                response.sendRedirect("login.jsp");
            } else {
        %>
        <form name="formGaleria" action="ServletGaleria" method="post" >
            <p><label for="nome">Nome:</label><br/>
                <input type="text" name="nome" value="" id="nome"/></p>
            <p><label for="descricao">Descrição:</label><br/>
                <textarea id="descricao" name="descricao"> </textarea></p>
            <p><button name="btGaleria" value="new">Cadastrar</button></p>
        </form>
        <%
            }
        %>
        
    </body>
</html>
