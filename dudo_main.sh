#!/usr/bin/env bash

# set -x

####PERRUDO SRV####

#### Initialisation des variables ####
#nombre d'utilisateurs connectés
# userco=`who | wc -l`
nomjoueur=`whoami`
userco=`top -n1 -b | grep perudoclt | awk '{ print $2 }' | wc -l`
#numerotation des lignes
line='tput cup'
#+ Mode normal
ResetColor="$(tput sgr0)"
# "Surligné" (bold)
bold="$(tput smso)"
# "Non-Surligné" (offbold)
offbold="$(tput rmso)"

# Couleurs (gras)
#+ Rouge
Red="$(tput bold ; tput setaf 1)"
#+ Vert
Green="$(tput bold ; tput setaf 2)"
#+ Jaune
Yellow="$(tput bold ; tput setaf 3)"
#+ Bleue
Blue="$(tput bold ; tput setaf 4)"
#+ Cyan
BlueCyan="$(tput bold ; tput setaf 6)"


#### Fin initialisation variables ####

######################################
############FONCTIONS#################
######################################

clean_up()	
{
	clear
	rm -f /tmp/perudo_*
}

display_header()
{
	userco=`top -n1 -b | grep perudoclt | awk '{ print $2 }' | wc -l`
	# ${line} 0 20
	echo -e "${Blue}##########################################${ResetColor}"
	# ${line} 1 20
	echo -e "${Green}#         Bienvenue sur DUDO !!!         #${ResetColor}"
	# ${line} 2 21
	echo -e "${Green}#         `echo ${userco} "joueurs connectés"`          #${ResetColor}"	 
	# ${line} 3 20
	echo -e "${Blue}##########################################${ResetColor}"
}

get_nb_player()
{
while true ; do
clean_up
display_header
${line} 4 0
echo -n "${Red}Mettre un chiffre entre 2 et 6 please ! ${ResetColor}"
read -r nbjoueurs
	if [ "${nbjoueurs}" -gt 6 ] 
		then 
		echo -en "${Red}Attention tu ne peux pas jouer à plus de 6 !!${ResetColor}\r"
			${line} 4 0
			sleep 2 
			elif [ "${nbjoueurs}" -eq 1 ] 
				then 
				echo -n "${Red}Attention tu ne peux pas jouer tout seul !!${ResetColor}" && 
				sleep 2
		else
			break
	fi
done
}

#Verif si sup à 1 et sup à userco
verif_sup_1()
{
	if [ "${nbjoueurs}" -gt "${userco}" ] ; then
		# ${line} 6 0	
		echo "${Green}${userco} joueurs connectés : "  
		# ${line} 7 0	
		echo "${Green}`top -n1 -b | grep perudoclt | cut -d" " -f5 | sort -u` ${ResetColor}" 
		# ${line} $((8+${userco})) 0
		echo "${Green}Que souhaitez vous faire ? : ${ResetColor}"
		echo "${Green}1) Attendre d'autre joueur ${ResetColor}"
		echo "${Green}2) Redefinir le nombre de joueurs ${ResetColor}"
		echo "${Green}3) quitter le jeu ${ResetColor}" 
		# ${line} $((14+${userco})) 0
		read -p "${Green}votre choix : ${ResetColor}" choix1
			case "${choix1}" in
				1) wait_player && break ;;
				2) get_nb_player ;;
				3) exit ;;
				*) echo "1, 2 ou 3 ! merci !" ;;
			esac
	fi
}

verif_sup_userco()  
{  
	[ "${nbjoueurs}" -gt 1 ] && 
	[ "${nbjoueurs}" -lt "${userco}" ] && 
		echo -e "${Green}${userco} joueurs connectés ;) \n`who | cut -d" " -f1 | sort -u` ${ResetColor}" &&
		echo "Que souhaitez vous faire ? " &&
		echo "${Green}1) Deco un user${ResetColor}" &&
		echo "${Green}2) Redefinir le nombre de joueurs ${ResetColor}" &&
		echo "${Green}3) quitter le jeu ${ResetColor}" &&
		read -p "${Green}votre choix : ${ResetColor}" choix2 &&
			case "${choix2}" in
				1) deco_joueur ;;
				2) get_nb_player ;;
				3) exit ;;
				*) echo "1, 2 ou 3 ! merci !" ;;
			esac
}

verif_eq_userco()
{
# ${line} 6 36
		[ "${nbjoueurs}" -gt 1 ] && [ "${nbjoueurs}" -eq "${userco}" ] && 
		clear &&
		# ${line} 4 28 &&
		echo -n "${Green}Initialisation la partie !${ResetColor}" && 
		start_game
}		


deco_joueur() 
{
echo `who | cut -d" " -f1 | sort -u`
read -p "${Green}nom du joueur à deconnecter : ${ResetColor}" nompts
`sudo pkill -KILL -u ${nompts}`
main
}

# wait_player()
# {

# }


#######CODE#######

get_nb_player

verif_sup_1

verif_sup_userco

verif_eq_userco



