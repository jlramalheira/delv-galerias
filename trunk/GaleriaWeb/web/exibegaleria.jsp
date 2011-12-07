<%-- 
    Document   : exibegaleria.jsp
    Created on : 02/12/2011, 09:45:08
    Author     : a968501
--%>

<%@page import="entidades.Galeria"%>
<%@page import="dao.DaoImagem"%>
<%@page import="dao.Dao"%>
<%@page import="entidades.Imagem"%>
<%@page import="java.util.List"%>
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
                Galeria g = new Dao<Galeria>(Galeria.class).get(Integer.parseInt(request.getParameter("id")));
                if (g != null) {
        %><ul><%
                        List<Imagem> imagens = new DaoImagem(Imagem.class).listImagesByGaleriaId(g.getId());
                        for (Imagem i : imagens) {
            %>
            <h2><a href="exibegaleria.jsp?id=<%=g.getId()%>"><%=g.getNome()%></a></h2>
            <li>
                <a href="exibeimage.jsp?id=<%=i.getId()%>">
                    <img src="<%=i.getImagem()%>" alt="Imagem Usuario" />
                </a>
            </li>

            <%            }
            %></ul><%
                    }
                }
            %>
            

    </body>
</html>
