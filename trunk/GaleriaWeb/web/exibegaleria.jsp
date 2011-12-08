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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <%@include file="head.jsp" %>
        <title>Galeria</title>
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
                Galeria g = new Dao<Galeria>(Galeria.class).get(Integer.parseInt(request.getParameter("idGaleria")));
                if (g != null) {
                    //Vai para Home se não estiver numa galeria de outro usuário
                    String nome = u.getNome();
                    String aux = "home.jsp";
                    if (id != u.getId()) {
                        aux = "ServletPerfil?id=" + id;
                        nome = new Dao<Usuario>(Usuario.class).get(id).getNome();
                    }
        %>
        <%-- HEADER --%>
        <%@include file="header.jsp" %>
        <%-- BODY --%>
        <div class="bgcontainer">
            <div class="container">               
                <h2><%=g.getNome()%></h2>
                <p>Descrição:<br/>
                    <%= g.getDescricao()%>
                </p>
                <p><a href="galerias.jsp?idUsuario=<%=id%>">Voltar as galerias</a></p>

                <ul>
                    <%
                        List<Imagem> imagens = new DaoImagem(Imagem.class).listImagesByGaleriaId(g.getId());
                        if (!imagens.isEmpty()) {
                            for (Imagem i : imagens) {
                    %>
                    <li>
                        <a href="exibeImagem.jsp?idImagem=<%=i.getId()%>&idUsuario=<%=id%>">
                            <img src="<%
                                String caminho = i.getImagem().substring(0, i.getImagem().lastIndexOf("/"));
                                caminho += "/mini_";
                                caminho += i.getImagem().substring(i.getImagem().lastIndexOf("/") + 1);
                                out.print(caminho);
                                 %>" alt="Imagem Usuario" />
                        </a>
                    </li>
                    <%            }
                        } else {
                            out.println("<h2>Esta galeria nao possui nenhuma imagem</h2>");
                        }
                    %>
                </ul>

                <%if (id == u.getId()) { //so adiciona se for o usuario dono
                %>
                <p><a href="gerenciaimagem.jsp">Adicionar Imagem</a></p>
                <%      }
                %>
            </div>            
        </div>
        <%        } else {
                response.sendRedirect("home.jsp");
            }            
        %>
    </body>
</html>
