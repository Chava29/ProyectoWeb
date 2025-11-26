<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lista de partidos</title>
    <link rel="stylesheet" href="tablas.css">
</head>
<body>
<div class="table-card">
    <h2>Partidos registrados</h2>
    <%
        String sql = "SELECT p.idPartido, p.fecha, p.jornada, " +
                     "l.nombre AS local, v.nombre AS visitante, p.golesLocal, p.golesVisitante " +
                     "FROM partido p " +
                     "JOIN equipo l ON p.idLocal = l.idEquipo " +
                     "JOIN equipo v ON p.idVisitante = v.idEquipo " +
                     "ORDER BY COALESCE(p.jornada, 999), p.fecha DESC";
        try (Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
    %>

    <table class="tabla-equipos">
        <thead>
            <tr>
                <th class="numeric">ID</th>
                <th class="numeric">Jornada</th>
                <th>Fecha</th>
                <th>Local</th>
                <th>Visitante</th>
                <th class="numeric">Resultado</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
        <%
            while (rs.next()) {
                int id = rs.getInt("idPartido");
                String jornada = rs.getString("jornada");
                Date fecha = rs.getDate("fecha");
                String local = rs.getString("local");
                String visitante = rs.getString("visitante");
                int gl = rs.getInt("golesLocal");
                int gv = rs.getInt("golesVisitante");
        %>
            <tr>
                <td class="numeric"><%= id %></td>
                <td class="numeric"><%= jornada == null ? "-" : jornada %></td>
                <td><%= fecha == null ? "-" : fecha %></td>
                <td><%= local %></td>
                <td><%= visitante %></td>
                <td class="numeric"><%= gl %> - <%= gv %></td>
                <td class="acciones">
                    <!-- EDITAR: carga dentro del iframe -->
                    <a class="btn editar" href="modificarPartido.jsp?id=<%= id %>" target="contenido">Editar</a>

                    <!-- ELIMINAR: confirma y carga dentro del iframe -->
                    <a class="btn borrar" href="eliminarPartido.jsp?id=<%= id %>" target="contenido"
                       onclick="return confirm('¿Eliminar partido?');">Eliminar</a>
                </td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <p style="margin-top:12px; text-align:center;">
        <a class="btn nuevo" href="registroPartido.jsp" target="contenido">Registrar partido nuevo</a>
    </p>

    <%
        } catch (Exception e) {
            out.println("<p class='error'>Error al listar partidos: " + e.getMessage() + "</p>");
        }
    %>
</div>
</body>
</html>
