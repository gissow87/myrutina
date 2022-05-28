<?php
include_once('config.php');

$funcion = $_POST["funcion"];
$base64Parametros = $_POST["parametrosB64"];

if (function_exists($funcion)){
    echo call_user_func($funcion, json_decode(base64_decode($base64Parametros), true));
}
else{
    echo "No existe la funcion"; 
}

function login($parametros){
    return "HOLA";
}