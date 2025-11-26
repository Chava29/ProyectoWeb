<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
    String idStr = request.getParameter("id");
    if (idStr == null) {
        out.println("ID faltante.");
        return;
    }
    int id = Integer.parseInt(idStr);

    // (Opcional) Verificar integridad: si hay partidos que referencien al equipo, podrías
    // impedir borrar o hacer cascade. Aquí asumimos que el profe no puso FK ON DELETE CASCADE,
    // así que el DELETE fallará si existen partidos; puedes decidir borrar partidos primero.
    String sql = "DELETE FROM equipo WHERE idEquipo = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, id);
        int r = ps.executeUpdate();
        if (r > 0) {
            out.println("<p>Equipo eliminado correctamente.</p>");
        } else {
            out.println("<p>No se encontró/eliminó el equipo.</p>");
        }
        out.println("<a href='listaEquipos.jsp' target='_self'>Volver a la lista</a>");
    } catch (SQLException sqle) {
        // Error típico: FK constraint
        out.println("<p>Error al eliminar: " + sqle.getMessage() + "</p>");
        out.println("<p>Si existen partidos con este equipo, elimínalos primero o modifica la FK.</p>");
        out.println("<a href='listaEquipos.jsp' target='_self'>Volver</a>");
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>
