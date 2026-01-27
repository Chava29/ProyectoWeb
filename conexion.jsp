<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>

<%
    String url = "jdbc:mysql://localhost:3306/liga";
    String user = "root";
    String password = "n0m3l0";

    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
    } catch (Exception e) {
        out.println("Error de conexión: " + e.getMessage());
    }
%>
