<?
function Zotero_dbConnectAuth($db) {
	$charset = '';
	
	if ($db == 'master') {
		$host = '';
		$port = 3306;
		$db = '';
		$user = '';
		$pass = '';
	}
	else if ($db == 'shard') {
		$host = false;
		$port = false;
		$db = false;
		$user = '';
		$pass = '';
	}
	else if ($db == 'fulltext') {
		$host = '';
		$port = '';
		$db = false;
		$user = false;
		$pass = false;
		$charset = 'utf8mb4';
	}
	else if ($db == 'id1') {
		$host = '';
		$port = 3306;
		$db = 'ids';
		$user = '';
		$pass = '';
	}
	else if ($db == 'id2') {
		$host = '';
		$port = 3306;
		$db = 'ids';
		$user = '';
		$pass = '';
	}
	else if ($db == 'www1') {
		$host = '';
		$port = 3306;
		$db = 'www';
		$user = '';
		$pass = '';
	}
	else if ($db == 'www2') {
		$host = '';
		$port = 3306;
		$db = 'www';
		$user = '';
		$pass = '';
	}
	else {
		throw new Exception("Invalid db '$db'");
	}
	return array(
		'host' => $host,
		'port' => $port,
		'db' => $db,
		'user' => $user,
		'pass' => $pass,
		'charset' => $charset
	);
}
?>
