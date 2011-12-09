<%-- 
    Document   : paginaRecados
    Created on : 08/12/2011, 16:06:46
    Author     : João
--%>

<%@page import="dao.DaoComentario"%>
<%@page import="entidades.Comentario"%>
<%@page import="java.util.List"%>
<%@page import="entidades.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <%@include file="head.jsp" %>
        <title>Página de Recados</title>
        <script type="text/javascript">          
            $(document).ready(function(){
                $('#recado').val('Escreva aqui seu comentário').toggleVal();
            });       
        </script>
    </head>
    <body>
        <%
            Usuario u = (Usuario) (session.getAttribute("usuario"));
            if (u == null) {
                response.sendRedirect("login.jsp");
            } else {
                DaoComentario daoComentario = new DaoComentario(Comentario.class);
                int idDest = u.getId();
                if (request.getParameter("idUsuario") != null) {
                    idDest = Integer.parseInt(request.getParameter("idUsuario"));
                }
        %>
        <%-- HEADER --%>
        <%@include file="header.jsp" %>
        <%-- BODY --%>
        <div class="bgcontainer">
            <div class="container">
                <form name="formRecado" action="ServletComentario" method="POST" class="formulario" style="height: 80px; margin: 0 auto;">
                    <p><textarea name="comentario" id="recado" style="width: 325px;"></textarea>
                        <input type="hidden" name="idDest" value="<%=idDest%>" /></p>
                    <p><button name ="btComentario" value="perfil" style="margin-top: 30px">Enviar</button></p>
                </form>

                <ul class="comentarios">
                    <%
                        List<Comentario> comentarios = daoComentario.listComentariosPerfil(idDest);
                        if (comentarios.isEmpty()) {
                            out.println("<h3 style=\"margin-top: 30px\">Nao há comentarios</h3>");
                        } else {
                            for (Comentario c : comentarios) { //mostra os comentarios existentes
                                if (c.getRemetente().getId() == u.getId() || c.getDestinatinatario().getId() == u.getId()) {
                                    //excluir comentario
                                    // out.println("<a href=\"ServletComentario?idUser="+idDest+"&local=perfil&idComentario="+c.getId()+"\">Excluir</a>");
                                }
                    %>
                    <li>
                        <%-- Informação do remetente da mensagem --%>
                        <div class="inforemetente">
                            <a href="ServletPerfil?id=<%=c.getRemetente().getId()%>">
                                <img src="<%=c.getRemetente().getImagem()%>" alt="Foto de <%= c.getRemetente().getNome()%>" /><br/>
                                <%=c.getRemetente().getNome()%>
                            </a><br/>
                            <%-- <span class="excluir"><%=excluir%></span>--%>
                        </div> 
                        <%=c.getComentario()%> 
                    </li>
                    <%                }
                            }
                        }
                    %>
                </ul>
            </div>
        </div>
    </body>
</html>
