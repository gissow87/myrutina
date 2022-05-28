<?php
$DBNAME = 'blxviccb_myrutina';
$DBHOST = 'localhost';
$DBUSER = 'blxviccb_myrutina';
$DBPASS = 'i3QaV+yP%hi{';

function connectDB(){
    $db_server = mysql_connect($db_hostname, $db_username, $db_password);
    return $db_server;
}

?>