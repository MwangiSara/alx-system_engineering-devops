CREATE DATABASE IF NOT EXISTS 'tyrell_corp';
USE tyrell_corp;

CREATE TABLE IF NOT EXISTS nexus6 (id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, name VARCHAR(32) NOT NULL);
INSERT INTO nexus6 (id, name) VALUES (1, Leon);

CREATE USER 'holberton_user'@'localhost' IDENTIFIED BY 'projectcorrection280hbtn';
GRANT REPLICATION CLIENT ON *.* TO 'holberton_user'@'localhost';
GRANT SELECT ON tyrell_corp.nexus6 TO 'holberton_user'@'localhost';
GRANT SELECT ON mysql.user TO 'holberton_user'@'localhost';

CREATE USER 'replica_user'@'%' IDENTIFIED WITH mysql_native_password BY 'replica_password';
GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';

FLUSH PRIVILEGES;

SHOW MASTER STATUS;

CHANGE MASTER TO
->    MASTER_HOST='master_server_ip',
->    MASTER_USER='replica_user',
->    MASTER_PASSWORD='replica_password';

START SLAVE;
SHOW SLAVE STATUS\G
