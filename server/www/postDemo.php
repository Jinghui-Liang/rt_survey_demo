<?php
require_once(__DIR__ . '/private/dbConnect.php');
$dbCon = new dbConnect();
$pdo = $dbCon->getPDO();
  
$pdo = $dbCon->getPDO();

$json_string = json_decode(file_get_contents('php://input'), true);

try {    
    $data = array(
        ':p_id' => $json_string['p_id'], 
        ':age' => $json_string['age'],
        ':gender' => $json_string['gender']
    );

    $query = "INSERT INTO demo (p_id, age, gender) VALUES (:p_id, :age, :gender)";
    $stmt = $pdo->prepare($query);
    $stmt->execute($data);

    echo 'demo post success';

} catch(PDOException $e) {
    http_response_code(500);
    echo $e -> getMessage();
};

?>
