<%-- 
    Document   : login
    Created on : 26/08/2011, 09:24:53
    Author     : aluno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <%
        String login = "";
        if (session.getAttribute("login") != null){
            login = session.getAttribute("login")+"";
        }
        if (session.getAttribute("mensagem") != null){
            out.println("<h2>"+session.getAttribute("mensagem")+"</h2>");
        }
        %>
        <form name="formLogin" action="Login" method="POST">
            <p>Login:</p>
            <p><input type="text" name="login" value="<%=login%>" /></p>
            <p>Senha:</p>
            <p><input type="password" name="password" value="" /></p>
            <p><input type="submit" value="Entrar" name="btLogin" /></p>
        </form>        
    </body>
</html>
