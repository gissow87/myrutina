<?php
include_once('config.php');

$funcion = $_POST["funcion"];
$base64Parametros = $_POST["parametrosB64"];

if (function_exists($funcion)) {
    echo call_user_func($funcion, json_decode(base64_decode($base64Parametros), true));
} else {
    echo "No existe la funcion";
}

function registrarse($parametros)
{
    $db = connectDB();
    $nombre = $parametros['nombre'];
    $dni = $parametros['dni'];
    $telefono = $parametros['telefono'];
    $email = $parametros['email'];
    $clave = $parametros['clave'];
    $resultado = $db->query("CALL sp_registro('$nombre', '$dni', '$email', '$clave','$telefono')");
    if ($resultado) {
        return 1;
    } else {
        return "Error al registrarse: (" . $db->errno . ") " . $db->error;
    }
    $db->close();
}

function login($parametros)
{
    $db = connectDB();
    $email = $parametros['email'];
    $clave = $parametros['clave'];

    $resultado = $db->query("CALL sp_login('$email', '$clave')");
    if ($resultado) {
        $row = mysqli_fetch_assoc($resultado);
        return json_encode($row);
    } else {
        return "Error al registrarse: (" . $db->errno . ") " . $db->error;
    }
    $db->close();
}
