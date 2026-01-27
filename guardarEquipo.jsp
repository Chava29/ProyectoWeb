<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    boolean exito = false;
    String mensaje = "";
    try {
        String nombre  = request.getParameter("nombre");
        String ciudad  = request.getParameter("ciudad");
        String estadio = request.getParameter("estadio");

        String sql = "INSERT INTO equipo(nombre, ciudad, estadio) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nombre);
            ps.setString(2, ciudad);
            ps.setString(3, estadio);
            ps.executeUpdate();
            exito = true;
            mensaje = "Equipo guardado correctamente.";
        }
    } catch (Exception e) {
        exito = false;
        mensaje = "Error al guardar el equipo: " + e.getMessage();
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Guardar Equipo</title>
    <link rel="stylesheet" href="formularios.css">
    <style>
        /* Ajustes pequeños locales por si faltan clases */
        .form-card { max-width: 720px; margin: 18px; }
        .msg { padding: 12px; border-radius: 8px; margin-bottom: 12px; font-weight:600; }
        .msg.ok { background: rgba(34,197,94,0.08); color: #bbf7d0; border:1px solid rgba(34,197,94,0.18); }
        .msg.err { background: rgba(239,68,68,0.06); color:#fca5a5; border:1px solid rgba(239,68,68,0.16); }
        .links { margin-top: 12px; }
        .links .btn-link { margin-right: 8px; text-decoration:none; display:inline-block; }
        .links a {
    color: #9fc0ff;
    text-decoration: none;
    border-bottom: 1px dashed rgba(159,192,255,0.18);
}
.links a:hover { color: #60a5fa; }
    </style>
</head>
<body>
    <div class="form-card">
        <h2>Registro de equipo</h2>

        <div class="msg <%= exito ? "ok" : "err" %>">
            <%= mensaje %>
        </div>

        <div class="links">
            <!-- cargan dentro del iframe llamado "contenido" -->
            <a class="btn-link success" href="registroEquipo.jsp" target="contenido">Registrar otro</a>
            <a class="btn-link" href="listaEquipos.jsp" target="contenido">Ver lista de equipos</a>
            <a class="btn-link ghost" href="index.html" target="_top">Volver al inicio</a>
        </div>
    </div>
</body>
</html>
