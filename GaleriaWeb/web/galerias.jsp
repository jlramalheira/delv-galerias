<%-- 
    Document   : galerias
    Created on : 18/11/2011, 11:04:11
    Author     : a968501
--%>

<%@page import="java.util.List"%>
<%@page import="entidades.Galeria"%>
<%@page import="dao.Dao"%>
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
                List<Galeria> galerias = new Dao<Galeria>(Galeria.class).list();
                for (Galeria g : galerias){%>
                <p><%=g.getNome()%><br />
                <%=g.getDescricao()%> <br />
                <a href="ServletGaleria?op=excluir&id=<%=g.getId()%>">Excluir</a> 
                <a href="ServletGaleria?op=editar&id=<%=g.getId()%>">Editar</a>
                </p>
                
                <%    
                }
        %>
                <a href="gerenciagaleria.jsp">Criar...</a>
        <%
            }
        %>
    </body>
</html>
