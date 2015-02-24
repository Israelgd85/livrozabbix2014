#!/bin/bash
#-------------------------------------------------------
# author:       Adail Spinola <the.spaww@gmail.com>, Aecio Pires <aeciopires@gmail.com> e Andre Deo <andredeo@gmail.com>
# date:         20-nov-2014
# revision:     Aecio Pires <aecio@dynavideo.com.br>
# Last updated: 21-jan-2015, 18:08
#-------------------------------------------------------

CMDLINE=$0

# Detecta se eh um usuario com poderes de root que esta executando o script
MYUID=$(id | cut -d= -f2 | cut -d\( -f1)
if [ ! "$MYUID" -eq 0 ] ; then
        echo "voce deve ser root para executar este script."
        echo "execute o comando \"sudo $CMDLINE\""
        exit 1
fi


# Este cap�tulo utiliza como ambiente o zabbix 2.*
SOURCE_DIR="/install/zabbix-2*";
cd $SOURCE_DIR

# Este cap�tulo utiliza como ambiente o zabbix 2.2.3
SOURCE_DIR="/install/zabbix-2*";
cd $SOURCE_DIR

cd database/sqlite3
# Cria localiza��o do repositorio de dados
mkdir /var/lib/sqlite/
sqlite3 /var/lib/sqlite/zabbix.db < schema.sql; 
sqlite3 /var/lib/sqlite/zabbix.db < images.sql; 
sqlite3 /var/lib/sqlite/zabbix.db < data.sql;

# Configurando a permissao do arquivo
useradd zabbix
chown -R zabbix:zabbix /var/lib/sqlite/
