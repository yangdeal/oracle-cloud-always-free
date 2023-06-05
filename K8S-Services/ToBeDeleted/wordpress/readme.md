# Create DB
Database "wordpress" need to be created before wordpress can start.

```bash
k run mysql-client --image=mysql -it --rm --restart=Never -- /bin/bash

#Below inside container
bash-4.4# mysql -h wordpress-mysql -uroot -p -e 'create database wordpress; SHOW databases;'
```