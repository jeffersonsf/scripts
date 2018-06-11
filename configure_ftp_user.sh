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
op1=true;
while [[ $op1 == true ]]; do
	echo -e "\nDigite a senha do novo usuario";
	stty -echo;
	read passwdUser;
	stty echo;
	if [[ -z $passwdUser ]]; then
		echo "Senha não pode ser em branco";
		op1=true;
	else
		op1=false;
	fi
done
##Criação de usuários e configuração dos diretórios
cd /rislab;
mkdir $newUser;
useradd -d $directory/$newUser -s /sbin/nologin $newUser;
