<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    boolean exito = false;
    String mensaje = "";
    try {
        int idPartido = Integer.parseInt(request.getParameter("idPartido"));
        int idLocal = Integer.parseInt(request.getParameter("idLocal"));
        int idVisitante = Integer.parseInt(request.getParameter("idVisitante"));
        int golesLocal = Integer.parseInt(request.getParameter("golesLocal"));
        int golesVisitante = Integer.parseInt(request.getParameter("golesVisitante"));
        String fecha = request.getParameter("fecha");
        String jStr = request.getParameter("jornada");
        Integer jornada = null;
        if (jStr != null && !jStr.trim().isEmpty()) jornada = Integer.parseInt(jStr);

        String sql = "UPDATE partido SET idLocal=?, idVisitante=?, golesLocal=?, golesVisitante=?, fecha=?, jornada=? WHERE idPartido=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idLocal);
            ps.setInt(2, idVisitante);
            ps.setInt(3, golesLocal);
            ps.setInt(4, golesVisitante);
            if (fecha == null || fecha.trim().isEmpty()) ps.setNull(5, Types.DATE);
            else ps.setDate(5, java.sql.Date.valueOf(fecha));
            if (jornada == null) ps.setNull(6, Types.INTEGER);
            else ps.setInt(6, jornada);
            ps.setInt(7, idPartido);
            int r = ps.executeUpdate();
            if (r > 0) {
                exito = true;
                mensaje = "Partido actualizado correctamente.";
            } else {
                mensaje = "No se actualizó el partido (ID no encontrado).";
            }
        }
    } catch (Exception e) {
        mensaje = "Error al actualizar: " + e.getMessage();
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Actualizar Partido</title>
    <link rel="stylesheet" href="formularios.css">
</head>
<body>
<div class="form-card">
    <h2>Actualizar partido</h2>

    <div class="msg <%= exito ? "ok" : "err" %>"><%= mensaje %></div>

    <div class="links">
        <a class="btn-link" href="listaPartidos.jsp" target="contenido">Ver lista de partidos</a>
        <a class="btn-link success" href="registroPartido.jsp" target="contenido">Registrar partido nuevo</a>
        <a class="btn-link ghost" href="tablaLiga.jsp" target="contenido">Ver tabla</a>
    </div>
</div>
</body>
</html>
