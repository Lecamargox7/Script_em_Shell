#!/bin/bash
#byLeandroCamargo
#Este script foi criado com o intuito de automatizar as configurações dos pdvs CLIENTE
#Apos a formatacao do pdv, usamos este script para ajustar a configurações
#para SAT, NFCE ou ECF.
#Bem vindo ao Configurador PDV Zanthus.
clear
echo " _______________________________________________________   "
echo "|  ____                  __     ___           _       _  | "
echo "| | __ )  ___ ________   \ \   / (_)____   __| | ___ | | | "
echo "| |  _ \ / _ \  _   _ \   \ \ / /| |  _ \ / _  |/ _ \| | | "
echo "| | |_) |  __/ | | | | |   \ V / | | | | | (_| | (_) |_| | "
echo "| |____/ \___|_| |_| |_|    \_/  |_|_| |_|\__ _|\___/(_) | "
echo "|                                  ______________________| "
echo "|                                   |"
echo "| CONFIGURANDO PDV ZANTHUS CLIENTE! |"
echo "|________________________________ __|"
sleep 2 

#Finalizando os programas abertos
echo "Finalizando os programas abertos"
killall -9 lnx_receb java lnx_sweda2 lnx_ncr2 lnx_epson2

#Bloqueando o USB
echo "Bloqueando o USB"
mv /lib/modules/$(uname -r)/kernel/drivers/usb/storage/usb-storage.ko /Zanthus

#Montando o path_comum
echo "Montando o path_comum"
loja=`ifconfig | grep "ine" | sed -n 1p | cut -d: -f2 | cut -d" " -f2 | cut -d. -f3`;

#echo $loja

if [ "$loja" -lt "10" ]; then

mount -t cifs -s -o username=serviceZEUS,password=senhapath,domain=BRSPCLIENTE,rw //10.52.$loja.30/path_comum_00$loja$ /Zanthus/Zeus/path_comum
mount="mount -t cifs -s -o username=serviceZEUS,password=senhapath,domain=BRSPCLIENTE,rw \/\/10.52.$loja.30\/path_comum_00$loja$ \/Zanthus\/Zeus\/path_comum"
else

mount -t cifs -s -o username=serviceZEUS,password=senhapath,domain=BRSPCLIENTE,rw //10.52.$loja.30/path_comum_0$loja$ /Zanthus/Zeus/path_comum
mount="mount -t cifs -s -o username=serviceZEUS,password=senhapath,domain=BRSPCLIENTE,rw \/\/10.52.$loja.30\/path_comum_0$loja$ \/Zanthus\/Zeus\/path_comum"
fi

#Configurando o enviroment
echo "Configurando o enviroment"
#cp /Zanthus/Zeus/path_comum/cargainicial/environment /etc/
host=$(cat /etc/hosts | grep 10 | awk '{print $NF}')
sed -i "s/HOSTNAME=.*/HOSTNAME=$host/" /etc/environment;
sed -i "s/Z_MOUNT='.*/Z_MOUNT='$mount'/" /etc/environment;
chmod 777 /etc/environment
mount

#echo $host

echo " ___________________________________________ "
echo "|                                           |"
echo "| MONTAGEM DO PATH_COMUM OK? SE NÃO CTRL+C  |"
echo "|___________________________________________ "
sleep 2

#Criando diretorio e inserindo o arquivo timezone
echo "Criando diretorio e inserindo o arquivo timezone"

mkdir /root/bin
cp /Zanthus/Zeus/path_comum/cargainicial/set_timezone_pdvs.bash /root/bin/

/usr/sbin/ntpdate zeus.CLIENTE.com.br

/root/bin/set_timezone_pdvs.bash

#Ajuste da crontab
echo "Ajustando a crontab"

cp /Zanthus/Zeus/path_comum/cargainicial/root /var/spool/cron/crontabs/

#Configurando o interface
echo "Configurando o interface"

pdv=`ifconfig | grep "ine" | sed -n 1p | cut -d: -f2 | cut -d" " -f2 | cut -d. -f4`;
#echo $pdv
if [ $(($pdv%2)) -eq '0' ]; then
       cp /Zanthus/Zeus/path_comum/cargainicial/interfaces_par /etc/network/interfaces 
else
       cp /Zanthus/Zeus/path_comum/cargainicial/interfaces_impar /etc/network/interfaces
fi

