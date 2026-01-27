<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lista de equipos</title>
    <link rel="stylesheet" href="tablas.css">
</head>
<body>

<div class="table-card">
    <h2>Lista de equipos registrados</h2>

    <%
        String sql = "SELECT * FROM equipo ORDER BY nombre";
        try (Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
    %>

    <table class="tabla-equipos">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Ciudad</th>
                <th>Estadio</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <%
                while (rs.next()) {
                    int id = rs.getInt("idEquipo");
                    String nombre = rs.getString("nombre");
                    String ciudad = rs.getString("ciudad");
                    String estadio = rs.getString("estadio");
            %>
            <tr>
                <td><%= id %></td>
                <td><%= nombre %></td>
                <td><%= ciudad == null ? "" : ciudad %></td>
                <td><%= estadio == null ? "" : estadio %></td>
                <td class="acciones">
                    <!-- editar y eliminar: crea luego modificarEquipo.jsp y eliminarEquipo.jsp -->
                    <a class="btn editar" href="modificarEquipo.jsp?id=<%= id %>" >Editar</a>
                    <a class="btn borrar" href="eliminarEquipo.jsp?id=<%= id %>" onclick="return confirm('¿Eliminar equipo?');">Eliminar</a>
                </td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <%
        } catch (Exception e) {
            out.println("<p class='error'>Error al listar equipos: " + e.getMessage() + "</p>");
        }
    %>

    <p style="margin-top:12px;">
        <a class="btn nuevo" href="registroEquipo.jsp">Registrar equipo nuevo</a>
    </p>
</div>

</body>
</html>
