<?php
//CONNECT
$mypassword = "RdNAmTfkrFADuWx1";
		$mysqli = new mysqli("oniddb.cws.oregonstate.edu", "osterbit-db", $mypassword, "osterbit-db");
		if ($mysqli->connect_errno) {
			echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
		}
		/*
		else {
			echo "connected";
		}
*/
?>
