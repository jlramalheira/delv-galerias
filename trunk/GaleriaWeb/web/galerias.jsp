<%-- 
    Document   : galerias
    Created on : 18/11/2011, 11:04:11
    Author     : a968501
--%>

<%@page import="dao.DaoGaleria"%>
<%@page import="dao.DaoImagem"%>
<%@page import="entidades.Imagem"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="entidades.Galeria"%>
<%@page import="dao.Dao"%>
<%@page import="entidades.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <%@include file="head.jsp" %>
        <title>Galerias</title>
    </head>
    <body>
        <%
            Usuario u = (Usuario) (session.getAttribute("usuario"));
            if (u == null) {
                response.sendRedirect("login.jsp");
            } else {
                DaoImagem daoImagem = new DaoImagem(Imagem.class);
                int id = u.getId();
                if (request.getParameter("idUsuario") != null) {
                    id = Integer.parseInt(request.getParameter("idUsuario"));
                }
        %>
        <%-- HEADER --%>
        <%@include file="header.jsp" %>

        <%-- BODY --%>
        <div class="bgcontainer">
            <div class="container">
                <div class="me">
                    <a href="ServletPerfil?id=<%= u.getId()%>"><img src="<%=u.getImagem()%>" alt="Foto"/></a>
                    <ul class="menu">
                        <li><a href="galerias.jsp?idUsuario=<%=u.getId()%>">Imagens</a></li>
                    </ul>
                </div>
                <h2>Galerias de <%= u.getNome()%></h2>
                <ul class="galerias">
                    <%
                        List<Galeria> galerias = new DaoGaleria(Galeria.class).listGaleriaByUser(id);
                        if (!galerias.isEmpty()) {
                            for (Galeria g : galerias) {%>
                    <li>
                        <a href="exibegaleria.jsp?idGaleria=<%=g.getId()%>&idUsuario=<%=id%>"><img href="<%
                            if (daoImagem.listOneImageByGaleriaId(g.getId()).isEmpty()) {
                                out.print("mini_" + ((List<Imagem>) daoImagem.listOneImageByGaleriaId(g.getId())).get(0).getImagem());
                            } else {
                                out.print("colocar caminho imagem");
                            }
                                                                                                   %>" alt="Galeria" /></a>
                        <%=g.getNome()%><br />
                        <%=g.getDescricao()%> <br />
                        <a href="ServletGaleria?op=excluir&id=<%=g.getId()%>">Excluir</a> 
                        <a href="ServletGaleria?op=editar&id=<%=g.getId()%>">Editar</a>
                    </li>
                    <%
                            }
                        } else {
                            out.print("<p>Nenhuma galeria cadastrada</p>");
                        }
                    %>
                    <li class="newgallery">
                        <%
                            if (u.getId() == id) { //mostra o criar se tiver na sua propria galeria
                                out.println("<a href=\"gerenciagaleria.jsp\">Criar...</a>\n"
                                        + "<br/>\n"
                                        + "Nova galeria");
                            }
                        %>
                    </li>
                </ul>

            </div>           
        </div>

        <%-- FOOTER --%>
        <%@include file="footer.jsp" %>
        <%}%>
    </body>
</html>
