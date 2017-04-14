<?
function Zotero_dbConnectAuth($db) {
	$charset = '';
	
	if ($db == 'master') {
		$host = 'mysql';
		$port = 3306;
		$db = 'zoterotest_master';
		$user = 'root';
		$pass = '';
	}
	else if ($db == 'shard') {
		$host = 'mysql';
		$port = 3306;
		$db = 'zoterotest1';
		$user = 'root';
		$pass = '';
	}
	else if ($db == 'fulltext') {
		$host = 'mysql';
		$port = '';
		$db = false;
		$user = false;
		$pass = false;
		$charset = 'utf8mb4';
	}
	else if ($db == 'id1') {
		$host = 'mysql';
		$port = 3306;
		$db = 'zoterotest_ids';
		$user = 'root';
		$pass = '';
	}
	else if ($db == 'id2') {
		$host = 'mysql';
		$port = 3306;
		$db = 'zoterotest_ids';
		$user = 'root';
		$pass = '';
	}
	else if ($db == 'zotero_www_test') {
		$host = 'mysql';
		$port = 3306;
		$db = 'zotero_www_test';
		$user = 'root';
		$pass = '';
	}
	else if ($db == 'www2') {
		$host = 'mysql';
		$port = 3306;
		$db = 'www2';
		$user = 'root';
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
