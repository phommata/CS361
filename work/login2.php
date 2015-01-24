<?php session_start(); 
	//Turn on error reporting
	ini_set('display_errors', 'On');
	
	// 1. Connect to Database
// 	$mysqli = new mysqli("oniddb.cws.oregonstate.edu", "phommata-db", "Lm0QgLxFUbJHtq2D", "phommata-db");
// 	
// 	if($mysqli->connect_errno){
// 		echo "Failed to connect to MySQL: (" .$mysqli->connect_errno. ")" .$mysqli->connect_error;
// 	}
	require "./db_connect.php";
	require "./navigation.php";

	$user_message = "";

echo <<<_END

_END;

	// 2. Prepare/Bind/Execute Form input into database  
	
	if($_SERVER['REQUEST_METHOD'] == "POST"){
		if(isset($_POST['username'], $_POST['password'])){
			$username = $_POST['username'];  
			$password = $_POST['password'];  
			
			$cu_stmt = $mysqli->prepare("SELECT user_id, pass, first_name FROM usr_db 
										WHERE username = ?");
			
			$id = "";
			$result = "";
							
			$cu_stmt->bind_param("s", $username);
			$cu_stmt->bind_result($id, $result, $first_name);
			
			$cu_stmt->execute();
			
			$cu_stmt->fetch();
			
			$cu_stmt->close();
							
			if($password == $result) {
				$mysqli->close();
				$user_message = "username & pass good";
				
				$_SESSION['logged_in_status'] = true;
				$_SESSION['username'] = $username; 
				$_SESSION['first_name'] = $first_name; 
				
				header("Location: homepage.php");
				exit();
			} else if($result) {
				$user_message = "Incorrect Login";
				$_SESSION['first_name'] = NULL;
				$_SESSION['logged_in_status'] = false;
			} 
		}
	}
	
	$mysqli->close();
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN">
<html>
	<link rel="stylesheet" href="stylesheets/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="stylesheets/bootstrap/css/bootstrap-theme.min.css">
	<link rel="stylesheet" href="stylesheets/bootstrap/css/docs.min.css">
	<link rel="stylesheet" href="stylesheets/bootstrap/css/signin.css">

<body>
<div class="container">
<h3><?php echo $user_message; ?></h3>
<form class="form-signin" action="login2.php" method = "POST">
	<div>
		Username:
		<input type="text" name="username">
	</div>
	<div>
		Password:
		<input type="password" name="password">
	</div>
	<div>
		<input type="submit" value="Submit">
	</div>
</form>

</div>
</body>
</html>