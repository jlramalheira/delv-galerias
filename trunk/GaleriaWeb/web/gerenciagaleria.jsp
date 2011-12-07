<%-- 
    Document   : gerenciagaleria
    Created on : 18/11/2011, 10:31:21
    Author     : a968501
--%>

<%@page import="entidades.Galeria"%>
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
                Galeria g = (Galeria) session.getAttribute("galeria");
                int id = 0;
                if (g != null) {
                    String nome = "";
                    String descricao = "";
                    id = g.getId();
                    if (g.getNome() != null) {
                        nome = g.getNome();
                    }
                    if (g.getDescricao() != null) {
                        descricao = g.getDescricao();
                    }

        %>
        <form name="formGaleria" action="ServletGaleria" method="post" >
            <p><label for="nome">Nome:</label><br/>
                <input type="text" name="nome" value="<%=nome%>" id="nome"/></p>
            <p><label for="descricao">Descrição:</label><br/>
                <textarea id="descricao" name="descricao"><%=descricao%></textarea></p>
            <input type="hidden" name="idGaleria" value="<%=g.getId()%>" />
            <p><p><input type="submit" value="" name="btGaleria" /></p></p>
        </form>
        <%
                }
                session.removeAttribute("galeria");
            }
        %>

    </body>
</html>
