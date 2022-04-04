<?php
class dbConnect {
    private $pdo = null;

    public function getPDO(){
        return $this->pdo;
    }

    public function __construct(){
        try {
            $conf = parse_ini_file(__DIR__ . '/conf.ini', true);
            $dsn = sprintf('mysql:host=%s;port=%s;dbname=%s', $conf['database']['host'], $conf['database']['port'], $conf['database']['dbname']);
            $username = $conf['database']['username'];
            $password = $conf['database']['password'];

            $this->pdo = new PDO($dsn, $username, $password);
            // set the PDO error mode to exception
            $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch(PDOException $e) {
            echo "<script>console.log('Connection failed: " . $e->getMessage() . "')</script>";
        }
    }
}

?>
