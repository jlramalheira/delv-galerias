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
                int id = u.getId();
                if (request.getParameter("idUsuario") != null) {
                    id = Integer.parseInt(request.getParameter("idUsuario"));
                }
                Galeria g = new Dao<Galeria>(Galeria.class).get(Integer.parseInt(request.getParameter("id")));
                if (g != null) {
        %>
        <p>
            <%
                        if (id == u.getId()) { //vai pra home
%>
            <a href="home.jsp"><%=u.getNome()%></a>
            <%
                    } else { //vai pro perfil do dono das galerias
%> 
            <a href="ServletPerfil?id=<%=id%>"><%=new Dao<Usuario>(Usuario.class).get(id).getNome()%></a>
            <%
                }
            %>
            - 
            <a href="galerias.jsp?idUsuario=<%=id%>">Voltar as galerias</a>
        </p>
        <ul><%
            List<Imagem> imagens = new DaoImagem(Imagem.class).listImagesByGaleriaId(g.getId());
            for (Imagem i : imagens) {
            %>
            <h2><a href="exibegaleria.jsp?idGaleria=<%=g.getId()%>&idUsuario=<%=id%>"><%=g.getNome()%></a></h2>
            <li>
                <a href="exibeimage.jsp?idImagem=<%=i.getId()%>&idUsuario=<%=id%>">
                    <img src="<%
                    String caminho = i.getImagem().substring(i.getImagem().lastIndexOf("/"));
                    caminho += "mini_";
                    caminho += i.getImagem().substring(i.getImagem().lastIndexOf("/")+1);
                    out.print(caminho);
                        %>" alt="Imagem Usuario" />
                </a>
            </li>
            <%            }
            %></ul><%
                    }
                }
            %>


    </body>
</html>
