#!/bin/sh

MYSQL="mysql -h mysql -P 3306 -u root"

echo "DROP DATABASE IF EXISTS zoterotest1" | $MYSQL
echo "DROP DATABASE IF EXISTS zoterotest2" | $MYSQL
echo "DROP DATABASE IF EXISTS zoterotest_master" | $MYSQL
echo "DROP DATABASE IF EXISTS zoterotest_ids" | $MYSQL
echo "DROP DATABASE IF EXISTS zotero_www_test" | $MYSQL

echo "CREATE DATABASE zoterotest_master" | $MYSQL
echo "CREATE DATABASE zoterotest1" | $MYSQL
echo "CREATE DATABASE zoterotest2" | $MYSQL
echo "CREATE DATABASE zoterotest_ids" | $MYSQL
echo "CREATE DATABASE zotero_www_test" | $MYSQL

echo "DROP USER zoterotest0@localhost;" | $MYSQL
echo "DROP USER zoterotest1@localhost;" | $MYSQL
echo "DROP USER zoterotest2@localhost;" | $MYSQL
echo "DROP USER zoterotest_ids@localhost;" | $MYSQL
echo "DROP USER zoterotest_www@localhost;" | $MYSQL

echo "CREATE USER zoterotest0@localhost IDENTIFIED BY 'pass0';" | $MYSQL
echo "CREATE USER zoterotest1@localhost IDENTIFIED BY 'pass1';" | $MYSQL
echo "CREATE USER zoterotest2@localhost IDENTIFIED BY 'pass2';" | $MYSQL
echo "CREATE USER zoterotest_ids@localhost IDENTIFIED BY 'pass1';" | $MYSQL
echo "CREATE USER zoterotest_www@localhost IDENTIFIED BY 'pass';" | $MYSQL

echo "GRANT SELECT, INSERT, UPDATE, DELETE ON zoterotest_master.* TO zoterotest0@localhost;" | $MYSQL
echo "GRANT SELECT ON zoterotest_master.* TO zoterotest1@localhost;" | $MYSQL
echo "GRANT SELECT ON zoterotest_master.* TO zoterotest2@localhost;" | $MYSQL
echo "GRANT SELECT, INSERT, UPDATE, DELETE ON zoterotest1.* TO zoterotest1@localhost;" | $MYSQL
echo "GRANT SELECT, INSERT, UPDATE, DELETE ON zoterotest2.* TO zoterotest2@localhost;" | $MYSQL
echo "GRANT SELECT, INSERT, DELETE ON zoterotest_ids.* TO zoterotest_ids@localhost;" | $MYSQL
echo "GRANT SELECT ON zotero_www_test.* TO zoterotest_www@localhost;" | $MYSQL

# Load in master schema
$MYSQL zoterotest_master < master.sql
$MYSQL zoterotest_master < coredata.sql

# Set up shard info
echo "INSERT INTO shardHosts VALUES (1, 'mysql', 3306, 'up');" | $MYSQL zoterotest_master
echo "INSERT INTO shards VALUES (1, 1, 'zoterotest1', 'up', '1');" | $MYSQL zoterotest_master
echo "INSERT INTO shards VALUES (2, 1, 'zoterotest2', 'up', '1');" | $MYSQL zoterotest_master

# Initial users and groups for tests
echo "INSERT INTO libraries VALUES (1, 'user', '0000-00-00 00:00:00', 0, 1)" | $MYSQL zoterotest_master
echo "INSERT INTO libraries VALUES (2, 'user', '0000-00-00 00:00:00', 0, 1)" | $MYSQL zoterotest_master
echo "INSERT INTO libraries VALUES (3, 'group', '0000-00-00 00:00:00', 0, 2)" | $MYSQL zoterotest_master
echo "INSERT INTO users VALUES (1, 1, 'testuser', '0000-00-00 00:00:00', '0000-00-00 00:00:00')" | $MYSQL zoterotest_master
echo "INSERT INTO users VALUES (2, 2, 'testuser2', '0000-00-00 00:00:00', '0000-00-00 00:00:00')" | $MYSQL zoterotest_master
echo "INSERT INTO groups VALUES (1, 3, 'Test Group', 'test_group', 'Private', 'admins', 'all', 'members', '', '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1)" | $MYSQL zoterotest_master
echo "INSERT INTO groupUsers VALUES (1, 1, 'owner', '0000-00-00 00:00:00', '0000-00-00 00:00:00')" | $MYSQL zoterotest_master

# Load in www schema
$MYSQL zotero_www_test < www.sql

# b7a875fc1ea228b9061041b7cec4bd3c52ab3ce3 equals to 'letmein'
echo "INSERT INTO users VALUES (1, 'testuser', 'b7a875fc1ea228b9061041b7cec4bd3c52ab3ce3')" | $MYSQL zotero_www_test
echo "INSERT INTO users_email (id, userID, institutionID, email) VALUES (0, 1, 'test@test.com')" | $MYSQL zotero_www_test
echo "INSERT INTO storage_institutions (institutionID, domain, storageQuota) VALUES (1, 'test.com', 300)" | $MYSQL zotero_www_test
echo "INSERT INTO storage_institution_email (id, email) VALUES (1, 'test@test.com')" | $MYSQL zotero_www_test

# Load in shard schema
cat shard.sql | $MYSQL zoterotest1
cat shard.sql | $MYSQL zoterotest2
cat triggers.sql | $MYSQL zoterotest1
cat triggers.sql | $MYSQL zoterotest2

echo "INSERT INTO shardLibraries VALUES (1, 'user', 0, 0)" | $MYSQL zoterotest1
echo "INSERT INTO shardLibraries VALUES (2, 'user', 0, 0)" | $MYSQL zoterotest1
echo "INSERT INTO shardLibraries VALUES (3, 'group', 0, 0)" | $MYSQL zoterotest2

# Load in schema on id servers
$MYSQL zoterotest_ids < ids.sql
