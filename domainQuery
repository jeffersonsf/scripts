#!/bin/bash
echo -e "-------------------------------------------------------\n"
echo    "--------Iniciando consulta entrada DNS------------------"
echo""

for url in $(echo 'A,ANY,MX,NS,SOA,HINFO,AXFR,TXT' | awk -F , '{print$1"\n"$2"\n"$3"\n"$4"\n"$5"\n"$6"\n"$7"\n"$8}');
do
        echo -e "-------------------------\n Entrada tipo: $url \n\n" $(host -t $url $1)
done

echo -e "-------------------------------------------------------\n"
echo -e "DNS Reverso\n" 

ipm=`host -t a $1 | awk '{print$4}' | sed '2d'`
host $ipm

echo -e "-------------------------------------------------------\n"
echo    "--------Consulta de entradas DNS finalizadas-------------"

echo -e "-------------------------------------------------------------"
echo "---------------------Transferência de zona DNS--------------------"

for dns in $(host -t ns $1  | awk  '{print$4}'); do host -l $1 $dns;
done

echo -e "---------------------Testes subdominios-----------------------\n"

for sub in $(echo 'online,ead,webmail,login,cpanel,administrator,acesso,server' | awk -F , '{print$1"\n"$2"\n"$3"\n"$4"\n"$5"\n"$6"\n"$7"\n"$8}');
do
        echo -e " \n Subdominio: $sub \n" $(host $sub.$1)
done
echo -e "--------------------Fim das Consultas-----------------------------"
