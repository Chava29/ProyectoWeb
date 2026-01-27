<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Partido</title>
    <link rel="stylesheet" href="formularios.css">
</head>
<body>
<div class="form-card">
    <h2>Registrar partido</h2>
    <form action="guardarPartido.jsp" method="post">
        <label>Equipo local:</label>
        <select name="idLocal" required>
            <option value="">-- Selecciona --</option>
            <%
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery("SELECT idEquipo, nombre FROM equipo ORDER BY nombre");
                while (rs.next()) {
            %>
                <option value="<%= rs.getInt("idEquipo") %>"><%= rs.getString("nombre") %></option>
            <%
                }
                rs.close();
                st.close();
            %>
        </select>

        <label>Equipo visitante:</label>
        <select name="idVisitante" required>
            <option value="">-- Selecciona --</option>
            <%
                Statement st2 = conn.createStatement();
                ResultSet rs2 = st2.executeQuery("SELECT idEquipo, nombre FROM equipo ORDER BY nombre");
                while (rs2.next()) {
            %>
                <option value="<%= rs2.getInt("idEquipo") %>"><%= rs2.getString("nombre") %></option>
            <%
                }
                rs2.close();
                st2.close();
            %>
        </select>

        <label>Goles local:</label>
        <input type="number" name="golesLocal" value="0" min="0" required>

        <label>Goles visitante:</label>
        <input type="number" name="golesVisitante" value="0" min="0" required>

        <label>Fecha:</label>
        <input type="date" name="fecha">

        <label>Jornada (opcional):</label>
        <input type="number" name="jornada" min="1">

        <input type="submit" value="Guardar partido">
    </form>
</div>
</body>
</html>
