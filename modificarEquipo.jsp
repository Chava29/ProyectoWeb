<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
    String idStr = request.getParameter("id");
    if (idStr == null) {
        out.println("<p>ID no especificado.</p>");
        return;
    }
    int id = Integer.parseInt(idStr);
    String sql = "SELECT * FROM equipo WHERE idEquipo = ?";
    String nombre="", ciudad="", estadio="";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                nombre = rs.getString("nombre");
                ciudad = rs.getString("ciudad");
                estadio = rs.getString("estadio");
            } else {
                out.println("<p>Equipo no encontrado.</p>");
                return;
            }
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Modificar Equipo</title>
    <link rel="stylesheet" href="formularios.css">
</head>
<body>
<div class="form-card">
    <h2>Modificar equipo</h2>
    <form action="actualizarEquipo.jsp" method="post">
        <input type="hidden" name="idEquipo" value="<%= id %>">
        <label>Nombre:</label>
        <input type="text" name="nombre" value="<%= nombre %>" required>

        <label>Ciudad:</label>
        <input type="text" name="ciudad" value="<%= ciudad == null ? "" : ciudad %>">

        <label>Estadio:</label>
        <input type="text" name="estadio" value="<%= estadio == null ? "" : estadio %>">

        <input type="submit" value="Actualizar">
    </form>
</div>
</body>
</html>
