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

function recuperarClave($parametros){
    $email = $parametros["email"];
    $codigo = $parametros["codigo"];
    $emailEnviado = mail(
        $email,
        "Generacion de clave nueva.",
        "Le enviamos el siguiente código para que pueda reestablecer su clave en MyRutina: \r\n$codigo"
    );
    if ($emailEnviado){
        return "Email enviado con éxito.";
    }
    else{
        return "Error al enviar el mail a: ".$email." \r\nVerifique si lo ingresó correctamente.";
    }
}

function cambiarClave($parametros){
    $email = $parametros["email"];
    $clave = $parametros["clave"];

    $db = connectDB();
    $resultado = $db->query("CALL sp_cambiarClave('$email','$clave')");
    if ($resultado) {
        return 1;
    } else {
        return "Error al cambiar clave: (" . $db->errno . ") " . $db->error;
    }

}

function randomPassword() {
    $alphabet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    $pass = []; //remember to declare $pass as an array
    $alphaLength = strlen($alphabet) - 1; //put the length -1 in cache
    for ($i = 0; $i < 8; $i++) {
        $n = rand(0, $alphaLength);
        $pass[] = $alphabet[$n];
    }
    return implode($pass); //turn the array into a string
}
