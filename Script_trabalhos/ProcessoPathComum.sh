#!/bin/bash
#byCamargo

#loja=$(cut -c1-2 lojas.txt | sed -n 1p)

for loja in 11 12 15 16 22 27 37 40 51 53 54 60 67 71 72 79 81 82 86

#LOJAS DE SAMPA 01 02 06 09 11 12 15 16 17 22 27 37 40 51 53 54 60 67 71 72 79 81 82 86
do
	clear
	echo "Loja $loja"
	cd /home/leandro/ProcessosLinux/
	echo "Criando a pasta da loja"
	mkdir /mnt/Loja$loja
	echo "Montando o path_comum"
	mount -t cifs -s -o username=serviceZEUS,password=senhapath,domain=BRSPcliente,rw //10.52.$loja.30/path_comum_0$loja$ /mnt/Loja$loja
#AJUSTANDO A CARGA INICIAL
#	echo "Copiando os arquivos"
#	cp /home/leandro/ConfiguradorNovo/ArqsNovaCarga.tar.gz /mnt/Loja$loja/cargainicial/
#	cd /mnt/Loja$loja/cargainicial/
#	echo "Desconpactando"
#	tar xfz ArqsNovaCarga.tar.gz	

#AJUSTANDO ARQUIVOS NO PATH_COMUM
#	echo "Copiando o CARG"
#	cp /home/leandro/ProcessosLinux/CARG0102.CFG /mnt/Loja$loja/GERALCFG/

#       echo "Copiando o ECF9A"
#       cp /home/leandro/pdvcliente/ECF9A.CFG /mnt/Loja$loja/GERALCFG/
#       rm -rf /mnt/Loja$loja/ECFCFG/0*

       echo "Copiando o CFG_PAR"
       cp /home/leandro/PDVS/Pares.tar.gz /mnt/Loja$loja/GERALCFG/
       cd /mnt/Loja$loja/GERALCFG/; tar xfz Pares.tar.gz

	echo "Copiando CFG_IMPAR"
        cp /home/leandro/PDVS/Impares.tar.gz /mnt/Loja$loja/ECFCFG/001/
        cd /mnt/Loja$loja/ECFCFG/001/; tar xfz Impares.tar.gz
	echo "Copiando para o pdv 3"; cp *.CFG ../003/;
	echo "Copiando para o pdv 5"; cp *.CFG ../005/;
	echo "Copiando para o pdv 7"; cp *.CFG ../007/;
	echo "Copiando para o pdv 9"; cp *.CFG ../009/;
	echo "Copiando para o pdv 11"; cp *.CFG ../011/;
	echo "Copiando para o pdv 13"; cp *.CFG ../013/;
	echo "Copiando para o pdv 15"; cp *.CFG ../015/;
	echo "Copiando para o pdv 17"; cp *.CFG ../017/;
	echo "Copiando para o pdv 19"; cp *.CFG ../019/;
	echo "Copiando para o pdv 21"; cp *.CFG ../021/;
#COPIANDO DO PATH_COMUM PARA MINHA MAQUINA
#       echo "Puxando arquivos"
#	cp /mnt/Loja$loja/GERALCFG/RESTG0000.CFG /home/leandro/Área\ de\ Trabalho/ZMWSeRESTG/RESTG$loja.CFG
#	cp /mnt/Loja$loja/GERALCFG/ZMWS0000.CFG /home/leandro/Área\ de\ Trabalho/ZMWSeRESTG/ZMWS$loja.CFG

#Desmontando a particao	
        echo "Desmontando a partição"
	sleep 2
	umount /mnt/Loja*
#	echo "Loja OK =" $loja >> LogECFCFG.txt
	clear
done
