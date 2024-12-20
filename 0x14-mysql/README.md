# 0x14. MySQL

DevOps, SysAdmin, MySQL

### Concepts

_For this project, we expect you to look at these concepts:_

-   [[How to : ] Fresh Reset and Install mysql 5.7](https://intranet.alxswe.com/concepts/100002)
# [How to : ] Fresh Reset and Install mysql 5.7

⚠️  **Before going through the guide try this command if it gonna install MySQL 5.7 correctly, when you see the white windows you can jump to step 9, and see what to choose :**

```
 sudo wget -O mysql57 https://raw.githubusercontent.com/nuuxcode/alx-system_engineering-devops/master/scripts/mysql57 && sudo chmod +x mysql57 &&  sudo ./mysql57

```

If this command did not install 5.7 correctly you can continue reading the following guide.

**NOTE AS YOU PROCEED: At any point in this guide, don’t go to the next step if you have errors in the current step you are in, make sure there are no errors.**

You can also use this guide for more visual and sample outputs :

##### [For a comprehensive Guide Click Here 📄](https://docs.google.com/document/d/1btVRofXP75Cj90_xq2x8AmzuMPOKq6D_Dt_SCDD6GrU/edit?usp=sharing "For a comprehensive Guide Click Here 📄 ")

### STEPS :

1.  **Clean Running MySQL Processes :**
    
    -   Check for any running MYSQL Processes:  **`sudo ps aux | grep mysql`**
    -   If MySQL is running,try stopping it :  **`sudo service mysql stop`**
    -   Double-check if MySQL is no longer running:  **`sudo ps aux | grep mysql`**
    -   If MySQL processes are still running, terminate them, remember to replace PID with the value of your PID :  **`sudo kill -9 <PID>`**  
        
2.  **Remove Existing MySQL Versions:**
    
    -   Remove MySQL packages  **`sudo apt-get remove --purge mysql-server mysql-client mysql-common -y && sudo apt-get autoremove -y`**  
        
    -   If no errors occurs, proceed to next steps
    -   If prompted by a dialog to remove data directories, please select  `YES`  and press Enter.
3.  **Remove MySQL Apt Configurations :**
    
    -   Running the following :::
    -   **`sudo rm -rf /etc/apt/sources.list.d/mysql.list*`**
    -   **`sudo rm -rf /var/lib/mysql-apt-config`**
    -   **`sudo dpkg --purge mysql-apt-config`**
4.  **Double Check and Remove Configuration File**
    
    -   Check by running :  **`dpkg -l | grep mysql`**
    -   The result from above should be none, on your terminal
    -   Now, Remove configurations files by :  **`sudo rm -rf /etc/mysql /var/lib/mysql`**
5.  **Edit sources.list to Remove MySQL Repositories :**
    
    -   Check the sources.list file for  `MySQL`  repository entries (example: deb https://repo.mysql.com/apt/ubuntu bionic main), there should be none like the picture below:
6.  **Update the packages :**
    
    -   Check the sources.list file for  `MySQL`  repository entries (example: deb http://repo.mysql.com/apt/ubuntu bionic main),
    -   Run :  **`cat /etc/apt/sources.list | grep mysql`**
    -   there should be none like the picture below:
    -   If there are entries, open the sources.list file:  **`sudo vi /etc/apt/sources.list`**
    -   If no errors occur, proceed to the next step.
    -   Update the package by running :**  `sudo apt update`**
    -   Kill any running processses  `ps aux | grep apt`
7.  **Clean APT Cache :**
    
    -   Run :  **`sudo apt clean`**
8.  **Configure any Pending Packages and Install MySQL :**
    
    -   Run :  
        `sudo dpkg --configure -a`
    -   Install MySQL by running : **  `sudo wget -O mysql57 https://raw.githubusercontent.com/nuuxcode/alx-system_engineering-devops/master/scripts/mysql57 && sudo chmod +x mysql57 && sudo ./mysql57`**
    -   A few windows are going to show up, Follow the prompts to select Ubuntu Bionic, change to MySQL 5.7 and set a password if needed.  
        
    -   After installation, check MySQL status:  **`sudo service mysql status`**  *

#### If issues persist, use the following commands to debug :

-   **`journalctl -u mysql.service`**
-   **`cat /var/log/mysql/error.log`**
-   **`journalctl -xe`**

#### Check this post o learn more about MySQL

**`https://shazaali.substack.com/p/database-administration`**
-   [Database administration](https://intranet.alxswe.com/concepts/49)
# Database administration

-   [What is a database](https://www.techtarget.com/searchdatamanagement/definition/database "What is a database")
-   [What is a database primary/replicate cluster](https://www.digitalocean.com/community/tutorials/how-to-choose-a-redundancy-plan-to-ensure-high-availability#sql-replication "What is a database primary/replicate cluster")
-   [MySQL primary/replicate setup](https://www.digitalocean.com/community/tutorials/how-to-set-up-replication-in-mysql "MySQL primary/replicate setup")
-   [Build a robust database backup strategy](https://www.databasejournal.com/ms-sql/developing-a-sql-server-backup-strategy/ "Build a robust database backup strategy")
-   [Web stack debugging](https://intranet.alxswe.com/concepts/68)
# Web stack debugging

  

  

# Intro

  

  

Debugging usually takes a big chunk of a software engineer’s time. The art of debugging is tough and it takes years, even decades to master, and that is why seasoned software engineers are the best at it… experience. They have seen lots of broken code, buggy systems, weird edge cases and race conditions.

  

  

![](https://s3.amazonaws.com/alx-intranet.hbtn.io/uploads/medias/2020/9/45dffb0b1da8dc2ce47e340d7f88b05652c0f486.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARDDGGGOUSBVO6H7D%2F20240513%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240513T120220Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=ab1eec4a1a7dee0a5c65b90e21df1ad3ddf6e394693d595ef57117603afe39df)

  

  

# Non-exhaustive guide to debugging

  

  

## School specific

  

  

If you are struggling to get something right that is run on the checker, like a Bash script or a piece of code, keep in mind that you can simulate the flow by starting a Docker container with the distribution that is specified in the requirements and by running your code. Check the **Docker** concept page for more info.

  

  

## Test and verify your assumptions

  

  

The idea is to ask a set of questions until you find the issue. For example, if you installed a web server and it isn’t serving a page when browsing the IP, here are some questions you can ask yourself to start debugging:

  

  

- Is the web server started? - You can check using the service manager, also double check by checking process list.

  

- On what port should it listen? - Check your web server configuration

  

- Is it actually listening on this port? - `netstat -lpdn` - run as `root` or `sudo` so that you can see the process for each listening port

  

- It is listening on the correct server IP? - `netstat` is also your friend here

  

- Is there a firewall enabled?

  

- Have you looked at logs? - usually in `/var/log` and `tail -f` is your friend

  

- Can I connect to the HTTP port from the location I am browsing from? - `curl` is your friend

  

  

There is a good chance that at this point you will already have found part of the issue.

  

  

## Get a quick overview of the machine state

  

  

[Youtube video First 5 Commands When I Connect on a Linux Server](https://www.youtube.com/watch?v=1_gqlbADaAw&feature=youtu.be  "Youtube video First 5 Commands When I Connect on a Linux Server")

  

  

When you connect to a server/machine/computer/container you want to understand what’s happened recently and what’s happening now, and you can do this with [5 commands](https://www.linux.com/training-tutorials/first-5-commands-when-i-connect-linux-server/  "5 commands") in a minute or less:

  

  

###  `w`

  

  

- shows server [uptime](https://www.techtarget.com/whatis/definition/uptime-and-downtime  "uptime") which is the time during which the server has been continuously running

  

- shows which users are connected to the server

  

- load average will give you a good sense of the server health - (read more about load [here](https://scoutapm.com/blog/understanding-load-averages  "here") and [here](https://www.brendangregg.com/blog/2017-08-08/linux-load-averages.html  "here"))

  

  

###  `history`

  

  

- shows which commands were previously run by the user you are currently connected to

  

- you can learn a lot about what type of work was previously performed on the machine, and what could have gone wrong with it

  

- where you might want to start your debugging work

  

  

###  `top`

  

  

- shows what is currently running on this server

  

- order results by CPU, memory utilization and catch the ones that are resource intensive

  

  

###  `df`

  

  

- shows disk utilization

  

  

###  `netstat`

  

  

- what port and IP your server is listening on

  

- what processes are using sockets

  

- try `netstat -lpn` on a Ubuntu machine

  

  

## Machine

  

  

Debugging is pretty much about verifying assumptions, in a perfect world the software or system we are working on would be working perfectly, the server is in perfect shape and everybody is happy. But actually, it NEVER goes this way, things ALWAYS fail (it’s tremendous!).

  

  

For the machine level, you want to ask yourself these questions:

  

  

- Does the server have free disk space? - `df`

  

- Is the server able to keep up with CPU load? - `w`, `top`, `ps`

  

- Does the server have available memory? `free`

  

- Are the server disk(s) able to keep up with read/write IO? - `htop`

  

  

If the answer is **no** for any of these questions, then that might be the reason why things are not going as expected. There are often 3 ways of solving the issue:

  

  

- free up resources (stop process(es) or reduce their resource consumption)

  

- increase the machine resources (adding memory, CPU, disk space…)

  

- distributing the resource usage to other machines

  

  

## Network issue

  

  

For the machine level, you want to ask yourself these questions:

  

  

- Does the server have the expected network interfaces and IPs up and running? `ifconfig`

  

- Does the server listen on the sockets that it is supposed to? `netstat` (`netstat -lpd` or `netstat -lpn`)

  

- Can you connect from the location you want to connect from, to the socket you want to connect to? `telnet` to the IP + PORT (`telnet 8.8.8.8 80`)

  

- Does the server have the correct firewall rules? `iptables`, `ufw`:

  

-  `iptables -L`

  

-  `sudo ufw status`

  

  

## Process issue

  

  

If a piece of Software isn’t behaving as expected, it can obviously be because of above reasons… but the good news is that there is more to look into (there is ALWAYS more to look into actually).

  

  

- Is the software started? `init`, `init.d`:

  

-  `service NAME_OF_THE_SERVICE status`

  

-  `/etc/init.d/NAME_OF_THE_SERVICE status`

  

- Is the software process running? `pgrep`, `ps`:

  

-  `pgrep -lf NAME_OF_THE_PROCESS`

  

-  `ps auxf`

  

- Is there anything interesting in the logs? look for log files in `/var/log/` and `tail -f` is your friend

  

  

## Debugging is fun

  

  

Debugging can be frustrating, but it will definitely be part of your job, it requires experience and methodology to become good at it. The good news is that bugs are never going away, and the more experienced you become, trickier bugs will be assigned to you! Good luck :)

  

  

![](https://s3.amazonaws.com/alx-intranet.hbtn.io/uploads/medias/2020/9/bae58c9f066a9668001ef4b4c39778407439d2f9.gif?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARDDGGGOUSBVO6H7D%2F20240513%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240513T120220Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=c79c20ac24df0e7e908bf52edfc99f2f6575b93d49a8816edcf9cb823f489e5c)

![](https://s3.amazonaws.com/intranet-projects-files/holbertonschool-sysadmin_devops/280/KkrkDHT.png)

## Resources

**Read or watch**:

-   [What is a primary-replica cluster](https://www.digitalocean.com/community/tutorials/how-to-choose-a-redundancy-plan-to-ensure-high-availability#sql-replication "What is a primary-replica cluster")
-   [MySQL primary replica setup](https://www.digitalocean.com/community/tutorials/how-to-set-up-replication-in-mysql "MySQL primary replica setup")
-   [Build a robust database backup strategy](https://www.databasejournal.com/ms-sql/developing-a-sql-server-backup-strategy/ "Build a robust database backup strategy")

**man or help**:

-   `mysqldump`

## Learning Objectives

At the end of this project, you are expected to be able to  [explain to anyone](https://intranet.alxswe.com/rltoken/Lotf0yqq3mNeFHkrW67CZQ "explain to anyone"),  **without the help of Google**:

### General

-   What is the main role of a database
-   What is a database replica
-   What is the purpose of a database replica
-   Why database backups need to be stored in different physical locations
-   What operation should you regularly perform to make sure that your database backup strategy actually works

## Requirements

### General

-   Allowed editors:  `vi`,  `vim`,  `emacs`
-   All your files will be interpreted on Ubuntu 16.04 LTS
-   All your files should end with a new line
-   A  `README.md`  file, at the root of the folder of the project, is mandatory
-   All your Bash script files must be executable
-   Your Bash script must pass  `Shellcheck`  (version  `0.3.7-5~ubuntu16.04.1`  via  `apt-get`) without any error
-   The first line of all your Bash scripts should be exactly  `#!/usr/bin/env bash`
-   The second line of all your Bash scripts should be a comment explaining what is the script doing

## Your servers


Name: 530478-web-01

Username: `ubuntu`

IP: `52.91.126.218`

State: running

Actions Toggle Dropdown

Name: 530478-web-02

Username: `ubuntu`

IP: `54.89.178.237`

State: running

Actions Toggle Dropdown

Name: 530478-lb-01

Username: `ubuntu`

IP: `54.175.101.81`

State: running

Actions Toggle Dropdown

## Tasks

### 0. Install MySQL

mandatory

First things first, let’s get MySQL installed on  **both**  your web-01 and web-02 servers.

-   MySQL distribution must be 5.7.x
-   Make sure that  {[task #3](https://intranet.alxswe.com/rltoken/h8QknQcmmLf7oT8esoWgvg "task #3")  [task #3](https://intranet.alxswe.com/tasks/1372)} : {Task ### 3. Let me in!} of your  [SSH project](https://github.com/OluTshegz/alx-system_engineering-devops/tree/master/0x0B-ssh "SSH project")  is completed for  `web-01`  and  `web-02`. The checker will connect to your servers to check MySQL status
-   Please make sure you have your  `README.md`  pushed to GitHub.

Example:

```
ubuntu@229-web-01:~$ mysql --version
mysql  Ver 14.14 Distrib 5.7.25, for Linux (x86_64) using  EditLine wrapper
ubuntu@229-web-01:~$

```

**Repo:**

-   GitHub repository:  `alx-system_engineering-devops`
-   Directory:  `0x14-mysql`

Done?  Check your code  Get a sandbox

### 1. Let us in!

mandatory

In order for us to verify that your servers are properly configured, we need you to create a user and password for  **both**  MySQL databases which will allow the checker access to them.

-   Create a MySQL user named  `holberton_user`  on both  `web-01`  and  `web-02`  with the host name set to  `localhost`  and the password  `projectcorrection280hbtn`. This will allow us to access the replication status on both servers.
-   Make sure that  `holberton_user`  has permission to check the primary/replica status of your databases.
-   In addition to that, make sure that  [task #3](https://intranet.alxswe.com/rltoken/h8QknQcmmLf7oT8esoWgvg "task #3")  of your  [SSH project](https://intranet.alxswe.com/rltoken/Wx_BrR5Sk8s3Ywl44-33wg "SSH project")  is completed for  `web-01`  and  `web-02`.  **You will likely need to add the public key to web-02 as you only added it to web-01 for this project.**  The checker will connect to your servers to check MySQL status

Example:

```
ubuntu@229-web-01:~$ mysql -uholberton_user -p -e "SHOW GRANTS FOR 'holberton_user'@'localhost'"
Enter password:
+-----------------------------------------------------------------+
| Grants for holberton_user@localhost                             |
+-----------------------------------------------------------------+
| GRANT REPLICATION CLIENT ON *.* TO 'holberton_user'@'localhost' |
+-----------------------------------------------------------------+
ubuntu@229-web-01:~$

```

**Repo:**

-   GitHub repository:  `alx-system_engineering-devops`
-   Directory:  `0x14-mysql`

Done?  Check your code  Get a sandbox

### 2. If only you could see what I've seen with your eyes

mandatory

In order for you to set up replication, you’ll need to have a database with at least one table and one row in your primary MySQL server (web-01) to replicate from.

-   Create a database named  `tyrell_corp`.
-   Within the  `tyrell_corp`  database create a table named  `nexus6`  and add at least one entry to it.
-   Make sure that  `holberton_user`  has  `SELECT`  permissions on your table so that we can check that the table exists and is not empty.

```
ubuntu@229-web-01:~$ mysql -uholberton_user -p -e "use tyrell_corp; select * from nexus6"
Enter password:
+----+-------+
| id | name  |
+----+-------+
|  1 | Leon  |
+----+-------+
ubuntu@229-web-01:~$

```

**Repo:**

-   GitHub repository:  `alx-system_engineering-devops`
-   Directory:  `0x14-mysql`

Done?  Check your code  Get a sandbox

### 3. Quite an experience to live in fear, isn't it?

mandatory

Before you get started with your primary-replica synchronization, you need one more thing in place. On your  **primary**  MySQL server (web-01), create a new user for the replica server.

-   The name of the new user should be  `replica_user`, with the host name set to  `%`, and can have whatever password you’d like.
-   `replica_user`  must have the appropriate permissions to replicate your primary MySQL server.
-   `holberton_user`  will need SELECT privileges on the  `mysql.user`  table in order to check that  `replica_user`  was created with the correct permissions.

```
ubuntu@229-web-01:~$ mysql -uholberton_user -p -e 'SELECT user, Repl_slave_priv FROM mysql.user'
+------------------+-----------------+
| user             | Repl_slave_priv |
+------------------+-----------------+
| root             | Y               |
| mysql.session    | N               |
| mysql.sys        | N               |
| debian-sys-maint | Y               |
| holberton_user   | N               |
| replica_user     | Y               |
+------------------+-----------------+
ubuntu@229-web-01:~$

```

**Repo:**

-   GitHub repository:  `alx-system_engineering-devops`
-   Directory:  `0x14-mysql`

Done?  Check your code  Get a sandbox

### 4. Setup a Primary-Replica infrastructure using MySQL

mandatory

![](https://s3.amazonaws.com/alx-intranet.hbtn.io/uploads/medias/2020/9/09e83e914f0d6865ce320a47f2f14837a5b190b6.gif?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARDDGGGOUSBVO6H7D%2F20240514%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240514T141441Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=94d1f21f7b9331852260671ebb6c405fa6f3cca97b81e1bbb1ebf47e0c6b5198)

Having a replica member on for your MySQL database has 2 advantages:

-   Redundancy: If you lose one of the database servers, you will still have another working one and a copy of your data
-   Load distribution: You can split the read operations between the 2 servers, reducing the load on the primary member and improving query response speed

### Requirements:

-   MySQL primary must be hosted on  `web-01`  - do not use the  `bind-address`, just comment out this parameter
-   MySQL replica must be hosted on  `web-02`
-   Setup replication for the MySQL database named  `tyrell_corp`
-   Provide your MySQL primary configuration as answer file(`my.cnf`  or  `mysqld.cnf`) with the name  `4-mysql_configuration_primary`
-   Provide your MySQL replica configuration as an answer file with the name  `4-mysql_configuration_replica`

### Tips:

-   Once MySQL replication is setup, add a new record in your table via MySQL on  `web-01`  and check if the record has been replicated in MySQL  `web-02`. If you see it, it means your replication is working!
-   **Make sure that UFW is allowing connections on port 3306 (default MySQL port) otherwise replication will not work**.

Example:

## `web-01`

```
ubuntu@web-01:~$ mysql -uholberton_user -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 1467
Server version: 5.5.49-0ubuntu0.14.04.1-log (Ubuntu)

Copyright (c) 2000, 2016, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show master status;
+------------------+----------+--------------------+------------------+
| File             | Position | Binlog_Do_DB       | Binlog_Ignore_DB |
+------------------+----------+--------------------+------------------+
| mysql-bin.000009 |      107 | tyrell_corp          |                  |
+------------------+----------+--------------------+------------------+
1 row in set (0.00 sec)

mysql> 

```

## `web-02`

```
root@web-02:/home/ubuntu# mysql -uholberton_user -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 53
Server version: 5.5.49-0ubuntu0.14.04.1-log (Ubuntu)

Copyright (c) 2000, 2016, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show slave status\G
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 158.69.68.78
                  Master_User: replica_user
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000009
          Read_Master_Log_Pos: 107
               Relay_Log_File: mysql-relay-bin.000022
                Relay_Log_Pos: 253
        Relay_Master_Log_File: mysql-bin.000009
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
           Replicate_Do_Table: 
       Replicate_Ignore_Table: 
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 0
                   Last_Error: 
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 107
              Relay_Log_Space: 452
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: 0
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 1
1 row in set (0.00 sec)

mysql> 


```

**Repo:**

-   GitHub repository:  `alx-system_engineering-devops`
-   Directory:  `0x14-mysql`
-   File:  `4-mysql_configuration_primary, 4-mysql_configuration_replica`

Done?  Check your code  Get a sandbox

### 5. MySQL backup

mandatory

[![](https://s3.amazonaws.com/intranet-projects-files/holbertonschool-sysadmin_devops/280/Bbpsgif.jpg)](https://www.youtube.com/watch?v=ANU-oSE5_hU)

What if the data center where both your primary and replica database servers are hosted are down because of a power outage or even worse: flooding, fire? Then all your data would inaccessible or lost. That’s why you want to backup and store them in a different system in another physical location. This can be achieved by dumping your MySQL data, compressing them and storing them in a different data center.

Write a Bash script that generates a MySQL dump and creates a compressed archive out of it.

Requirements:

-   The MySQL dump must contain all your MySQL databases
-   The MySQL dump must be named  `backup.sql`
-   The MySQL dump file has to be compressed to a  `tar.gz`  archive
-   This archive must have the following name format:  `day-month-year.tar.gz`
-   The user to connect to the MySQL database must be  `root`
-   The Bash script accepts one argument that is the password used to connect to the MySQL database

Example:

```
ubuntu@03-web-01:~$ ls
5-mysql_backup
ubuntu@03-web-01:~$ ./5-mysql_backup mydummypassword
backup.sql
ubuntu@03-web-01:~$ ls
01-03-2017.tar.gz  5-mysql_backup  backup.sql
ubuntu@03-web-01:~$ more backup.sql
-- MySQL dump 10.13  Distrib 5.7.25, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database:
-- ------------------------------------------------------
-- Server version   5.7.25-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `tyrell_corp`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tyrell_corp` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `tyrell_corp`;

--
-- Table structure for table `nexus6`
--

DROP TABLE IF EXISTS `nexus6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nexus6` (
  `id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
ubuntu@03-web-01:~$
ubuntu@03-web-01:~$ file 01-03-2017.tar.gz
01-03-2017.tar.gz: gzip compressed data, from Unix, last modified: Wed Mar  1 23:38:09 2017
ubuntu@03-web-01:~$

```

**Repo:**

-   GitHub repository:  `alx-system_engineering-devops`
-   Directory:  `0x14-mysql`
-   File:  `5-mysql_backup`

Done?  Check your code  Get a sandbox
