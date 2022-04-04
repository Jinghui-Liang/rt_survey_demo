<?php
require_once(__DIR__ . '/private/dbConnect.php');
$dbCon = new dbConnect();
$pdo = $dbCon->getPDO();

$json_string = json_decode(file_get_contents('php://input'), true);
header('Content-Type: application/json; charset=utf-8');

// $query = "select * from order_list_6 where order_label in (select order_label from frequency_counter_6 where n < 1) order by rand() limit 1";

$query = "select * from order_list_3 where order_label in (select order_label from frequency_counter_3 where n < 1) order by rand() limit 1";

try{
    $sth = $pdo->query($query);

    $result = $sth->fetchAll(PDO::FETCH_ASSOC);

    header('Content-Type: application/json');
    echo json_encode($result);
} catch (PDOException $e) {
    http_response_code (500);
    echo $e-> getMessage ();
};

?>
