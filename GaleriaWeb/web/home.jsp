<%-- 
    Document   : home
    Created on : 02/09/2011, 09:37:00
    Author     : aluno
--%>

<%@page import="java.util.Random"%>
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
                String mensagem = "";
                if (u.getMensagem() != null) {
                    mensagem = u.getMensagem();
                }
        %>
        <h1> Bem Vindo!! <%=(u.getNome())%> </h1>

        <script type="text/javascript">          
            function aparece(){
                var component = document.getElementById("formMensagem");
                component.style.display = "block";
            }
        </script>

        <p><a href="editarperfil.jsp">Editar</a> | <a href="Login">Sair</a></p>
        <p id="mensagem"><%=mensagem%> <input type="button" name="" value="Mudar?" onclick="aparece()"/> </p>
        <form name="formMensagem" action="ServletEditaPerfil" method="GET" id="formMensagem" style="display: none;" >
            <label for="mensagem">Mensagem:
                <input type="text" name="mensagem" value="<%=mensagem%>" />
                <input type="submit" value="Ok" name="btMensagem" />
            </label>
        </form>

        <form name="formBuscaUsuario" action="ServletBuscaUsuario" method="POST">
            <label for="nomeUsuario">Pesquisar:
                <input type="text" name="nomeUsuario" value="" />
                <input type="submit" value="Pesquisar" name="btPesquisar" />
            </label>
        </form>       

        
        <%
                if (u.getAmigos().size() > 9) { //mostra no maximo 9 amigos
                    for (int i = 0; i < 9; i++) {
                        Usuario sorteado = u.getAmigos().get(new Random().nextInt(u.getAmigos().size())); //sorteia um amigo na lista
                        out.println("<a href=\"ServletPerfil?id=" + sorteado.getId() + "\">" + sorteado.getNome() + "</a><br />");
                    }
                } else {
                    for (Usuario user : u.getAmigos()) {
                        out.println("<a href=\"ServletPerfil?id=" + user.getId() + "\">" + user.getNome() + "</a><br />");
                    }
                }
            }
        %>
        <a href="ServletExibeAmigos?pagina=1">Todos</a>
    </body>
</html>
