#!/bin/bash

echo "Rodando Preventiva..";
echo 

############Variaveis de controle do Script#################

#Data
dt=`date "+%d%m%Y"`;
#Diretorio que será utilizado para criação dos arquivos temp
cd /tmp;

################ Verifica tempo maquina ligada ##############

time=`uptime | awk '{print $3}'`;
if [ $time -le 7 ];
then 
	echo -e  "- Maquina reiniciada a menos de 7 dias" >> resumo;
	echo "" >> resumo;	
fi
echo "" >> report;
echo "Uptime da máquina:" >> report;
echo "" >> report;
uptime  >> report;

############# Registro dos 10 últimos logins ###############

last_login=`last | head`;
echo -e "Ultimos usuários que realizaram login:\n $last_login" >> report;
echo "" >> report;

############ Verifica Tamanho dos Logs ####################

logs=`ls -lahS /var/log/  | egrep  '\BG' | wc -l`;
if [ $logs -ge 1 ]; then
	echo "Verifique o(s) log(s) aprensetado(s) abaixo:" >> resumo;
	ls -lahS /var/log/  | egrep  '\BG' >> resumo;
	echo "" >> resumo;
fi

###################Verifica espaço em disco######################################

disco=$(df -h | awk '{print $5}' | sed '1,3d' | sed 's/%//g');

#Cria Array com os valores coletados de todas as partições 
a=0;
for i in ${disco[@]}
do
	array[$a]=$i;
	a=$((a+1));
done

##Verifica se o disco está acima ou não

for t in ${array[*]}
do
	if [ $t -ge 80 ]; #Se entrar nessa condição o disco irá estourar
	then
		echo "- Verificar Espaço em Disco" >> resumo;
		echo "" >> resumo;
		break;	
	fi
done
echo "Espaço em Disco: " >> report;
echo "" >> report;
df -h >> report;
echo "" >> report;

############## Verifica Uso de memoria ################

##Verificar através do SAR 

################ Verificar tamanho do banco de dados ##################

########Servicos Summit#############


################# Verificar se o SPG está rodando ################

spg=`ps aux | grep -i spg | wc -l`;
if [ $spg -le 1 ];
	then 
		echo "- SPG não está rodando" >> resumo;
		echo "" >> resumo;
fi


#echo  "Serviços Summit que estão rodando nesta máquina";
#services=`ls -l `find /opt/sn -maxdepth 1 -type l -print` | auxwk '{ print $11 }' | sed 's/\/opt\/sn\///' |  tee -a  >> /root/aux_resport`;

#cat /root/aux_resport | egrep -i  'ssw|rsw|'

### Montar Relaorio###

echo "-----------------Resumo de Notificações-------------------- " >> report_$dt;
cat resumo >> report_$dt;
echo "-----------------Informações Gerais------------------------ " >> report_$dt;
cat report >> report_$dt;
rm -f resumo;
rm -f report;
