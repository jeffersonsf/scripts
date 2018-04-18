#!/bin/bash

echo "PREVENTIVA SUMMIT..";
sleep 2;



echo "################";
echo "Coletando informações";

disco=$(df -h | awk '{print $5}' | sed '1,3d' | sed 's/%//g');
up=$(uptime);
memoria=$(free -m);
data=$(date);
nome=$(hostname);


for i in $(seq 10); do echo $disco | cut -d " " -f$i; done

##Faz Verificações

if [ $disco -ge 90 ]
then
	echo "Disco vai estourar"; 
fi  
