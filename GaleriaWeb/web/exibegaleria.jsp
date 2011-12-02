<%-- 
    Document   : exibegaleria.jsp
    Created on : 02/12/2011, 09:45:08
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

        <%            }
        %>


    </body>
</html>
