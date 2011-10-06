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
        <%@include file="head.jsp" %>
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
            $(document).ready(function(){
                $("#formMensagem").hide();
                $("#msg").click(function(){
                    $("#msg").hide();
                    $("#formMensagem").fadeIn();                    
                });
                $('#search').val('Pesquisar').toggleVal();
            });       
        </script>

        <%-- HEADER --%>
        <%@include file="header.jsp" %>
        <%-- BODY --%>
        <div class="bgcontainer">
            <div class="container"> 
                <%-- SIDEBAR --%>
                <div class="sidebar">                   
                    <%-- LISTAR AMIGOS --%>
                    <div class="amigoslist">
                        <h2>Amigos</h2>
                        <ul>                        
                            <%
                                Collections.shuffle(u.getAmigos());
                                if (u.getAmigos().size() > 8) { //mostra no maximo 9 amigos
                                    //Usuario sorteado = u.getAmigos().get(new Random().nextInt(u.getAmigos().size())); //sorteia um amigo na lista

                                    for (int i = 0; i < 8; i++) {
                                        Usuario user = u.getAmigos().get(i);
                            %>                                         
                            <li>
                                <a href="ServletPerfil?id=<%= user.getId()%>"><img src="files/images/<%= user.getId()%>/<%= user.getImagem()%>" alt="Foto" /></a>                        
                            </li>       
                            <%
                                }
                            } else {
                                for (Usuario user : u.getAmigos()) {%>
                            <li>
                                <a href="ServletPerfil?id=<%= user.getId()%>"><img src="files/images/<%= user.getId()%>/<%= user.getImagem()%>" alt="Foto" /></a>                   
                            </li> 
                            <%        }
                                }

                            %>
                        </ul>
                        <p class="vermais"><a href="ServletExibeAmigos?pagina=1">Ver todos os amigos</a></p>
                    </div>
                    

                </div>
                <%-- CONTENT --%>
                <div class="content">
                    <div class="me"> <img src="<%=u.getImagem()%>" alt="Foto"/>
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
        <%@include file="footer.jsp" %>
    </body>
</html>
