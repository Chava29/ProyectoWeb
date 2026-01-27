<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Estadísticas</title>
    <link rel="stylesheet" href="tablas.css">
</head>
<body>

<div class="table-card">
    <h2> Estadisticas de la Liga</h2>

    <%
        int totalEquipos = 0;
        int totalPartidos = 0;
        int totalGoles = 0;
        String mejorAtaque = "-";
        int golesMejorAtaque = 0;

        try {
            // 1) Total de equipos
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery("SELECT COUNT(*) AS total FROM equipo")) {
                if (rs.next()) totalEquipos = rs.getInt("total");
            }

            // 2) Total de partidos
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery("SELECT COUNT(*) AS total FROM partido")) {
                if (rs.next()) totalPartidos = rs.getInt("total");
            }

            // 3) Total de goles
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery("SELECT COALESCE(SUM(golesLocal + golesVisitante),0) AS total FROM partido")) {
                if (rs.next()) totalGoles = rs.getInt("total");
            }

            // 4) Mejor ataque (equipo con más goles a favor)
            String sqlMejorAtaque =
                "SELECT e.nombre, SUM(gf) AS golesFavor FROM ( " +
                "   SELECT idLocal AS idEquipo, golesLocal AS gf FROM partido " +
                "   UNION ALL " +
                "   SELECT idVisitante AS idEquipo, golesVisitante AS gf FROM partido " +
                ") t " +
                "JOIN equipo e ON e.idEquipo = t.idEquipo " +
                "GROUP BY e.idEquipo, e.nombre " +
                "ORDER BY golesFavor DESC " +
                "LIMIT 1";

            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery(sqlMejorAtaque)) {
                if (rs.next()) {
                    mejorAtaque = rs.getString("nombre");
                    golesMejorAtaque = rs.getInt("golesFavor");
                }
            }

        } catch (Exception e) {
            out.println("<p class='error'>Error al cargar estadísticas: " + e.getMessage() + "</p>");
        }
    %>

    <!-- Tarjetas -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-title">Equipos registrados</div>
            <div class="stat-value"><%= totalEquipos %></div>
        </div>

        <div class="stat-card">
            <div class="stat-title">Partidos jugados</div>
            <div class="stat-value"><%= totalPartidos %></div>
        </div>

        <div class="stat-card">
            <div class="stat-title">Goles totales</div>
            <div class="stat-value"><%= totalGoles %></div>
        </div>

        <div class="stat-card">
            <div class="stat-title">Mejor ataque</div>
            <div class="stat-value"><%= mejorAtaque %></div>
            <div class="stat-sub">Goles a favor: <%= golesMejorAtaque %></div>
        </div>
    </div>

    <div style="margin-top:14px; text-align:center;">
        <a class="btn nuevo" href="tablaLiga.jsp">Ver tabla de posiciones</a>
        <a class="btn editar" href="listaPartidos.jsp">Ver partidos</a>
    </div>

</div>

</body>
</html>
