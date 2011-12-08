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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
        <form name="formRecado" action="ServletComentario" method="POST">
            <p><label for="recado">Recado:</label><br />
            <textarea name="comentario" id="recado">Recado...</textarea><br />
            <input type="hidden" name="idDest" value="<%=idDest%>" />
            <button name ="btComentario" value="perfil">Enviar</button>
            </p>
        </form>                
        <%
            List<Comentario> comentarios = daoComentario.listComentariosPerfil(idDest);
            if (comentarios.isEmpty()) {
                out.println("<h2>nao existem comentarios</h2>");
            } else {
                for (Comentario c : comentarios) { //mostra os comentarios existentes
%>
        <p>
            <a href="ServletPerfil?id=<%=c.getRemetente().getId()%>"><%=c.getRemetente().getNome()%></a>:<br />
            <%=c.getComentario()%>       <br />      
            <%
            if (c.getRemetente().getId() == u.getId() || c.getDestinatinatario().getId() == u.getId()){
                //excluir comentario
                out.println("<a href=\"ServletComentario?idComentario="+c.getId()+"\">Excluir</a>");
            }
            %>
        </p>
        <%                }
                }
            }
        %>
    </body>
</html>
