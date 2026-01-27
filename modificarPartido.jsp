<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
    String idStr = request.getParameter("id");
    if (idStr == null) {
        out.println("<p>ID de partido no especificado.</p>");
        return;
    }
    int id = Integer.parseInt(idStr);

    // Valores por defecto
    Integer idLocal = null, idVisitante = null, golesLocal = 0, golesVisitante = 0, jornada = null;
    String fechaStr = "";

    String sql = "SELECT idLocal, idVisitante, golesLocal, golesVisitante, fecha, jornada FROM partido WHERE idPartido = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                idLocal = rs.getInt("idLocal");
                idVisitante = rs.getInt("idVisitante");
                golesLocal = rs.getInt("golesLocal");
                golesVisitante = rs.getInt("golesVisitante");
                Date f = rs.getDate("fecha");
                fechaStr = (f == null) ? "" : f.toString();
                int j = rs.getInt("jornada");
                if (!rs.wasNull()) jornada = j;
            } else {
                out.println("<p>Partido no encontrado.</p>");
                return;
            }
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Modificar Partido</title>
    <link rel="stylesheet" href="formularios.css">
</head>
<body>
<div class="form-card">
    <h2>Modificar partido</h2>

    <form action="actualizarPartido.jsp" method="post">
        <input type="hidden" name="idPartido" value="<%= id %>">

        <label>Equipo local:</label>
        <select name="idLocal" required>
            <option value="">-- Selecciona --</option>
            <%
                try (Statement st = conn.createStatement();
                     ResultSet rsEq = st.executeQuery("SELECT idEquipo, nombre FROM equipo ORDER BY nombre")) {
                    while (rsEq.next()) {
                        int eid = rsEq.getInt("idEquipo");
                        String ename = rsEq.getString("nombre");
            %>
                <option value="<%= eid %>" <%= (idLocal != null && idLocal == eid) ? "selected" : "" %>><%= ename %></option>
            <%
                    }
                }
            %>
        </select>

        <label>Equipo visitante:</label>
        <select name="idVisitante" required>
            <option value="">-- Selecciona --</option>
            <%
                try (Statement st2 = conn.createStatement();
                     ResultSet rsEq2 = st2.executeQuery("SELECT idEquipo, nombre FROM equipo ORDER BY nombre")) {
                    while (rsEq2.next()) {
                        int eid = rsEq2.getInt("idEquipo");
                        String ename = rsEq2.getString("nombre");
            %>
                <option value="<%= eid %>" <%= (idVisitante != null && idVisitante == eid) ? "selected" : "" %>><%= ename %></option>
            <%
                    }
                }
            %>
        </select>

        <label>Goles local:</label>
        <input type="number" name="golesLocal" value="<%= golesLocal %>" min="0" required>

        <label>Goles visitante:</label>
        <input type="number" name="golesVisitante" value="<%= golesVisitante %>" min="0" required>

        <label>Fecha:</label>
        <input type="date" name="fecha" value="<%= fechaStr %>">

        <label>Jornada (opcional):</label>
        <input type="number" name="jornada" min="1" value="<%= (jornada==null) ? "" : jornada %>">

        <div style="margin-top:12px;">
            <input type="submit" class="btn-primary" value="Actualizar partido">
            <a href="listaPartidos.jsp" class="btn btn-ghost" target="contenido" style="margin-left:10px;">Cancelar</a>
            <a href="eliminarPartido.jsp?id=<%= id %>" class="btn btn-danger" style="margin-left:10px;">Eliminar</a>
        </div>
    </form>
</div>
</body>
</html>
