#!/bin/bash
# Criado: 29/06/2020
# Atualizado 11/10/2020
# Versão: 0.2
# # ## Inicio do script ## #
# Caminho para o Log do 4script-install-configuration-myslq-lamp-python.sh
LOG="/var/log/4script-install-configuration-myslq.log"
# Declaração de variáveis ambiente
USUARIO=`id -u`
# Variáveis de configuração do MySQL
PASSWORD="PassWS20"
AGAIN="PassWS20"
USER="root"
GRANTALL="GRANT ALL ON *.* TO root@'%' IDENTIFIED BY 'PassWS20';"
#
# Variáveis de configuração do ProFTPD
INETD="standalone"
#
# Variáveis de configuração do PhpMyAdmin
APP_PASSWORD="PassWS20"
ADMIN_PASS="PassWS20"
APP_PASS="PassWS20"
WEBSERVER="apache2"
ADMINUSER="root"
# Verificando se o usuário é root
if [ "$USUARIO" == "0" ]
 then
         echo -e "1 - Instalar MYSQL:"
         echo -e "2 - Configuração do MySQL:"
         echo -e "3 - Configuração do PhpMyAdmin:"
	 echo
         echo -e "Rodando o 4script-install-configuration-myslq.sh em: `date`" >> $LOG
	 echo ============================================================ >> $LOG
	 echo -e "Atualizando as Listas do Apt, aguarde..."
 	 #Atualizando as listas do apt
 	 apt update &>> $LOG
	 echo -e "Listas Atualizadas com Sucesso!!!, continuando o script..."
	 echo
 	 echo ============================================================ >> $LOG
	 echo ============================================================ >> $LOG
	 echo -e "Atualizando o Sistema, aguarde..."
	 #Fazendo a atualização de todos os pacotes instalados no servidor
 	 apt -o Dpkg::Options::="--force-confold" upgrade -q -y --force-yes &>> $LOG
 	 echo -e "Sistema Atualizado com Sucesso!!!, continuando o script..."
	 echo
	 echo ============================================================ >> $LOG
	 echo -e "Instalando o LAMP-SERVER, aguarde..."
	 echo
	 echo -e "Configurando as variáveis do MySQL para o apt, aguarde..."
	 #Configurando as variáveis do Debconf para a instalação do MySQL em modo Noninteractive
	 echo "mysql-server-5.7 mysql-server/root_password password $PASSWORD" | debconf-set-selections
	 echo "mysql-server-5.7 mysql-server/root_password_again password $AGAIN" | debconf-set-selections
	 echo -e "Variáveis configuradas com sucesso!!!, continuando o script..." 
	 sleep 2
	 echo
	 #Mostrando as configuração do Debconf para o MySQL
	 debconf-show mysql-server-5.7 >> $LOG
	 echo -e "Instalando o LAMP Server, aguarde..."
	 #Instalando o LAMP-Server com as variáveis do MySQL
	 apt -y install lamp-server^ perl python links2 &>> $LOG
	 echo -e "Instalação do LAMP-SERVER Feito com Sucesso!!!, continuando o script..."
	 echo
	 sleep 2
	 echo ============================================================ >> $LOG
	 echo -e "Instalando o PhpMyAdmin, aguarde..."
	 echo
	 echo -e "Configurando as váriaveis do PhpMyAdmin para o apt, aguarde..."
	 #Configurando as variáveis do Debconf para a instalação do PhpMyAdmin em modo Noninteractive
	 echo "phpmyadmin phpmyadmin/internal/skip-preseed boolean true" | debconf-set-selections
	 echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
	 echo "phpmyadmin phpmyadmin/app-password-confirm password $APP_PASSWORD" | debconf-set-selections
	 echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect $WEBSERVER" | debconf-set-selections
 	 echo "phpmyadmin phpmyadmin/mysql/admin-user string $ADMINUSER" | debconf-set-selections
 	 echo "phpmyadmin phpmyadmin/mysql/admin-pass password $ADMIN_PASS" | debconf-set-selections
	 echo "phpmyadmin phpmyadmin/mysql/app-pass password $APP_PASS" | debconf-set-selections
	 echo -e "Variáveis configuradas com sucesso!!!, continuando o script..."
	 sleep 2
	 echo
	 #Mostrando as configuração do Debconf para o PhpMyAdmin
	 debconf-show phpmyadmin >> $LOG
	 echo -e "Instalando o PhpMyAdmin, aguarde..."
	 #Instalando o PhpMyAdmin
	 apt -y install phpmyadmin php-mbstring php-gettext &>> $LOG
	 echo -e "Instalação do PhpMyAdmin feita com sucesso!!!, continuando o script..."
	 sleep 2
	 echo
	 echo -e "Reinicializando o serviço do Apache2, aguarde..."
 	 #Reinicializando o serviço do Apache2 Server
	 sudo service apache2 restart
	 echo -e "Serviço reinicializado com sucesso!!!, continuando o script..."
	 sleep 2
	 echo
	 echo -e "APACHE2 configurado com sucesso!!!, pressione <Enter> para continuar"
	 read
	 sleep 2
	 clear
	 echo -e "Permitindo o usuário Root se logar remotamente no servidor de MySQL, aguarde..."
	 #Permitindo o usuário Root acessar o servidor do MySQL remoto
	 #Alterando o Banco de Dados do MySQL
	 mysql -u $USER -p$PASSWORD -e "$GRANTALL" mysql &>> $LOG
	 echo -e "Permissão aplicada com sucesso!!!, continuando o script..."
	 sleep 2
	 echo
	 echo -e "Testando as configurações do MySQLD, aguarde..."
 	 echo
 	 #Verificando as configurações do servidor de MySQL
 	 mysqld --help --verbose | grep /etc
 	 echo
	 echo -e "Arquivo testado com sucesso!!!, continuando o script..."
	 sleep 2
	 echo
	 echo -e "Reinicializando o servidor do MySQL, aguarde..."
 	 #Reinicializando o serviço do MySQL Server
	 sudo service mysql restart
	 echo -e "Serviços do MySQL reinicializado com sucesso!!!, continuando o script..."
 	 sleep 2
	 echo
	 echo -e "MYSQLD configurado com sucesso!!!, pressione <Enter> para continuar"
	 read
	 sleep 2
	 clear
	 echo ============================================================ >> $LOG
else
	 echo -e "Não é root"
fi
echo -e "Script finalizado, digite <Enter> sair:"
read
