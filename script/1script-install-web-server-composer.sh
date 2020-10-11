#!/bin/bash
# Autor: Francisco Dias
# Criado: 07/07/2020
# Atualizado: 10/10/2020
# Versão: 0.3
#
# ## Inicio do script ##
#
# Caminho para o Log do 1script-install-web-server-composer.sh
LOG="/var/log/1script-install-laravel.log"
# Declaração de variáveis
USUARIO=`id -u`
PROJETONAME=blog
# Verificando se o usuário é root
if [ "$USUARIO" == "0" ] 
then	
	echo -e "1 - Atualizar o apt:"
	echo -e "2 - Instalação do PHP:"
	echo -e "3 - Instalação do Apache"
	echo -e "4 - Instalação do Composer"
	echo
	echo -e "Rodando o 1script-install-laravel.sh `date`" > $LOG
#
	echo
	echo -e "Click <Enter> para continuar.."
	read
	clear
	echo -e "Digite <Enter> Iniciar a atualização do apt:"
	read
	apt -y update &>> $LOG
	echo
	echo ============================================================ >> $LOG
#
	echo -e "Digite <Enter> para instalar o php:"
	read
	echo
	apt install -y php libapache2-mod-php php-mbstring php-xmlrpc php-soap php-gd php-xml php-cli php-zip php-bcmath php-tokenizer php-json php-pear &>> $LOG
	echo
	echo ============================================================ >> $LOG
	echo -e "Fim da instalação do PHP, click <Enter> para continuar.."
	read
#
	echo -e "Clique <Enter> para checar o PHP e as dependencias para seguir com a instalação do laravel:"
	read
	php -m &>> $LOG
	echo ============================================================ >> $LOG
	echo -e "Digite <Enter> para instalar o Apache:"
	read
#
	apt install -y apache2 &>> $LOG
	echo -e "Fim da instalação do apache, click <Enter> para continuar"
	read
	echo
	echo ============================================================ >> $LOG
	echo -e "Digite <Enter> para verificar o status do apache2:"
	read
	systemctl status apache2 &>> $LOG
	echo
	echo ============================================================ >> $LOG
	echo -e "Digite <Enter> para dar Permissão da pasta /var/www/html/"
	read
	chmod -R 777 /var/www/html/ &>> $LOG 
	echo
	echo ============================================================ >> $LOG
	echo -e "Didite <Enter> para instalar o Composer:"
	read
	apt install -y composer &>> $LOG
	echo
	echo ============================================================ >> $LOG
	echo -e "Para testar a sua instalação do composer digite <Enter>:"
	read
	composer &>> $LOG
	echo
	echo ============================================================ >> $LOG
	echo -e "Digite <Enter> para continuar:"
	read
#
else
	echo -e "Não é root, execute o coando sudo -i para executar esse script como previlégio root."
fi
echo -e "Script finalizado, digite <Enter> sair:"
read
