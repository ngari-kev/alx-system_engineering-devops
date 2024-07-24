# MYSQL 5.7 INSTALLATION

I had to make sure that the ssh key for the checker was added to authorized keys on both servers

Should you want to install mysql 5.7, click [here](https://docs.google.com/document/d/1btVRofXP75Cj90_xq2x8AmzuMPOKq6D_Dt_SCDD6GrU/edit#heading=h.nu0sqigqw1o9) and follow the prompts.

## Tasks

### Task 0

Install mysql 5.7 on `web_01` and `web_02`

# THE PROCESS OF CREATING A PRIMARY REPLICA SETUP.

The following commands are to be run in both web_01 and web_02:

- CREATE USER 'holberton_user'@'localhost' IDENTIFIED BY 'projectcorrection280hbtn';
- GRANT REPLICATION CLIENT ON \*.* TO 'holberton_user'@'localhost';
- FLUSH PRIVILEGES;

To confirm that the above has taken effect;

- SHOW GRANTS FOR 'holberton_user'@'localhost';

``` mysql
+-----------------------------------------------------------------+
| Grants for holberton_user@localhost                             |
+-----------------------------------------------------------------+
| GRANT REPLICATION CLIENT ON *.* TO 'holberton_user'@'localhost' |
+-----------------------------------------------------------------+
```

- CREATE DATABASE tyrell_corp;
- USE tyrell_corp;
- CREATE TABLE nexus6 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);
- INSERT INTO nexus6 (name) VALUES ("Leon");
- GRANT SELECT ON tyrell_corp.nexus6 TO 'holberton_user'@'localhost';
- FLUSH PRIVILEGES;

On web_01 only:

- CREATE USER 'replica_user'@'%" IDENTIFIED BY 'anypassword';
- GRANT REPLICATION SLAVE ON \*.* TO 'replica_user'@'%';
- GRANT SELECT ON mysql.user TO 'holberton_user'@'localhost';
- FLUSH PRIVILEGES;

Still on web_01, open the mysql config file.

``` bash
sudo vim /etc/mysql/mysql.conf.d/mysqld.cnf
```

- comment out bind address. i.e. prepend # on the line.
- Add:
  - server_id = 1
  - log_bin = /var/log/mysql/mysql-bin.log

- Restart mysql

``` bash
sudo service mysql restart
```

Run mysql again in interactive mode and run this command:

``` mysql
SHOW MASTER STATUS;
```

```
+------------------+----------+--------------+------------------+-------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
+------------------+----------+--------------+------------------+-------------------+
| mysql-bin.000005 |      154 | tyrell_corp  |                  |                   |
+------------------+----------+--------------+------------------+-------------------+
```

Take note of the values under `FIle` and `Position`. You can copy and paste them on a notepad for easier retrieval later.

At this point, we are done with `web_01`.

In web_02;

Open the mysql config file. (same as you did in `web_01`).

Add the following lines to the contents:

- server_id = 2
- log_bin         = /var/log/mysql/mysql-bin.log
- binlog_do_db    = tyrell_corp
- relay-log       = /var/log/mysql/mysql-relay-bin.log

Restart mysql

``` bash
sudo service mysql restart
```

In mysql interactive mode, run the command below:

``` mysql
CHANGE MASTER TO MASTER_HOST = 'web_01_ip_address', MASTER_USER = 'replica_user', MASTER_PASSWORD = 'password you set earlier for replica user', MASTER_LOG_FILE = 'entry under File that you copied earlier from web_01', MASTER_LOG_POS = 'entry under position copied earlier from web_01';

START SLAVE;

SHOW SLAVE STATUS\G;
```

In the output resulting from last command, make sure that `slave IO running` and `slave SQL running` have the value `Yes`.

Also, if you have a firewall, make sure that you allow port 3306 (default SQL port) or else your replication won't work.

In my case, I am running ufw firewall (uncomplicated firewall - usually ran on Ubuntu and other Linux Distros) so I ran the command:

``` bash
sudo ufw allow 3306
```

All done. You should be able to enter data into the primary mysql server and it will be found automatically in the replica.