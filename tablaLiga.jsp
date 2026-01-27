<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="conexion.jsp" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Tabla de posiciones</title>
    <link rel="stylesheet" href="tablas.css">
</head>
<body>
<div class="table-card">
    <h2>Tabla de posiciones</h2>
<%
    class Stats {
        int id; String nombre;
        int pj, pg, pe, pp, gf, gc, pts;
        Stats(int id, String nombre){ this.id=id; this.nombre=nombre; }
    }
    Map<Integer, Stats> map = new LinkedHashMap<>();
    // cargar equipos
    try (Statement st = conn.createStatement();
         ResultSet rs = st.executeQuery("SELECT idEquipo, nombre FROM equipo")) {
        while (rs.next()) {
            int id = rs.getInt("idEquipo");
            map.put(id, new Stats(id, rs.getString("nombre")));
        }
    }
    // procesar partidos
    try (Statement st = conn.createStatement();
         ResultSet rs = st.executeQuery("SELECT idLocal,idVisitante,golesLocal,golesVisitante FROM partido")) {
        while (rs.next()) {
            int localId = rs.getInt("idLocal");
            int visitId = rs.getInt("idVisitante");
            int gl = rs.getInt("golesLocal");
            int gv = rs.getInt("golesVisitante");
            Stats L = map.get(localId);
            Stats V = map.get(visitId);
            if (L==null || V==null) continue;
            L.pj++; V.pj++;
            L.gf += gl; L.gc += gv;
            V.gf += gv; V.gc += gl;
            if (gl>gv) { L.pg++; V.pp++; L.pts += 3; }
            else if (gl<gv) { V.pg++; L.pp++; V.pts += 3; }
            else { L.pe++; V.pe++; L.pts++; V.pts++; }
        }
    }
    // ordenamos
    List<Stats> lista = new ArrayList<>(map.values());
    Collections.sort(lista, new Comparator<Stats>(){
        public int compare(Stats a, Stats b){
            if (b.pts != a.pts) return b.pts - a.pts;
            int dgA = a.gf - a.gc;
            int dgB = b.gf - b.gc;
            if (dgB != dgA) return dgB - dgA;
            return b.gf - a.gf; // más goles a favor
        }
    });
%>

<table class="tabla-equipos">
    <thead>
        <tr>
            <th>#</th><th>Equipo</th><th>PJ</th><th>PG</th><th>PE</th><th>PP</th><th>GF</th><th>GC</th><th>DG</th><th>PTS</th>
        </tr>
    </thead>
    <tbody>
    <%
        int pos=1;
        for (Stats s : lista) {
            int dg = s.gf - s.gc;
    %>
        <tr>
            <td><%= pos++ %></td>
            <td><%= s.nombre %></td>
            <td><%= s.pj %></td>
            <td><%= s.pg %></td>
            <td><%= s.pe %></td>
            <td><%= s.pp %></td>
            <td><%= s.gf %></td>
            <td><%= s.gc %></td>
            <td><%= dg %></td>
            <td><%= s.pts %></td>
        </tr>
    <%
        }
    %>
    </tbody>
</table>
</div>
</body>
</html>
