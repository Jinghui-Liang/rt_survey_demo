<?php
require_once(__DIR__ . '/private/dbConnect.php');
$dbCon = new dbConnect();
$pdo = $dbCon->getPDO();

$json_string = json_decode(file_get_contents('php://input'), true);
header('Content-Type: application/json; charset=utf-8');

try {    
    $data = array(
        ':p_id' => $json_string['p_id'], 
        ':order_label' => $json_string['order_label']
    );
    $test = $json_string['order_label'];

// change table names in the code below when use questionnaires with different length.
    
    $querya = "INSERT INTO order_match_3 (p_id, order_label) VALUES (:p_id, :order_label)";
    $stmt = $pdo->prepare($querya);
    $stmt->execute($data);
  
    $queryb = "UPDATE frequency_counter_3 SET n = n + 1 WHERE order_label = ?";
    $stmt = $pdo->prepare($queryb);
    $stmt->execute([$test]);
  
} catch(PDOException $e) {
    echo $e;
};

?>
