<?php
require_once(__DIR__ . '/private/dbConnect.php');
$dbCon = new dbConnect();
$pdo = $dbCon->getPDO();
       
$json_string = json_decode(file_get_contents('php://input'), true);
       
try {    
    $data = array(
        ':p_id' => $json_string['p_id'], 
        ':order_label' => $json_string['order_label']
    );
    $test = $json_string['order_label'];
    

    // -- new here
    $email = array(
        ':p_id' => $json_string['p_id'], 
        ':email' => $json_string['email']
    );
    // -- new ends
       
    // change table names in the code below when use questionnaires with different length.
       
    $querya = "INSERT INTO order_match (p_id, order_label) VALUES (:p_id, :order_label)";
    $stmt = $pdo->prepare($querya);
    $stmt->execute($data);
       
    $queryb = "UPDATE frequency_counter SET n = n + 1 WHERE order_label = ?";
    $stmt = $pdo->prepare($queryb);
    $stmt->execute([$test]);
 
    $queryc = "INSERT INTO email (p_id, email) VALUES (:p_id, :email)";
    $stmt = $pdo->prepare($queryc);
    $stmt->execute($email);

    echo 'success';
       
} catch(PDOException $e) {
    http_response_code(500);
    echo $e -> getMessage();
};
?>
