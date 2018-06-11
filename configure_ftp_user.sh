#!/bin/bash 

##Verificação da existência do Usuário ou se o mesmo está em branco
op0=true;
while [[ $op0 == true ]]; do
	echo -e "\nDigite o usuário que deverá ser criado a conta FTP";
	read newUser;
	existUser=`getent passwd $newUser | wc -l`;
	if [[ -z $newUser  ]]; then
		echo "Usuario em branco, digite um usuario valido!";	
	elif [[ $existUser -ge 1 ]]; then
		echo "Usuario já existe, digite outro usuario";				
	else
		op0=false;
	fi
done
##Criação de usuários e configuração dos diretórios
cd /rislab;
mkdir $newUser;
useradd -d $directory/$newUser -s /sbin/nologin $newUser;
pass=`date | md5sum | head -c8`;
usermod -p $(openssl passwd $pass) $newUser;
echo "";
echo "Usuario inserido com sucesso, abaixo os dados para acesso via FTP:";
echo "Usuario: $newUser";
echo "Senha: $pass";

