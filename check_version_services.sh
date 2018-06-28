#!/bin/bash
Menu(){
        echo "";
        echo "[ 0 ] Para verificar todos os serviços instalados em todas as máquinas: ";
        echo "[ 1 ] Para verificar um serviço especifico em todas as máquinas: ";
        echo "[ 2 ] Para atualizar um serviço especifico em todas as máquinas";
        echo "[ 3 ] Sair";
        echo "";
        read -p "Qual a opção desejada: " opcao;
        case $opcao in
                0)TodosSer ;;
                1)UmSerTodas ;;
		2)UpdateServ ;;
                3)Sair ;;
                *) echo "Opcao desconhecida." ; echo ; Menu ;
        esac
}
TodosSer(){
	echo -e "";
	##Utilizando o hosts cadastrados dentro do arquivo /etc/hosts, realiza a verificação dos serviços summit
	for i in $(cat /etc/hosts | awk '{print $2}' | egrep -v '^$'| egrep -v 'localhost|summit');
	do
        	echo "";
        	echo "Servidor: $i";
        	ssh $i "ls -l /opt/sn | grep '>'| awk '{print \$11}'|sed 's#/opt/sn/##g'";
	done
	Menu;
}
UmSerTodas(){
        read -p "Qual serviço você quer verificar? " service;
        echo -e "";
	##Utilizando o hosts cadastrados dentro do arquivo /etc/hosts, realiza a verificação dos serviços summit
	for i in $(cat /etc/hosts | awk '{print $2}' | egrep -v '^$'| egrep -v 'localhost|summit');
	do
        	echo "";
        	echo "Servidor: $i";
        	ssh $i "ls -l /opt/sn | grep '>' | awk '{print \$11}'| sed 's#/opt/sn/##g'|grep -i $service";
	done
	Menu;
}
UpdateServ(){
	read -p "Qual serviço você quer verificar? " service;
        echo -e "";
	##Utilizando o hosts cadastrados dentro do arquivo /etc/hosts, realiza a verificação dos serviços summit
	for i in $(cat /etc/hosts | awk '{print $2}' | egrep -v '^$'| egrep -v 'localhost|summit');
	do
        	echo "";
        	echo "Atualizando servidor: $i";
        	scp /tmp/bus-2.9.6279.734-x86_64-el6.pkg $i:/tmp;
        	ssh $i "cd /tmp; /opt/sn/inventory/install bus-2.9.6279.734-x86_64-el6.pkg; /opt/sn/inventory/activate bus 2.9.6279.734;";

	done
	echo "Atualização realizada com sucesso! ";
	Menu;
}
Sair(){
        exit;
}
Menu;
