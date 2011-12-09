<%-- 
    Document   : galerias
    Created on : 18/11/2011, 11:04:11
    Author     : a968501
--%>

<%@page import="dao.DaoUsuario"%>
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
                DaoUsuario daoUsuario = new DaoUsuario(Usuario.class);
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
                <%-- CONTENT --%>
                <div class="content">
                    <h2>Galerias de <%= ((Usuario)daoUsuario.get(id)).getNome() %></h2>
                    <ul class="galerias">
                        <%
                            List<Galeria> galerias = new DaoGaleria(Galeria.class).listGaleriaByUser(id);
                            if (!galerias.isEmpty()) {
                                for (Galeria g : galerias) {
                                    String caminho = "";
                                    if (!daoImagem.listOneImageByGaleriaId(g.getId()).isEmpty()) {
                                        String image = ((List<Imagem>) daoImagem.listOneImageByGaleriaId(g.getId())).get(0).getImagem();
                                        caminho = image.substring(0, image.lastIndexOf("/"));
                                        caminho += "/mini_";
                                        caminho += image.substring(image.lastIndexOf("/") + 1);
                                    } else {
                                        caminho = "images/bkg/new_gallery.png";
                                    }%>
                        <li>
                            <a href="exibegaleria.jsp?idGaleria=<%=g.getId()%>&idUsuario=<%=id%>"><img src="<%= caminho%>" alt="Galeria" /></a><br />
                            <span class="galerianome"><%=g.getNome()%><br /></span>
                            Descrição: <%=g.getDescricao()%> <br />
                            <%if(id == u.getId()){ %>
                            <%--<span class="galeriaopc"><a href="ServletGaleria?op=excluir&id=<%=g.getId()%>">Excluir</a> | --%>
                                <a href="ServletGaleria?op=editar&id=<%=g.getId()%>">Editar</a></span>
                                <%}%>
                        </li>
                        <%
                                }
                            } else {
                                out.print("<p>Nenhuma galeria cadastrada</p>");
                            }

                            //mostra o criar se tiver na sua propria galeria
                            if (u.getId() == id) {
                        %>
                        <li class="newgallery">
                            <span><a href="gerenciagaleria.jsp">Nova galeria</a></span><br/>
                            Crie uma nova galeria para organizar suas imagens.                            
                        </li>
                        <%                            }
                        %>

                    </ul>
                </div>
            </div>           
        </div>
        <%-- FOOTER --%>
        <%@include file="footer.jsp" %>
        <%}%>
    </body>
</html>
