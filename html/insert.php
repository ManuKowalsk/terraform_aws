<!DOCTYPE html>
<html>
  <head>
      <title>AWS SDV</title>
  </head>  
  <body>
  <nav>
          <a href="/">
              <button>Home</button>
          </a>
          <a href="view.php">
              <button>View Users</button>
          </a>
          <a href="insert.php">
              <button>Insert User</button>
          </a>
  </nav>
    <form action="action.php" method="post">
    <label>Votre nom :</label>
    <input name="lastname" id="lastname" type="text" />

    <label>Votre prénom :</label>
    <input name="firstname" id="firstname" type="text" /></p>

    <button type="submit">Valider</button>
  </form>
  </body>
</html>

<?php

  $host = getenv("DB_HOST");
  $dbname = getenv("DB_NAME");
  $username = getenv("DB_USERNAME");
  $password = getenv("DB_PASSWORD");

if(isset($_GET['firstname']) && isset($_GET['lastname'])){
  try {
  // se connecter à mysql
  $pdo = new PDO("mysql:host=$host;dbname=$dbname","$username","$password");
  $createTableSQL = "CREATE TABLE IF NOT EXISTS user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    lastname VARCHAR(50) NOT NULL,
    firstname VARCHAR(50) NOT NULL
   )";
  $pdo->exec($createTableSQL);
  } catch (PDOException $exc) {
    echo $exc->getMessage();
    exit();
  }

  // récupérer les valeurs 
  $firstname = $_GET['firstname'];
  $lastname = $_GET['lastname'];

  // Requête mysql pour insérer des données
  $sql = "INSERT INTO `user`(`firstname`, `lastname`) VALUES (:firstname,:lastname)";
  $res = $pdo->prepare($sql);
  $exec = $res->execute(array(":firstname"=>$firstname,":lastname"=>$lastname));

  // vérifier si la requête d'insertion a réussi
  if($exec){
    echo 'Données insérées';
  }else{
    echo "Échec de l'opération d'insertion";
  }
} else {
    echo 'Pas de données inséré';
}
?>