<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    String idStr = request.getParameter("idEquipo");
    if (idStr == null) {
        out.println("ID faltante.");
        return;
    }
    int id = Integer.parseInt(idStr);
    String nombre = request.getParameter("nombre");
    String ciudad = request.getParameter("ciudad");
    String estadio = request.getParameter("estadio");

    String sql = "UPDATE equipo SET nombre = ?, ciudad = ?, estadio = ? WHERE idEquipo = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, nombre);
        ps.setString(2, ciudad);
        ps.setString(3, estadio);
        ps.setInt(4, id);
        int r = ps.executeUpdate();
        if (r > 0) {
            out.println("<p>Equipo actualizado correctamente.</p>");
            out.println("<a href='listaEquipos.jsp' target='_self'>Volver a la lista</a>");
        } else {
            out.println("<p>No se actualizó el equipo.</p>");
        }
    } catch (Exception e) {
        out.println("<p>Error al actualizar: " + e.getMessage() + "</p>");
    }
%>
