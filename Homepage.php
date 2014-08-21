<?php
//Turn on error reporting
ini_set('display_errors', 'On');
//Connects to the database
$mysqli = new mysqli("oniddb.cws.oregonstate.edu","phommata-db","Lm0QgLxFUbJHtq2D","phommata-db");
if($mysqli->connect_errno){
	echo "Connection error " . $mysqli->connect_errno . " " . $mysqli->connect_error;
	}
?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<body>
<div>
	Battlestar People</br></br>
</div>
<div>
	<table>
		<tr>
<!-- 			<td>Battlestar People</td> -->
		</tr>
		<tr>
			<td>Name</td>
			<td>Age</td>
			<td>Homeworld</td>
		</tr>
<div>
	<form method="post" action="filter.php">
		<fieldset>
			<legend>Filter By Planet</legend>
				<select name="Homeworld">
					<?php
					if(!($stmt = $mysqli->prepare("SELECT id, name FROM bsg_planets"))){
						echo "Prepare failed: "  . $stmt->errno . " " . $stmt->error;
					}

					if(!$stmt->execute()){
						echo "Execute failed: "  . $mysqli->connect_errno . " " . $mysqli->connect_error;
					}
					if(!$stmt->bind_result($id, $pname)){
						echo "Bind failed: "  . $mysqli->connect_errno . " " . $mysqli->connect_error;
					}
					while($stmt->fetch()){
					 echo '<option value=" '. $id . ' "> ' . $pname . '</option>\n';
					}
					$stmt->close();
					?>
				</select>
		</fieldset>
		<input type="submit" value="Run Filter" />
	</form>
</div>
		
<?php
if(!($stmt = $mysqli->prepare("SELECT bsg_people.fname, bsg_people.age, bsg_planets.name FROM bsg_people INNER JOIN bsg_planets ON bsg_people.homeworld = bsg_planets.id"))){
	echo "Prepare failed: "  . $stmt->errno . " " . $stmt->error;
}

if(!$stmt->execute()){
	echo "Execute failed: "  . $mysqli->connect_errno . " " . $mysqli->connect_error;
}
if(!$stmt->bind_result($name, $age, $homeworld)){
	echo "Bind failed: "  . $mysqli->connect_errno . " " . $mysqli->connect_error;
}
while($stmt->fetch()){
 echo "<tr>\n<td>\n" . $name . "\n</td>\n<td>\n" . $age . "\n</td>\n<td>\n" . $homeworld . "\n</td>\n</tr>";
}
$stmt->close();
?>
	</table>
</div>

<!-- 
<div>
	<form method="post" action="Homepage.html">
		<fieldset>
			<legend>Planet Name</legend>
			<p>Planet Name: <input type="text" name="PName" /></p>
		</fieldset>
		<fieldset>
			<legend>Planet Populations</legend>
			<p>Planet Population: <input type="text" name="PPopulation" /></p>
		</fieldset>
		<fieldset>
			<legend>Laguage</legend>
			<p>Official Language: <input type="text" name="PLanguage" /></p>
		</fieldset>
		<input type="submit" name="add" value="Add Planet" />
		<input type="submit" name="update" value="Update Planet" />
	</form>
</div>
 -->

</body>
</html>
