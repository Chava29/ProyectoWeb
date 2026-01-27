<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
    boolean exito = false;
    String mensaje = "";
    try {
        int idLocal = Integer.parseInt(request.getParameter("idLocal"));
        int idVisitante = Integer.parseInt(request.getParameter("idVisitante"));
        int golesLocal = Integer.parseInt(request.getParameter("golesLocal"));
        int golesVisitante = Integer.parseInt(request.getParameter("golesVisitante"));
        String fecha = request.getParameter("fecha");
        String jStr = request.getParameter("jornada");
        Integer jornada = null;
        if (jStr != null && !jStr.trim().isEmpty()) {
            jornada = Integer.parseInt(jStr);
        }

        String sql = "INSERT INTO partido(idLocal, idVisitante, golesLocal, golesVisitante, fecha, jornada) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idLocal);
            ps.setInt(2, idVisitante);
            ps.setInt(3, golesLocal);
            ps.setInt(4, golesVisitante);
            if (fecha == null || fecha.trim().isEmpty()) ps.setNull(5, Types.DATE);
            else ps.setDate(5, java.sql.Date.valueOf(fecha));
            if (jornada == null) ps.setNull(6, Types.INTEGER);
            else ps.setInt(6, jornada);
            ps.executeUpdate();
            exito = true;
            mensaje = "Partido guardado correctamente.";
        }
    } catch (Exception e) {
        exito = false;
        mensaje = "Error al guardar el partido: " + e.getMessage();
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Guardar Partido</title>
    <!-- Enlaza tu CSS de formularios o tablas -->
    <link rel="stylesheet" href="formularios.css">
    <style>
        /* Si quieres colores extra para el mensaje */
        .msg {
            padding: 14px;
            border-radius: 10px;
            margin-bottom: 12px;
        }
        .msg.ok { background: rgba(34,197,94,0.12); color: #bbf7d0; border: 1px solid rgba(34,197,94,0.3); }
        .msg.err { background: rgba(239,68,68,0.06); color: #fca5a5; border: 1px solid rgba(239,68,68,0.18); }
        .links a { margin-right: 14px; text-decoration: none; color: #60a5fa; }
        .links a:hover { text-decoration: underline; color: #22c55e; }
    </style>
</head>
<body>
    <div class="form-card" style="max-width:600px;">
        <h2>Registro de partido</h2>

        <div class="msg <%= exito ? "ok" : "err" %>">
            <%= mensaje %>
        </div>

        <div class="links">
            <!-- target="contenido" carga la página dentro del iframe llamado "contenido" -->
            <a href="registroPartido.jsp" target="contenido">Registrar otro</a>
            <a href="listaPartidos.jsp" target="contenido">Ver lista de partidos</a>
            <a href="tablaLiga.jsp" target="contenido">Ver tabla de posiciones</a>
        </div>
    </div>
</body>
</html>
