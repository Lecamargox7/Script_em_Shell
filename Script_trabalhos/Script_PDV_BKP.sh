#!/bin/bash

echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_";
echo "_-_- criando a pasta e realizando o backup dos arquivos _-_";
echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_";

mkdir BKP_PDV

echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_";
echo "_-_-_-_-_- Realizando backup das antigas configurações -_-_";
echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_";

echo "movendo arquivos de ZZZ Liença do PDV";
mv ZZZ* BKP_PDV

echo "movendo arquivos .TRA"
mv *.TRA BKP_PDV

echo "movendo arquivo ECF9NVOL.NV_";
mv ECF9NVOL.NV_ BKP_PDV

echo "movendo arquivo NUMERACCAIXA";
mv NUMERACAIXA_L.JSON BKP_PDV

echo "movendo arquivos NVW";
mv *.NVL BKP_PDV

echo "movendo arquivos .1VN";
mv *.1VN BKP_PDV

echo "movendo arquivos *.XXX";
mv *.XXX BKP_PDV

echo "movendo arquivos *.XML";
mv *.XML BKP_PDV
mv *.xml BKP_PDV

echo "movendo arquivo *.TXT";
mv *.TXT BKP_PDV
mv *.txt BKP_PDV

echo "movendo arquivos LIBERA91.BZ0";
mv LIBERA91.BZ0 BKP_PDV

echo "movendo arquivos util_R90.xz";
mv util_R9* BKP_PDV

echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_";
echo "_-_-_-_-Baixando e autorizando arquivo util_R90 -_-_-_-_-_";
echo "_-_-_-_-_-_FAVOR LIBERE O ACESSO A INTERNET -_-_-_-_-_-_-_";
echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_";

wget ftp://ftp.zanthus.com.br:2142/pub/Zeus_Frente_de_Loja/_Complementares/exec_9X/util/IZ9X_1_0_23/util_R90.xz
chmod 777 util_R90.xz

echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_";
echo "_-_-_-_-_-_-_-_- FABRICANDO A IMPRESSORA -_-_-_-_-_-_-_-_-_";
echo "_-_-_-_-_- Refaça o procedimento de fabricação -_-_-_-_-_-_";
echo "_-_-_-_-_- se o valor for diferente de r=0 _-_-_-_-_-_-_-_-";
echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_";
./util_R90.xz FABRICAR

echo "PROG Impressora";
./util_R90.xz PROG=simula.ecf

echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_";
echo "_-_-_- Refaça Todas as Funções iniciais  do PDV -_-_-_-_-_-";
echo "_-_-_- Todas as onfigurações antigas foram movidas -_-_-_-_";
echo "_-_-_- para /Zanthus/Zeus/pdvJava/BKP_PDV _-_-_-_-_-_-_-_-_";
echo "_-_-_- Para numerar o PDV Novamente,-_-_-_-_-_-_-_-_-_-_-_-";
echo "_-_-_- exclua o mesmo do manager antes de subir o nucleo_-_";
echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_";

