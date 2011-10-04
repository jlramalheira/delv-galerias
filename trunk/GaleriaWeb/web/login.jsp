<%-- 
    Document   : login
    Created on : 26/08/2011, 09:24:53
    Author     : aluno
--%>
<%@page import="entidades.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link href="css/styles.css" rel="stylesheet" type="text/css" />
        <%@include file="default/favicon.jsp" %>
        <title>Login</title>
    </head>    
    <body>
        <%@include file="default/header.jsp" %>
        <div class="bgcontainer">
            <div class="container">
                <div class="artes"> 
                </div>
                <div class="login">
                    <%
                        Usuario u = (Usuario) (session.getAttribute("usuario"));
                        if (u != null) {
                            response.sendRedirect("home.jsp");
                        }
                        String login = "";
                        if (session.getAttribute("login") != null) {
                            login = session.getAttribute("login") + "";
                        }
                        if (session.getAttribute("mensagem") != null) {
                            out.println("<h2>" + session.getAttribute("mensagem") + "</h2>");
                        }
                    %>
                    <form name="formLogin" action="Login" method="post" >
                        <p><label for="user">Usuário:</label><br/>
                            <input type="text" name="login" value="<%=login%>" id="user"/></p>
                        <p><label for="password">Senha:</label><br/>
                            <input type="password" name="password" value="" id="password"/></p>
                        <p><input type="submit" value="" name="btLogin" /></p>
                    </form>
                </div>
            </div>
        </div>
        <%@include file="default/footer.jsp" %>
    </body>
</html>
