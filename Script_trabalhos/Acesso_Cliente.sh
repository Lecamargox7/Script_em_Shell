#!/bin/bash
#Script de acesso aos pdvs, servidores Cliente e utilitários
#criado por Leandro Camargo
#Versão_1
rm -rf /root/.ssh/known_hosts
clear
echo   "  _______________________________________________________   "
echo   " |  ____                  __     ___           _       _  | "
echo   " | | __ )  ___ ________   \ \   / (_)____   __| | ___ | | | "
echo   " | |  _ \ / _ \  _   _ \   \ \ / /| |  _ \ / _  |/ _ \| | | "
echo   " | | |_) |  __/ | | | | |   \ V / | | | | | (_| | (_) |_| | "
echo   " | |____/ \___|_| |_| |_|    \_/  |_|_| |_|\__ _|\___/(_) | "
echo   " |________________________________________________________| "

echo "###########################################################"
echo "#######     Digite o valor para a ação desejada:    #######" 
echo "##                                                       ##"
echo "##       Acessar PDV Digite     = 1                      ##"
echo "##       Acessar Servidor       = 2                      ##"
echo "##       Carga Inicial          = 3                      ##"
echo "##       Ajustando Performance  = 4                      ##"
echo "##                                                       ##"
echo "###########################################################"
read opcao;

if [ $opcao -eq 1 ]
then
clear
echo "###########################################################"
echo "             Digite o número da LOJA:                      " 
echo "###########################################################"
read loja;

clear
echo "###########################################################"
echo "   Número da loja é $loja, agora digite o número do PDV:   "
echo "###########################################################"
read pdv;

clear
echo "###########################################################"
echo "       Aguarde, Acessando Loja: $loja, Pdv $pdv            "
echo "###########################################################"
sleep 2 

sshpass -p "senha123" ssh -o StrictHostKeyChecking=no root@10.52.$loja.$pdv

echo "###########################################################"
echo "             Obrigado por usar o Acesso.                   " 
echo "###########################################################"
sleep

elif [ $opcao -eq 2 ]
then
clear   
echo " _____________________________________________________ "
echo "|      "Digite o número do SERVIDOR desejado"         |"
echo "|                                                     |"
echo "|  -1- SERVZAN02 -111-> Aplicação - Pré-Prodrução     |"
echo "|  -2- SERVZAN06 -135-> Mirage 1 -Lojas Impares       |"
echo "|  -3- SERVZAN07 -137-> Mirage 2 -Lojas pares         |"
echo "|  -4- SERVZAN09 -120-> Arquivos (NFS)                |"
echo "|  -5- SERVZAN03 -155-> Aplicação 1                   |"
echo "|  -6- SERVZAN04 -156-> Aplicação 2                   |"
echo "|  -7- SERVZAN05 -157-> Aplicação 3                   |"
echo "|  -8- SERVZAN08 -181-> Homologação                   |"
echo "|                                                     |"
echo "|______________Exemplo digite: 3 para acessar o 137___|"
read servidor;

	if [ $servidor -eq 1 ]
	then
sshpass -p "Cliente@20" ssh -o StrictHostKeyChecking=no t_lfagundes@10.52.234.111

	elif [ $servidor -eq 2 ]
	then
sshpass -p "Cliente@20" ssh -o StrictHostKeyChecking=no t_lfagundes@10.52.234.135
	
	elif [ $servidor -eq 3 ] 
	then
sshpass -p "Cliente@20" ssh -o StrictHostKeyChecking=no t_lfagundes@10.52.234.137
	
	elif [ $servidor -eq 4 ] 
	then
sshpass -p "Cliente@20" ssh -o StrictHostKeyChecking=no t_lfagundes@10.52.234.120
	
	elif [ $servidor -eq 5 ] 
	then
sshpass -p "Cliente@20" ssh -o StrictHostKeyChecking=no t_lfagundes@10.52.234.155
	
	elif [ $servidor -eq 6 ] 
	then
sshpass -p "Cliente@20" ssh -o StrictHostKeyChecking=no t_lfagundes@10.52.234.156
	
	elif [ $servidor -eq 7 ] 
	then
sshpass -p "Cliente@20" ssh -o StrictHostKeyChecking=no t_lfagundes@10.52.234.157

        elif [ $servidor -eq 8 ]
        then
sshpass -p "Cliente@20" ssh -o StrictHostKeyChecking=no t_lfagundes@10.52.239.181

	else 
echo "###########################################################"
echo "######    XXXXXXXXX    OPÇÃO INCORRETA   XXXXXXXXX    #####"
echo "###########################################################"
	fi

elif [ $opcao -eq 3 ]
then

clear
echo "###########################################################"
echo "             Digite o número da LOJA:                      " 
echo "###########################################################"
read loja;

clear
echo "###########################################################"
echo "   Número da loja é $loja, agora digite o número do PDV:   "
echo "###########################################################"
read pdv;

	if [ $pdv -eq 0 ]
	then 
		echo "XXXXXXXXXXXX Valor inválido XXXXXXXXXXXX"

	elif [ $pdv -gt 22 ]
		then
		echo "XXXXXXXXXXXX Valor inválido XXXXXXXXXXXX" 
	else

		if ! ping -c 5 10.52.$loja.$pdv >/dev/null; then
			echo "PDV OFFLINE"
			echo "Ctrl+C para sair"
		else
			echo "PDV ONLINE"
			echo "A Configuração será iniciada..."
	sshpass -p "zanthus" scp -o StrictHostKeyChecking=no ConfigPdvZanthus.sh root@10.52.$loja.$pdv:/root/;
	sshpass -p "zanthus" ssh -o StrictHostKeyChecking=no root@10.52.$loja.$pdv "./ConfigPdvZanthus.sh";
			echo "Configuração Concluída!"
			./acesso.sh
		fi
	fi


elif [ $opcao -eq 4 ]
then

clear
echo "###########################################################"
echo "             Digite o número da LOJA:                      " 
echo "###########################################################"
read loja;

clear
echo "###########################################################"
echo "   Número da loja é $loja, agora digite o número do PDV:   "
echo "###########################################################"
read pdv;

        if [ $pdv -eq 0 ]
        then
                echo "XXXXXXXXXXXX Valor inválido XXXXXXXXXXXX"

        elif [ $pdv -gt 22 ]
                then
                echo "XXXXXXXXXXXX Valor inválido XXXXXXXXXXXX" 
        else

                if ! ping -c 5 10.52.$loja.$pdv >/dev/null; then
                        echo "PDV OFFLINE"
                        echo "Ctrl+C para sair"
                else
                        echo "PDV ONLINE"
                        echo "A Configuração será iniciada..."
sshpass -p "senha123" scp Set_perfAgosto2017 root@10.52.$loja.$pdv:/root/;sshpass -p "senha123" ssh -o StrictHostKeyChecking=no root@10.52.$loja.$pdv "./Set_perfAgosto2017";
                        echo "Configuração Concluída!"
                        ./acesso.sh
                fi
        fi

else

echo "###########################################################"
echo "###      XXX OPÇÃO INCORRETA, ESCOLHA 1,2,3 ou 4. XXX     ###"
echo "###########################################################"

fi
