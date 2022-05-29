<?php

function connectDB(){
    $DBNAME = 'blxviccb_myrutina';
    $DBHOST = 'localhost';
    $DBUSER = 'blxviccb_myrutina';
    $DBPASS = 'i3QaV+yP%hi{';
    
    $mysqli = new mysqli($DBHOST, $DBUSER, $DBPASS, $DBNAME);
    if ($mysqli->connect_errno) {
        echo "Falló la conexión a MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
    }
    return $mysqli;
}

?>