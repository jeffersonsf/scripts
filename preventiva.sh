#!/bin/bash

echo "PREVENTIVA SUMMIT..";
sleep 2;
echo "################";
echo "Coletando informações";
sleep 2;

dt=`date "+%d%m%Y"`;
report=`root/report_$dt`;

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
		echo "######VERIFICAR ESPAÇO DISCO#######" >> $report;
		df -h | tee -a  >> $report;
		break;	
	fi
done

################ Verifica tempo maquina ligada ############################

time=`uptime | awk '{print $3}'`;
if [ $time -le 7 ];
then 
	echo -e  "Maquina reiniciada a menos de 7 dias\ne" >> $report;
	uptime | tee -a  >> $report;
fi

############## Verifica Uso de memoria ################

##Verificar através do SAR 

################ Verificar tamanho do banco de dados ##################


############# Usuario Logados no momento###############

last_login=`last | head`;
echo -e "Ultimos usuários que realizaram login:\n $last_login";

############ Verifica Tamanho dos Logs ####################

echo -e "SE FOR APRESENTADO ALGUM RESULTADO ANALISE O LOG: \n";

ls -lahS /var/log/ | egrep '\BM|\BG' | tee -a >>  $report;

################# Verificar se o SPG está rodando ################

spg=`ps aux | grep -i spg | wc -l`;
if [ $spg -le 1 ];
	then 
		echo "SPG não está rodando" | tee -a $report;
fi

####### Servicos Summit #####


echo  "Serviços Summit que estão rodando nesta máquina";
services=`ls -l `find /opt/sn -maxdepth 1 -type l -print` | awk '{ print $11 }' | sed 's/\/opt\/sn\///' |  tee -a  >> /root/aux_resport`;

#cat /root/aux_resport | egrep -i  'ssw|rsw|'


