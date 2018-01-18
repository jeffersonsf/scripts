#!/bin/bash

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

echo;
## A partir daqui serão inseridos os repositórios no sistema operacional, para a instalação dos programas
echo "Adicionando os repositórios Necessários: ";

##Adiciona o Repositorio do terminator 
add-apt-repository ppa:gnome-terminator/nightly-gtk3;

##Adiciona os respositorios do google Chrome
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list';

wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -;

sed -i -e 's/deb http/deb [arch=amd64] http/' "/etc/apt/sources.list.d/google.list" && sed -i -e 's/deb http/deb [arch=amd64] http/' "/opt/google/chrome/cron/google-chrome";


##Adiciona os repostórios necessários para a instalação do Linphone:

add-apt-repository ppa:linphone/release

##Adiciona os Repositórios necessários para instalação do HipChat:

sudo sh -c 'echo "deb https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client $(lsb_release -c -s) main" > /etc/apt/sources.list.d/atlassian-hipchat4.list';

wget -O - https://atlassian.artifactoryonline.com/atlassian/api/gpg/key/public | apt-key add -;

##Adiciona os repositorios para o remmina

add-apt-repository ppa:remmina-ppa-team/remmina-next

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

echo "Instalação de Softwares Concluida com sucesso!";

else
    echo "Instalação deve ser realizada somente pelo usuário administrador!"; 
fi
