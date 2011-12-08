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
        <%@include file="head.jsp" %>
        <title>Editar Perfil</title>
        <script type="text/javascript">
            jQuery(function($){            
                $.mask.definitions['~']='[+-]';
                $('#datanascimento').mask('99/99/9999');
            })
        </script>
    </head>

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

    %>
    <body>
        <%-- HEADER --%>
        <%@include file="header.jsp" %>
        <%-- BODY --%>
        <div class="bgcontainer">
            <div class="container">
                <h2> Editar </h2>
                <p class="voltar"><a href="home.jsp">Voltar</a></p>
                <form name="formEditaPerfil" action="ServletEditaPerfil" method="post" enctype="multipart/form-data" class="formulario">
                    <p><label for="nome">Nome:</label><input type="text" name="nome" value="<%=nome%>" id="nome"/></p>
                    <p><label for="datanascimento">Nascimento:</label><input type="text" name="dataNascimento" id="datanascimento" value="<%=dataNascimento%>"/></p>
                    <p class="radios"><label for="Sexo">Sexo:</label>
                        <% if (sexo == 'F') {
                                out.println("Masculino: <input type=\"radio\" name=\"sexo\" value=\"M\"/><br/>");
                                out.println("Feminino: <input type=\"radio\" name=\"sexo\" value=\"F\" checked=\"checked\"/> ");
                            } else {
                                out.println("Masculino: <input type=\"radio\" name=\"sexo\" value=\"M\" checked=\"checked\"/><br/>");
                                out.println("Feminino: <input type=\"radio\" name=\"sexo\" value=\"F\"/>");
                            }
                        %>                       
                    </p>
                    <p><label for="descricao">Descricao:</label>
                        <input type="text" name="descricao" value="<%=descricao%>" id="descricao"/></p>
                    <p><label for="pais">Pais:</label>
                        <select name="pais" id="pais">
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
                    <p><label for="cidade">Cidade:</label>
                        <input type="text" name="cidade" value="<%=cidade%>" id="cidade"/></p>
                    <p><label for="imagem">Imagem:</label>
                        <input name="imagem" type="file" maxlength="60" id="imagem"/>
                        <input type="submit" name="upload" value="insert" hidden="true"/></p>
                    <p><input type="submit" value="" name="btSalvar" /></p>
                </form>
                <%
                    }
                %>
            </div>
        </div>
        <%-- FOOTER --%>
        <%@include file="footer.jsp" %>
    </body>
</html>
