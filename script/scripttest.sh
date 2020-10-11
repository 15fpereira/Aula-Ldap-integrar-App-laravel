#!/bin/bash
# Criado: 29/06/2020 
# Versão: 0.1 
# # ## Inicio do script ## # 
# Caminho para o Log do scripttest.sh 
LOG="/var/log/scripttest.log" 
# Declaração de variáveis ambiente 
USUARIO=`id -u`
PROJETONAME=blog
# Verificando se o usuário é root 
if [ "$USUARIO" == "0" ]
then
	echo -e "1 - mostrar os processos do sistema:"
	echo -e "2 - Detalhes da memória RAM:"
	echo -e "3 - Informação de kernel:"
	echo
	echo -e "Rodando o Script-06.sh em: `date`" > $LOG
	#         
	echo
	echo ============================================================ >> $LOG 
	echo -e "Click <Enter> para continuar.."
	read
	clear
	#
	echo -e "Digite <Enter> para visualizar processo do sistema:"
	read
	echo         
	top
	echo -e "Fim do processo, click <Enter> para continuar.."
	read 
	#         
	echo -e "Clique <Enter> para checar detalhe da memória RAM:"
	read
	free -m -h >> $LOG
	echo -e "Fim do processo, click <Enter> para continuar.."
	echo
	echo -e "Digite <Enter> para checar informações do Kernel:"
	read
	dmesg -L -T >> $LOG
	echo -e "Fim do processo, click <Enter> para continuar.."
	read
else
	echo -e "Usuário não é root, fim do processo, click <Enter> para continuar.."
	read
fi
	
