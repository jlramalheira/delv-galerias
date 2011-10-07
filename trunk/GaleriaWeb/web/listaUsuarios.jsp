<%-- 
    Document   : listaUsuarios
    Created on : 23/09/2011, 09:44:30
    Author     : a968501
--%>

<%@page import="entidades.Usuario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="head.jsp" %>
        <title>Resultados da Pesquisa</title>
    </head>
    <body>
        <%
            if (session.getAttribute("usuario") == null) {
                response.sendRedirect("login.jsp");
            } else {
        %>
        <%-- HEADER --%>
        <%@include file="header.jsp" %>
        <%-- BODY --%>
        <div class="bgcontainer">
            <div class="container">
                <h2>Resultados da Busca</h2>
                <p class="voltar"><a href="home.jsp">Voltar</a></p>
                <div class="resultadosbusca">
                    <ul>
                        <%
                            List<Usuario> usuarios = (List<Usuario>) session.getAttribute("usuarios");
                            if (usuarios != null) {
                                int pagina = (Integer) session.getAttribute("paginaatual");
                                int quantidade = (Integer) session.getAttribute("quantidadepaginas");
                                if ((pagina) * 20 > usuarios.size()) {
                                    for (int i = (pagina * 20 - 20); i < usuarios.size(); i++) {
                                        Usuario u = usuarios.get(i);%>
                        <li>
                            <a href="ServletPerfil?id=<%= u.getId()%>"><img src="<%= u.getImagem()%>" alt="Foto de <%= u.getNome()%>"/></a>
                            <div class="info">
                                <p class="nome"><a href="ServletPerfil?id=<%= u.getId()%>"><%= u.getNome()%></a></p>
                                <p class="msg"><%= (u.getMensagem() != null) ? u.getMensagem() : ""%></p>
                                <p><br/>
                                    <strong>Local:</strong> <%= (u.getCidade() != null) ? u.getCidade() : ""%> - <%= (u.getPais() != null) ? u.getPais().getNome() : ""%></p>
                            </div>
                        </li>                                
                        <% }
                        } else {
                            for (int i = (pagina * 20 - 20); i < pagina * 20; i++) {
                                Usuario user = usuarios.get(i);
                        %>
                        <li>
                            <a href="ServletPerfil?id=<%= user.getId()%>"><img src="<%= user.getImagem()%>" alt="Foto de <%= user.getNome()%>"/></a>
                            <div class="info">
                                <p class="nome"><a href="ServletPerfil?id=<%= user.getId()%>"><%= user.getNome()%></a></p>
                                <p class="msg"><%= (user.getMensagem() != null) ? user.getMensagem() : ""%></p>
                                <p><br/>
                                    <strong>Local:</strong> <%= (user.getCidade() != null) ? user.getCidade() : ""%> - <%= (user.getPais() != null) ? user.getPais().getNome() : ""%></p>
                            </div>
                        </li>
                        <%
                                }
                            }%>

                    </ul>
                    <p> Paginas: 
                        <%
                                for (int i = 1; i <= quantidade; i++) {
                                    if (i == pagina) {
                                        out.println(i);
                                    } else {
                                        out.println("<a href=\"ServletBuscaUsuario?pagina=" + i + "\">" + i + "</a>");
                                    }
                                }
                            }
                        %>
                    </p>
                </div>
            </div>           
        </div>
        <%-- FOOTER --%>
        <%@include file="footer.jsp" %>
        <%
            }
        %>

    </body>
</html>
