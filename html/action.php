<?php

  $host = getenv("DB_HOST");
  $dbname = getenv("DB_NAME");
  $username = getenv("DB_USERNAME");
  $password = getenv("DB_PASSWORD");

if(isset($_POST['firstname']) && isset($_POST['lastname'])){
  try {
  // se connecter à mysql
  $pdo = new PDO("mysql:host=$host;dbname=$dbname","$username","$password");
  } catch (PDOException $exc) {
    echo $exc->getMessage();
    exit();
  }
  
  // récupérer les valeurs 
  $firstname = $_POST['firstname'];
  $lastname = $_POST['lastname'];

  // Requête mysql pour insérer des données
  $sql = "INSERT INTO `user`(`firstname`, `lastname`) VALUES (:firstname,:lastname)";
  $res = $pdo->prepare($sql);
  $exec = $res->execute(array(":firstname"=>$firstname,":lastname"=>$lastname));

  // vérifier si la requête d'insertion a réussi
  if($exec){
    header('Location: ' . "/view.php" );
   die();
  }else{
    echo "Échec de l'opération d'insertion";
  }
} else {
    echo 'Pas de données inséré';
}
?>