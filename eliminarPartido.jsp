<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
    String idStr = request.getParameter("id");
    if (idStr == null) {
        out.println("<p>ID faltante.</p>");
        return;
    }
    int id = Integer.parseInt(idStr);
    boolean exito = false;
    String mensaje = "";
    try {
        String sql = "DELETE FROM partido WHERE idPartido = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            int r = ps.executeUpdate();
            if (r > 0) {
                exito = true;
                mensaje = "Partido eliminado correctamente.";
            } else {
                mensaje = "No se encontró/eliminó el partido.";
            }
        }
    } catch (SQLException sqle) {
        mensaje = "Error al eliminar (SQL): " + sqle.getMessage();
    } catch (Exception e) {
        mensaje = "Error: " + e.getMessage();
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Eliminar Partido</title>
    <link rel="stylesheet" href="formularios.css">
</head>
<body>
<div class="form-card">
    <h2>Eliminar partido</h2>

    <div class="msg <%= exito ? "ok" : "err" %>"><%= mensaje %></div>

    <div class="links">
        <a class="btn-link" href="listaPartidos.jsp" target="contenido">Volver a la lista</a>
        <a class="btn-link ghost" href="registroPartido.jsp" target="contenido">Registrar partido</a>
        <a class="btn-link" href="tablaLiga.jsp" target="contenido">Ver tabla</a>
    </div>
</div>
</body>
</html>
