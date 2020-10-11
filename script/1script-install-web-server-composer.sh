#!/bin/bash
# Autor: Francisco Dias
# Criado: 10/10/2020
# Atualizado: 07/07/2020
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
	read "Click <Enter> para continuar.."
	clear
	read "Digite <Enter> Iniciar a atualização do apt:"
	apt -y update &>> $LOG
	echo
	echo ============================================================ >> $LOG
#
	read "Digite <Enter> para instalar o php:"
	echo
	apt install -y php libapache2-mod-php php-mbstring php-xmlrpc php-soap php-gd php-xml php-cli php-zip php-bcmath php-tokenizer php-json php-pear &>> $LOG
	echo
	echo ============================================================ >> $LOG
	read "Fim da instalação do PHP, click <Enter> para continuar.."
#
	php -m &>> $LOG
	echo ============================================================ >> $LOG
	read "Clique <Enter> para checar o PHP e as dependencias para seguir com a instalação do laravel:"
	read "Digite <Enter> para instalar o Apache:"
#
	apt install -y apache2 &>> $LOG
	read "Fim da instalação do apache, click <Enter> para continuar"
	echo
	echo ============================================================ >> $LOG
	read "Digite <Enter> para verificar o status do apache2:"
	systemctl status apache2 &>> $LOG
	echo
	echo ============================================================ >> $LOG
	read "Digite <Enter> para dar Permissão da pasta /var/www/html/"
	chmod -R 777 /var/www/html/ &>> $LOG 
	echo
	echo ============================================================ >> $LOG
	read "Didite <Enter> para instalar o Composer:"
	apt install -y composer &>> $LOG
	echo
	echo ============================================================ >> $LOG
	read "Para testar a sua instalação do composer digite <Enter>:"
	composer &>> $LOG
	echo
	echo ============================================================ >> $LOG
	read "Digite <Enter> para continuar:"
#
else
	echo -e "Não é root, execute o coando sudo -i para executar esse script como previlégio root."
fi
read "Script finalizado, digite <Enter> sair:"