address_pdv=`ifconfig | grep "ine" | sed -n 1p | cut -d: -f2 | cut -d" " -f2`;
sed -i "s/address .*/address $address_pdv/" /etc/network/interfaces;
#echo $address_pdv

gatway_pdv=`ifconfig | grep "ine" | sed -n 1p | cut -d: -f2 | cut -d" " -f2 | cut -d. -f1,2,3`;
sed -i "s/gateway .*/gateway $gatway_pdv.100/" /etc/network/interfaces;
#echo $gatway_pdv

echo "Ajustando as libs e configurando o fstab"
cd /Zanthus/Zeus/lib/
rm -f lib3ecfreceb_R9*
cd /Zanthus/Zeus/path_comum/so/
rm -f lib3ecfreceb_R*
cd /etc
cp -v fstab fstab_bkp
sed -i '/errors=remount-ro/s/rw,errors=remount-ro/rw,errors=remount-ro,noatime,nobarrier,commit=1/g' fstab

echo "Ajustando a senha para o padrão CLIENTE"
echo "root:senha123" | chpasswd

echo "Atualizando as bibliotecas"
cd /Zanthus/Zeus/path_comum/cargainicial/
cp ZMAN*CZ.tar.gz /Zanthus/Zeus/pdvJava/
cp pdvJava2 /Zanthus/Zeus/pdvJava/
cp libepson.tar.gz /Zanthus/Zeus/lib/

cp -fr /Zanthus/Zeus/path_comum/so/* /Zanthus/Zeus/lib/
cp -fr /Zanthus/Zeus/path_comum/so_co5/* /Zanthus/Zeus/lib_co5/
cp -fr /Zanthus/Zeus/path_comum/so_ubu/* /Zanthus/Zeus/lib_ubu/ 
cp -fr /Zanthus/Zeus/path_comum/ZArqConfig /Zanthus/Zeus/pdvJava

cd /Zanthus/Zeus/lib/
tar xfvz libepson.tar.gz

ldconfig;

resposta=0

while [ "$resposta" -lt "1" ] || [ "$resposta" -gt "4"  ]
do

echo " ______________________________________ "
echo "|   Qual o perfil do PDV desta loja?   |"
echo "|   Lembrando que é loja: $loja PDV: $pdv   |"
echo "|    Digite o numero correspondente:   |"
echo "|        1 - SAT                       |"
echo "|        2 - NFCe                      |"
echo "|        3 - SWEDA                     |"
echo "|        4 - EPSON                     |"
echo "|______________________________________|"
read resposta ;

done

if [ "$resposta" = "1" ]; then
echo "Configurando PDV SAT"
sleep 2
  rabbitmqctl add_user zanthus zanthus; rabbitmqctl set_user_tags zanthus administrator; rabbitmqctl set_permissions -p / zanthus "." "." ".*";
  cd /Zanthus/Zeus/pdvJava/;
  cp -v /Zanthus/Zeus/path_comum/GERALCFG/*.* .
  sed -i "s/EXECUTAVEL=.*/EXECUTAVEL=RECEB/" EXEC_PAF.CFG;
  chmod 777 ZMAN*CZ.tar.gz
  tar -vzxf ZMAN*CZ.tar.gz
  rm *.XXX
  cd /usr/local/bin/luPDV/
  ./Set-PDVJava;
  rm -rf /Zanthus/Zeus/pdvJava/GERAL/SINCRO/WEB/moduloPHPPDV/sat_lab.conf;
  cd /Zanthus/Zeus/;
  mv ctsat* ctsat;
  mv *ctsat ctsat;
  cd ctsat/;
  rm -rf lnx_ctsat_*.xz
  rm -rf ZMWS0000.CFG
  cp ../pdvJava/ZMWS0000.CFG .;
  cp /Zanthus/Zeus/path_comum/cargainicial/ctsat/* .;
  pdv=`ifconfig | grep "ine" | sed -n 1p | cut -d: -f2 | cut -d" " -f2 | cut -d. -f4`;
  sed -i "s/loja=.*/loja=$loja/" CTSAT.CFG;
  sed -i "s/pdv=.*/pdv=$pdv/" CTSAT.CFG;
  ln -sf lnx_ctsat_1_0_18.xz lnx_ctsat.xz;
  ldconfig 
  
  echo " ________________________________________________________________ "
  echo "|              CONFIGURACAO CONCLUIDA COM SUCESSO!!!             |"
  echo "|                 Pressione o Enter para reiniciar               |"
  echo "|________________________________________________________________|"
  read #pausa
  shutdown -r now
    

