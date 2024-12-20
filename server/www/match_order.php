<?php
require_once(__DIR__ . '/private/dbConnect.php');
$dbCon = new dbConnect();
$pdo = $dbCon->getPDO();

$json_string = json_decode(file_get_contents('php://input'), true);

$query = "SELECT * FROM order_list WHERE order_label IN
                          (SELECT order_label FROM frequency_counter WHERE counter < n)
                        ORDER BY RAND() LIMIT 1";

try{
    $sth = $pdo->query($query);
    $result = $sth->fetchAll(PDO::FETCH_ASSOC);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($result);

} catch (PDOException $e) {
    http_response_code (500);
    echo $e-> getMessage ();
};

?>
