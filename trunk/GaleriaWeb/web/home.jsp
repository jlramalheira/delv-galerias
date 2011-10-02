<%-- 
    Document   : home
    Created on : 02/09/2011, 09:37:00
    Author     : aluno
--%>

<%@page import="java.util.Collections"%>
<%@page import="java.util.Random"%>
<%@page import="entidades.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link href="css/styles.css" rel="stylesheet" type="text/css" />
        <title>Inicio</title>
    </head>
    <body>
        <%
            Usuario u = (Usuario) (session.getAttribute("usuario"));
            if (u == null) {
                response.sendRedirect("login.jsp");
            } else {
                String mensagem = "[Sem Mensagem]";
                if (u.getMensagem() != null) {
                    if (!u.getMensagem().equalsIgnoreCase("")) {
                        mensagem = u.getMensagem();
                    }
                }
        %>
        <%-- JAVASCRIPT --%>
        <script type="text/javascript">          
            function aparece(){
                document.getElementById("msg").style.display = "none";
                document.getElementById("formMensagem").style.display = "block";				
            }
        </script>

        <%-- HEADER --%>
        <%@include file="default/header.jsp" %>
        <%-- BODY --%>
        <div class="bgcontainer">
            <div class="container"> 
                <%-- SIDEBAR --%>
                <div class="sidebar">
                    <%-- PESQUISAR --%>
                    <form name="formBuscaUsuario" action="ServletBuscaUsuario" method="post" >
                        <label for="nomeUsuario">Pesquisar:
                            <input type="text" name="nomeUsuario" value="" />
                            <input type="submit" value="Pesquisar" name="btPesquisar" />
                        </label>
                    </form>
                    <%-- LISTAR AMIGOS --%>
                    <%
                        if (u.getAmigos().size() > 9) { //mostra no maximo 9 amigos
                            //Usuario sorteado = u.getAmigos().get(new Random().nextInt(u.getAmigos().size())); //sorteia um amigo na lista
                            Collections.shuffle(u.getAmigos());
                            for (int i = 0; i < 9; i++) {
                                out.println("<a href=\"ServletPerfil?id=" + u.getAmigos().get(i).getId() + "\">" + u.getAmigos().get(i).getNome() + "</a><br />");

                            }
                        } else {
                            for (Usuario user : u.getAmigos()) {
                                out.println("<a href=\"ServletPerfil?id=" + user.getId() + "\">" + user.getNome() + "</a><br />");
                            }
                        }

                    %>
                    <a href="ServletExibeAmigos?pagina=1">Todos</a>

                </div>
                <%-- CONTENT --%>
                <div class="content">
                    <div class="me"> <img src="images/pic.png" alt="Foto"/>
                        <div class="welcome">
                            <p>Bem vindo,<br />
                                <span class="name"><%=(u.getNome())%></span></p>
                            <p class="mensagem" id="msg" title="Clique para alterar sua mensagem" onclick="aparece()"><%=mensagem%></p>
                            <form name="formMensagem" action="ServletEditaPerfil" method="get" id="formMensagem">
                                <input type="text" name="mensagem" value="<%=mensagem%>" />
                                <input type="submit" value="ok" name="btMensagem" />
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%}%>
        <%-- FOOTER --%>
        <%@include file="default/footer.jsp" %>
    </body>
</html>