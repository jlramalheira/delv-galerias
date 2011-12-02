<%-- 
    Document   : galerias
    Created on : 18/11/2011, 11:04:11
    Author     : a968501
--%>

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
        %>
        <%-- HEADER --%>
        <%@include file="header.jsp" %>

        <%-- BODY --%>
        <div class="bgcontainer">
            <div class="container">
                <div style="width: 100%; height: 40px; background-color: #D5DED9;"></div>
                <ul>
                    <%List<Galeria> galerias = new Dao<Galeria>(Galeria.class).list();
                    for (Galeria g : galerias) {%>
                    <p>
                        <a href="exibegaleria.jsp?id=1"><img href="<%
                        if (daoImagem.listOneImageByGaleriaId(g.getId()).isEmpty()){
                            out.print(((List<Imagem>)daoImagem.listOneImageByGaleriaId(g.getId())).get(0));
                        } else {
                            out.print("colocar caminho imagem");
                        }
                        %>" 
                        alt=""></img></a>
                        <%=g.getNome()%><br />
                        <%=g.getDescricao()%> <br />
                        <a href="ServletGaleria?op=excluir&id=<%=g.getId()%>">Excluir</a> 
                        <a href="ServletGaleria?op=editar&id=<%=g.getId()%>">Editar</a>
                    </p>
                    <%
                        }
                    %>
                </ul>
                <a href="gerenciagaleria.jsp">Criar...</a>
            </div>           
        </div>

        <%-- FOOTER --%>
        <%@include file="footer.jsp" %>
        <%}%>
    </body>
</html>
