#!/bin/bash
cd /rislab;
##Elimina arquivos
##Lista somente diretórios
for t in $(ls -ld */ | awk '{print $9}' | sed 's#/##g') 
do 
##Remover de dentro dos diretorios dos clientes
##Lista somente arquivos
	cd /rislab/$t
	for i in $(ls -l | egrep -v '^d|total' | awk '{print $9}')
	do
		rm -f $i;
	done 
done
cd /rislab;

host="";
user="";
pass=""; 
ftp -n $host << END_SCRIPT
quote USER $user
quote PASS $pass
prompt
mget *
mdelete *
quit
END_SCRIPT
##Lista somente diretórios
for t in $(ls -ld */ | awk '{print $9}' | sed 's#/##g') 
do 
##Lista somente arquivos
	for i in $(ls -l | egrep -v '^d|total' | awk '{print $9}')
	do
		cp -nr $i $t;
	done 
done
#Elimina arquivos temporarios
for i in $(ls -l | egrep -v '^d|total' | awk '{print $9}')
	do
		rm -f $i;
done
