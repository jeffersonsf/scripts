#!/bin/bash
cd /rislab;
host="";
user="200.236.217.186";
pass="rislab"; 
ftp -n $host << END_SCRIPT
quote USER $user
quote PASS $pass
prompt
mget*
quit
END_SCRIPT
##Lista usuarios e copia os arquivos necessarios em cada diretorio dos clientes
for t in $(ls -l /rislab | awk '{print $9}' | sed '1d'; 
do 
	cp * /rislab/$t;
done

