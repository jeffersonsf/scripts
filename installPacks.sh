#!/bin/bash
clear;

#Verificar se é o Usuário root que esta executando o Script
userV=`whoami`;
if [[ $userV == root ]]; then
	echo "###############################################################";
	echo "##                                                           ##";
	echo "##                                                           ##";
	echo "##            Script Instalação Programas Linux              ##";                         
	echo "##                                                           ##";
	echo "##                                 latam-infra@endurance.com ##";
	echo "###############################################################";

	sleep 3;

	Menu(){
		echo "---------------------------------------------------";
		echo "Escolha quais softwares serão instalados";
		echo "---------------------------------------------------";
		echo "[1] Todos";
		echo "[2] Terminator";
		echo "[3] Google Chrome";
		echo "[4] Linphone";
		echo "[5] HipChat";
		echo "[6] Remmina";
		echo "[7] Sublime 3";
		echo "[8] Copyq";
		echo;
		echo -n "Qual software você deseja instalar?";
		read opcao;
		case $opcao in 
			1) Todos ;;
			2) Terminator ;;
			3) Google Chrome ;;
			4) Linphone ;;
			5) HipChat ;;
			6) Remmina ;;
			7) Sublime 3 ;;
			8) Copyq ;;
			*) "Opção Desconhecida.";echo; Menu;;
		esac
	}

	##Funções

	instalaTerminator(){
		##Instala o terminator
		echo "Instalando Terminator.. ";
		apt-get install terminator;
	}
	Terminator(){
		##Adiciona o Repositorio do terminator 
		add-apt-repository --yes ppa:gnome-terminator/nightly-gtk3;
		apt get update;
		instalaTerminator;			
	}
	instalaChrome(){
		##Instala o Google Chrome
		echo "Instalando Google Chrome.. ";
		apt-get install google-chrome-stable;
		echo;
	}
	Chrome(){
		##Adiciona os respositorios do google Chrome
		sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list';
		wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -;
		sed -i -e 's/deb http/deb [arch=amd64] http/' "/etc/apt/sources.list.d/google.list" && sed -i -e 's/deb http/deb [arch=amd64] http/' "/opt/google/chrome/cron/google-chrome";
		apt-get update;
		instalaChrome;
	}
	instalaLinphone(){
		##Instala Linphone
		echo "Instalando Linphone.. ";
		apt-get install linphone;
		echo;
	}
	Linphone(){
		##Adiciona os repostórios necessários para a instalação do Linphone:
		add-apt-repository --yes ppa:linphone/release
		apt-get update;
		instalaLinphone;
	}
	instalaHipchat(){
		##Instala o HipChat
		apt-get install hipchat4;
		echo;
	}
	Hipchat(){
		##Adiciona os Repositórios necessários para instalação do HipChat:
		sh -c 'echo "deb https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client $(lsb_release -c -s) main" > /etc/apt/sources.list.d/atlassian-hipchat4.list';
		wget -O - https://atlassian.artifactoryonline.com/atlassian/api/gpg/key/public | apt-key add -;
		apt-get update;
		instalaHipchat;
	}
	instalaRemmina(){
		##Instala Remmina
		apt-get install remmina remmina-plugin-rdp libfreerdp-plugins-standard;
		echo;
	}
	Remmina(){
		##Adiciona os repositorios para o remmina
		add-apt-repository --yes ppa:remmina-ppa-team/remmina-next;
		apt-get update;
		instalaRemmina;
	}
	instalaSublime(){
		##Instala Sublime
		apt-get install sublime-text-installer
		echo;
	}
	Sublime(){
		##Adiciona os repositorios Sublime
		add-apt-repository --yes ppa:webupd8team/sublime-text-3;
		apt-get update;
		instalasublime;
	}
	instalaCopyq(){
		##Instala Copyq
		apt install copyq
		echo;
	}
	Copyq(){
		##Adiciona os repositorios do copyq
		add-apt-repository --yes ppa:hluk/copyq
		apt-get update;
		instalaCopyq;
	}

	Todos(){
		echo;
		## A partir daqui serão inseridos os repositórios no sistema operacional, para a instalação dos programas
		echo "Adicionando os repositórios Necessários: ";
		
		##Adiciona o Repositorio do terminator 
		add-apt-repository --yes ppa:gnome-terminator/nightly-gtk3;
		
		##Adiciona os respositorios do google Chrome
		sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list';
		wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -;
		sed -i -e 's/deb http/deb [arch=amd64] http/' "/etc/apt/sources.list.d/google.list" && sed -i -e 's/deb http/deb [arch=amd64] http/' "/opt/google/chrome/cron/google-chrome";
		
		##Adiciona os repostórios necessários para a instalação do Linphone:
		add-apt-repository --yes ppa:linphone/release

		##Adiciona os Repositórios necessários para instalação do HipChat:
		sudo sh -c 'echo "deb https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client $(lsb_release -c -s) main" > /etc/apt/sources.list.d/atlassian-hipchat4.list';
		wget -O - https://atlassian.artifactoryonline.com/atlassian/api/gpg/key/public | apt-key add -;

		##Adiciona os repositorios para o remmina
		add-apt-repository --yes ppa:remmina-ppa-team/remmina-next

		##Adiciona os repositorios Sublime
		add-apt-repository --yes ppa:webupd8team/sublime-text-3

		##Adiciona os repositorios do copyq
		add-apt-repository --yes ppa:hluk/copyq

		##Atualizando os pacotes do sistema operacional
		apt-get update; 

		##A partir daqui serão instalados os programas

		##Instala o terminator
		echo "Instalando Terminator.. ";
		apt-get install terminator;
		echo;
		##Instala o Google Chrome
		echo "Instalando Google Chrome.. ";
		apt-get install google-chrome-stable;
		echo;
		##Instala Linphone
		echo "Instalando Linphone.. ";
		apt-get install linphone;
		echo;
		##Instala o HipChat
		apt-get install hipchat4;
		echo;
		##Instala Remmina
		apt-get install remmina remmina-plugin-rdp libfreerdp-plugins-standard;
		echo;
		##Instala Sublime
		apt-get install sublime-text-installer
		echo;
		##Instala Copyq
		apt install copyq
		echo;
	}

		##Mostra o menu de escolha para o usuario
	Menu;

	##Verifica a Opcao Escolhida pelo Usuario 
	if [[ $opcao == "1" ]]; then
		Todos;
	else 
		if [[ $opcao == "2" ]]; then
			Terminator;
		else
			if [[ $opcao == "3" ]]; then
				Chrome;
			else
				if [[ $opcao == "4" ]]; then
					Linphone;
				else
					if [[ $opcao == "5" ]]; then
						Hipchat;
					else
						if [[ $opcao == "6" ]]; then
							Remmina;
						else
							if [[ $opcao == "7" ]]; then
								Sublime;
							else
								if [[ $opcao == "8" ]]; then
									Copyq;
								fi
							fi
						fi
					fi
				fi
			fi
		fi
	fi			
	echo;
	echo "Instalação de Softwares Concluida com sucesso!";

else
    echo "Instalação deve ser realizada somente pelo usuário administrador!"; 
fi