elif [ "$resposta" = "2" ]; then
echo "Configurando PDV NFCE"
sleep 2
  cd /Zanthus/Zeus/;
  mv ctsat* ctsat_old;
  mv *ctsat ctsat_old;
  cd /Zanthus/Zeus/pdvJava/;
  cp -v /Zanthus/Zeus/path_comum/GERALCFG/*.* .
  sed -i "s/EXECUTAVEL=.*/EXECUTAVEL=RECEB/" EXEC_PAF.CFG;
  chmod 777 ZMAN*CZ.tar.gz
  tar -vzxf ZMAN*CZ.tar.gz
  rm *.XXX
  cd /usr/local/bin/luPDV/
  ./Set-PDVJava;
  mkdir -p /Zanthus/Zeus/pdvJava/GERAL/SINCRO/WEB/moduloPHPPDV
  rm -rf /Zanthus/Zeus/pdvJava/GERAL/SINCRO/WEB/moduloPHPPDV/sat_lab.conf;

  echo " ________________________________________________________________ "
  echo "|              CONFIGURACAO CONCLUIDA COM SUCESSO!!!             |"
  echo "|                 Pressione o Enter para reiniciar               |"
  echo "|________________________________________________________________|"
  
  read #pausa
  shutdown -r now

elif [ "$resposta" = "3" ]; then
echo "Configurando PDV SWEDA"
sleep 2
  cp /Zanthus/Zeus/path_comum/cargainicial/GerMD5_ER-PAF-ECF_02_05.tar.gz /
  cd /
  tar -vzxf GerMD5_ER-PAF-ECF_02_05.tar.gz
  cd /Zanthus/Zeus/;
  mv ctsat* ctsat_old;
  mv *ctsat ctsat_old;
  cd /Zanthus/Zeus/pdvJava/;
  cp -v /Zanthus/Zeus/path_comum/GERALCFG/*.* .
  sed -i "s/EXECUTAVEL=.*/EXECUTAVEL=SWEDA2/" EXEC_PAF.CFG;
  chmod 777 ZMAN*CZ.tar.gz
  tar -vzxf ZMAN*CZ.tar.gz
  rm *.XXX
  cd /usr/local/bin/luPDV/
  ./Set-PDVJava;
  cd /Zanthus/Zeus/pdvJava/SWEDA/
  cp /Zanthus/Zeus/path_comum/cargainicial/CONVERSOR.ini .
  cd /Zanthus/Zeus/pdvJava
  cp /Zanthus/Zeus/path_comum/cargainicial/SWC.INI .
  cp /Zanthus/Zeus/path_comum/cargainicial/PAF9CFG.BZ0 .
  
  echo " ________________________________________________________________ "
  echo "|              CONFIGURACAO CONCLUIDA COM SUCESSO!!!             |"
  echo "|                 Pressione o Enter para reiniciar               |"
  echo "|________________________________________________________________|"
  
  read #pausa
  shutdown -r now
  
elif [ "$resposta" = "4" ]; then
echo "Configurando PDV EPSON"
sleep 2

  cd /Zanthus/Zeus/;
  mv ctsat* ctsat_old;
  mv *ctsat ctsat_old;
  cp /Zanthus/Zeus/path_comum/cargainicial/GerMD5_ER-PAF-ECF_02_05.tar.gz /
  ldconfig
  cd /
  tar -vzxf GerMD5_ER-PAF-ECF_02_05.tar.gz
  cd /Zanthus/Zeus/pdvJava/;
  cp -v /Zanthus/Zeus/path_comum/GERALCFG/*.* .
  sed -i "s/EXECUTAVEL=.*/EXECUTAVEL=EPSON2/" EXEC_PAF.CFG;
  chmod 777 ZMAN*CZ.tar.gz
  tar -vzxf ZMAN*CZ.tar.gz
  rm *.XXX
  cd /usr/local/bin/luPDV/
  ./Set-PDVJava;
  cp /Zanthus/Zeus/path_comum/cargainicial/PAF9CFG.BZ0 /Zanthus/Zeus/pdvJava
  
  echo " ________________________________________________________________ "
  echo "|              CONFIGURACAO CONCLUIDA COM SUCESSO!!!             |"
  echo "|                 Pressione o Enter para reiniciar               |"
  echo "|________________________________________________________________|"

  read #pausa
  shutdown -r now
  
else
 echo "Erro não identificado."
fi
