<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar equipo</title>
    <link rel="stylesheet" href="formularios.css">
</head>
<body>

<div class="form-card">
    <h2>Registrar equipo</h2>

    <form action="guardarEquipo.jsp" method="post">
        <label>Nombre:</label>
        <input type="text" name="nombre" required>

        <label>Ciudad:</label>
        <input type="text" name="ciudad">

        <label>Estadio:</label>
        <input type="text" name="estadio">

        <input type="submit" value="Guardar equipo">
    </form>
</div>

</body>
</html>
