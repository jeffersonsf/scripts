#!/bin/bash

echo "PREVENTIVA SUMMIT..";
sleep 2;
echo "################";
echo "Coletando informações";
sleep 2;

dt=`date "+%d%m%Y"`;

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
	if [ $t -ge 90 ]; #Se entrar nessa condição o disco irá estourar
	then
		echo "######VERIFICAR ESPAÇO DISCO#######" >> /root/report_$dt
		df -h | tee -a  >> /root/report_$dt
		break;	
	fi
done

################ Verifica tempo maquina ligada ############################

time=`uptime | awk '{print $3}'`;
if [ $time -le 7 ];
then 
	echo  "Maquina reiniciada a menos de 7 dias" >> /root/report_$dt;
	uptime | tee -a  >> /root/report_$dt;
fi

############## Verifica Uso de memoria ################

##Verificar através do SAR 

################ Verificar tamanho do banco de dados ##################





