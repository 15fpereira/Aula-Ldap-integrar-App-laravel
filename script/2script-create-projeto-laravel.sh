#!/bin/bash 
# Autor: Francisco Dias 
# Criado: 07/07/2020 
# Atualizado: 07/07/2020 
# Versão: 0.2
# # ## Inicio do script ## # 
# Caminho para o Log do 2instalar-projeto-laravel.sh
LOG="/var/log/2script-create-projeto-laravel.log"
# Declaração de variáveis 
USUARIO=`id -u`
export PROJETONAME
# Verificando se o usuário é root 
if [ "$USUARIO" == "0" ]
then
	 clear
         echo -e "Instalar Projeto Laravel:"
         echo
         echo -e "Rodando o script 2script-create-projeto-laravel.sh `date`" > $LOG
         echo ============================================================ >> $LOG
         echo -e "Digite <Enter> para continuar:"
         read
         clear
         echo -e "Pronto! Agora vamos instalar o projeto laravel?"
         echo -e "Digite o nome do Projeto:"
         read PROJETONAME;
         composer create-project --prefer-dist laravel/laravel /var/www/html/$PROJETONAME &>> $LOG
         echo
         echo ============================================================ >> $LOG
         echo -e "PROTO! PROJETO CRIADO COM SUCESSO, <Enter> para continuar.."
         read
         echo
         echo -e "Agora é só definir as permissões da pasta do projeto e storage:"
         read
	 echo
	 echo ============================================================ >> $LOG
	 ls -lh /var/www/html/$PROJETONAME/ &>> $LOG
	 chgrp -R www-data /var/www/html/$PROJETONAME/ &>> $LOG
	 echo -e "Permissão para o user www-data no diretório /var/www/html/$PROJETONAME/ concedida." &>> $LOG
	 ls -lh /var/www/html/$PROJETONAME/ &>> $LOG
	 echo
	 echo ============================================================ >> $LOG
	 ls -lh /var/www/html/$PROJETONAME/storage &>> $LOG
	 chmod -R 775 /var/www/html/$PROJETONAME/storage &>> $LOG
	 echo -e "Permissão no diretório /var/www/html/$PROJETONAME/storage concedida." &>> $LOG
	 ls -lh /var/www/html/$PROJETONAME/storage &>> $LOG
         echo ============================================================ >> $LOG
         echo -e "Permissões definidas, digite <Enter> para continuar.."
         read
	 echo -e "Criando host virtual, aguarde..." 					 
	 #Copiando arquivo .conf no diretório sites-avalilable
	 cp -v conf/rost-virtual.conf /etc/apache2/sites-available/$PROJETONAME.com.conf &>> $LOG
	 echo -e "Arquivo $PROJETONAME.com.conf, criado com sucesso!!!, continuando o script..."
	 echo
	 echo ============================================================ >> $LOG
	 echo -e "habilitando o novo host virtual, aguarde..."
	 sudo a2ensite $PROJETONAME.com.conf &>> $LOG
	 read
	 echo ============================================================ >> $LOG
	 echo -e "Digite <Enter> para editar arquivo $PROJETONAME.com.conf"
	 read
	 vim /etc/apache2/sites-available/$PROJETONAME.com.conf
	 echo ============================================================ >> $LOG
	 echo -e "Digite <Enter> para reiniciar o apache:"
	 read
	 sudo systemctl restart apache2 &>> $LOG
	 echo
	 echo -e "Digite <Enter> para finalizar o script:"
	 read
 else
	echo -e "Não é root"
 fi
 echo -e "Script finalizado, digite <Enter> sair:"
 read
