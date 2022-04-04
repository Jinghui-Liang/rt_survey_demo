<?php

require_once(__DIR__ . '/private/dbConnect.php');
$dbCon = new dbConnect();
$pdo = $dbCon->getPDO();

$json_string = json_decode(file_get_contents('php://input'), true);

header('Content-Type: application/json; charset=utf-8');

$sql_proc = 'CALL ' . $json_string['proc_method'] . '(?)';

$sth = $pdo->prepare($sql_proc);

foreach ($json_string['json_trials'] as $x) {
    $sth->bindValue(1, json_encode($x), PDO::PARAM_STR);
    $sth->execute();
};
