<?php
  $host = getenv("DB_HOST");
  $dbname = getenv("DB_NAME");
  $username = getenv("DB_USERNAME");
  $password = getenv("DB_PASSWORD");

    
  $dsn = "mysql:host=$host;dbname=$dbname"; 
  // récupérer tous les utilisateurs
  $sql = "SELECT * FROM user";
   
  try{
   $pdo = new PDO($dsn, $username, $password);

   $createTableSQL = "CREATE TABLE IF NOT EXISTS user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    lastname VARCHAR(50) NOT NULL,
    firstname VARCHAR(50) NOT NULL
   )";
   $pdo->exec($createTableSQL);

   $stmt = $pdo->query($sql);
   
   if($stmt === false){
    die("Erreur");
   }
   
  }catch (PDOException $e){
    echo $e->getMessage();
  }
?>

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
 <h1>Liste des utilisateurs</h1>
 <table>
   <thead>
     <tr>
       <th>ID</th>
       <th>Name</th>
     </tr>
   </thead>
   <tbody>
     <p> hello</p>
     
     <?php while($row = $stmt->fetch(PDO::FETCH_ASSOC)) : ?>
     <tr>
       <td><?php echo htmlspecialchars($row['id']); ?></td>
       <td><?php echo htmlspecialchars($row['lastname']); ?></td>
       <td><?php echo htmlspecialchars($row['firstname']); ?></td>
     </tr>
     <?php endwhile; ?>
   </tbody>
 </table>
</body>
</html>
