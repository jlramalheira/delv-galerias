<%-- 
    Document   : editarperfil
    Created on : 09/09/2011, 11:09:52
    Author     : a968501
--%>

<%@page import="util.Util"%>
<%@page import="dao.Dao"%>
<%@page import="java.util.List"%>
<%@page import="entidades.Pais"%>
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
            Usuario u = (Usuario) session.getAttribute("usuario");

            if (u == null) {
                response.sendRedirect("login.jsp");
            } else {
                String nome = "";
                String dataNascimento = "";
                char sexo = '\0';
                String descricao = "";
                String cidade = "";
                String imagem = "";
                String pais = "";

                if (u.getNome() != null) {
                    nome = u.getNome();
                }
                if (u.getDataNascimento() != null) {
                    dataNascimento = Util.DateToString(u.getDataNascimento());
                }
                if (u.getCidade() != null) {
                    cidade = u.getCidade();
                }
                if (u.getDescricao() != null) {
                    descricao = u.getDescricao();
                }
                if (u.getSexo() != '\0') {
                    sexo = u.getSexo();
                }
                if (u.getPais() != null) {
                    pais = u.getPais().getNome();
                }

        %>
        <h1> Editar </h1>
        <a href="home.jsp">Voltar</a>
        <form name="formEditaPerfil" action="ServletEditaPerfil" method="post" enctype="multipart/form-data">
            <p><label for="Nome">Nome:</label><br/>
                <input type="text" name="nome" value="<%=nome%>"/></p>
            <p><label for="dataNascimento">Data Nascimento:</label><br/>
                <input type="text" name="dataNascimento" value="<%=dataNascimento%>"/></p>
            <p><label for="Sexo">Sexo:</label><br/>
                <% if (sexo == 'F') {
                        out.println("<p>Masculino: <input type=\"radio\" name=\"sexo\" value=\"M\"/> </p>");
                        out.println("<p>Feminino: <input type=\"radio\" name=\"sexo\" value=\"F\" checked=\"checked\"/> </p>");
                    } else {
                        out.println("<p>Masculino: <input type=\"radio\" name=\"sexo\" value=\"M\" checked=\"checked\"/> </p>");
                        out.println("<p>Feminino: <input type=\"radio\" name=\"sexo\" value=\"F\"/> </p>");
                    }
                %>
            </p>

            <p><label for="Descricao">Descricao:</label><br/>
                <input type="text" name="descricao" value="<%=descricao%>"/></p>
            <p><label for="Pais">Pais:</label><br/>
                <select name="pais">
                    <option value="-1">Escolha um país: </option>
                    <%
                        List<Pais> paises = new Dao<Pais>(Pais.class).list();
                        if (u.getPais() != null) { //caso tenha algum, escolhe o selcionado
                            for (Pais p : paises) {
                                if (u.getPais() == p) {
                                    out.println("<option value=\"" + p.getId() + "\" selected=\"selected\">" + p.getNome() + "</option>");
                                } else {
                                    out.println("<option value=\"" + p.getId() + "\">" + p.getNome() + "</option>");

                                }
                            }
                        } else {
                            for (Pais p : paises) {
                                out.println("<option value=\"" + p.getId() + "\">" + p.getNome() + "</option>");
                            }
                        }
                    %>
                </select></p>
            <p><label for="Cidade">Cidade:</label><br/>
                <input type="text" name="cidade" value="<%=cidade%>"/></p>
            <p><label for="Cidade">Cidade:</label><br/>
                <input name="imagem" type="file" maxlength="60" />
                <input type="submit" name="upload" value="insert" /></p>
            <p><input type="submit" value="Salvar" name="btSalvar" /></p>
        </form>
        <%
            }
        %>
    </body>
</html>
