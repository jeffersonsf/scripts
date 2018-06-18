#!/bin/bash
Menu(){
	echo "";
	echo "[ 0 ] Para verificar todos os serviços instalados em todas as máquinas: ";
	echo "[ 1 ] Para verificar um serviço especifico em todas as máquinas: ";
	echo "[ 3 ] Sair";
	echo "";
	echo " Qual a opçpção desejada: ";
	read opcao;
	case $opcao in
		0)TodosSer ;;
		1)UmSerTodas ;;
		3)Sair ;;
		*) echo "Opcao desconhecida." ; echo ; Menu ;

	esac
}
TodosSer(){
echo -e "";
##Utilizando o hosts cadastrados dentro do arquivo /etc/hosts, realiza a verificação dos serviços summit
for i in $(cat /etc/hosts | awk '{print $2}' | egrep -v '^$'| grep -v 'localhost'); 
do
	echo "";
	echo "Servidor: $i"; 
	ssh $i "ls -l /opt/sn |awk '{print \$9}'|egrep [1-9]";
done
Menu;
}
UmSerTodas(){
	echo "Qual serviço você quer verificar?";
	read service;
	echo -e "";
##Utilizando o hosts cadastrados dentro do arquivo /etc/hosts, realiza a verificação dos serviços summit
for i in $(cat /etc/hosts | awk '{print $2}' | egrep -v '^$'| grep -v 'localhost'); 
do
	echo "";
	echo "Servidor: $i"; 
	ssh $i "ls -l /opt/sn |awk '{print \$9}'|egrep "[1-9]"| grep -i '$service'";
done
Menu;
}
Sair(){
	exit;
}
Menu;
