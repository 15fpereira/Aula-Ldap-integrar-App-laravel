#!/bin/bash 
# Autor: Francisco Dias 
# Criado: 21/06/2020 
# Versão: 0.1 
# # ## Inicio do script ## # 
# Caminho para o Log do 3script-configuration-laravel
LOG="/var/log/3script-configuration-laravel.log"
# Declaração de variáveis 
USUARIO=`id -u` 
PROJETONAME=blog 
# Verificando se o usuário é root 
if [ "$USUARIO" == "0" ] 
then         
	echo
	echo -e "1 - Criar um novo host virtual:"
	echo -e "2 - Desabilitar a configuração padrão do arquivo dos hosts virtuais:"
	echo -e "3 - Habilite o novo host virtual com o comando a seguir:"
	echo -e "4 - Habilite o módulo de regravação do Apache:"
	echo -e "3 - Desabilitar a configuração padrão do arquivo dos hosts virtuais:"
	echo
	echo
	echo -e "Atualizando o arquivo auto.itsm.com.conf, aguarde..."
	read
	#Copiando o arquivo de configuranção do aauto.itsm.com.conf.conf
	cp -v conf/auto.itsm.com.conf /etc/apache2/sites-enabled/auto.itsm.com.conf
	echo -e "Arquivo atualizado com sucesso!!!, continuando o script..." 					 
	echo 					 					 
	#Editando o arquivo de configuração smb.conf
	vim /etc/apache2/sites-enabled/auto.itsm.com.conf
	echo
	echo -e "Digite <Enter> para continuar.."
	read
	echo
	echo -e "Desabilitar a configuração padrão do arquivo dos hosts virtuais, digite <Enter> para continuar:"
	read
	cd /etc/apache2/sites-available
	a2dissite 000-default.conf
	echo
	echo -e "Habilite o novo host virtual com o comando a seguir:"
	read
	cd /etc/apache2/sites-available
	a2ensite auto.itsm.com.conf
	echo
	echo -e "Habilite o módulo de regravação do Apache, digite <Enter> para continuar:"
	read
	a2enmod rewrite
	echo
	echo -e "Digite <Enter> para reiniciar o serviços do Apache:"
	systemctl restart apache2
	echo -e "Pressione <Enter> para finalizar o script"
	read

else
echo -e "Não é root"
fi 
echo -e "Script finalizado, digite <Enter> sair:"
read
