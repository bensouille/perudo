#!/usr/bin/env bash

set -x

####PERRUDO SRV####

#### Initialisation des variables ####
#nombre d'utilisateurs connectés
# userco=`who | wc -l`
nomjoueur=`whoami`
userco=`top -n1 -b | grep dudo_clt | awk '{ print $2 }' | sort -u | wc -l`
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
	stop_proc_dudo_clt
	rm -f /tmp/dudo/dudo_*
}

stop_proc_dudo_clt()
{
	while [ ${userco} -gt 0 ] ; do
			userco=`top -n1 -b | grep dudo_clt | awk '{ print $2 }' | sort -u | wc -l`	
			echo "${Green}Plusieurs dudo_clt sont lancés${ResetColor}"
			echo "${Green}Que souhaitez vous faire ? : ${ResetColor}"
			echo "${Green}1) Les stopper${ResetColor}"
			echo "${Green}2) Continuer${ResetColor}"
			echo "${Green}3) Quitter le jeu ${ResetColor}" 
			# ${line} $((14+${userco})) 0
			read -p "${Green}votre choix : ${ResetColor}" choix1			
			case "${choix1}" in
					1) sudo pkill -KILL dudo_clt.sh ;;
					2) break 2 ;;
					3) exit ;;
					*) echo "1, 2 ou 3 ! merci !" ;;	
			esac
	done
}

display_header()
{
	userco=`top -n1 -b | grep dudo_clt | awk '{ print $2 }' | sort -u | wc -l`
	# ${line} 0 20
	echo -e "${Blue}##########################################${ResetColor}"
	# ${line} 1 20
	echo -e "${Green}#         Bienvenue sur DUDO !!!         #${ResetColor}"
	# ${line} 2 21
	echo -e "${Green}#         `echo ${userco} "joueurs connectés"`            #${ResetColor}"	 
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
echo "${nbjoueurs}" | grep -e '^[[:digit:]][[:digit:]]*$'  > /dev/null ;	# entrée envoi ^$ / * = The preceding item will be matched zero or more times 
 	if ! [ $? -eq 0 ]  
 		then 				
 			echo "${Red}Un chiffre${ResetColor}"				
 			sleep 2 			
				elif [ "${nbjoueurs}" -gt 6 ] 
					then 
						echo -en "${Red}Attention tu ne peux pas jouer à plus de 6 !!${ResetColor}\r"
						${line} 4 0
						sleep 2 
							elif [ "${nbjoueurs}" -eq 1 ] || [ "${nbjoueurs}" -eq 0 ] 
								then 
									echo -n "${Red}Plus de 1, merci !!${ResetColor}"
									sleep 2
		else
			break
	fi
done
}

#Verif si sup à 1 et sup à userco
verif_gt_userco()
{
userco=`top -n1 -b | grep dudo_clt | awk '{ print $2 }' | sort -u | wc -l`
if [ "${nbjoueurs}" -gt "${userco}" ] ; then
	# ${line} 6 0	
	echo "${Green}${userco} joueurs connectés : "  
	# ${line} 7 0	
	echo "${Green}`top -n1 -b | grep dudo_clt | cut -d" " -f5 | sort -u` ${ResetColor}" 
	# ${line} $((8+${userco})) 0
	echo "${Green}Que souhaitez vous faire ? : ${ResetColor}"
	echo "${Green}1) Attendre d'autre joueur ${ResetColor}"
	echo "${Green}2) Redefinir le nombre de joueurs ${ResetColor}"
	echo "${Green}3) quitter le jeu ${ResetColor}" 
	# ${line} $((14+${userco})) 0
	read -p "${Green}votre choix : ${ResetColor}" choix1			
	case "${choix1}" in
			1) wait_player ;;
			2) get_nb_player ;;
			3) exit ;;
			*) echo "1, 2 ou 3 ! merci !" ;;			
	esac
fi
}

verif_lt_userco()  
{  
userco=`top -n1 -b | grep dudo_clt | awk '{ print $2 }' | sort -u | wc -l`
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
userco=`top -n1 -b | grep dudo_clt | awk '{ print $2 }' | sort -u | wc -l`
if	[ ${nbjoueurs} -gt 1 ] && [ ${nbjoueurs} -eq ${userco} ]  
	then
		start_game
fi
}		

deco_joueur() 
{
echo `who | cut -d" " -f1 | sort -u`
read -p "${Green}nom du joueur à deconnecter : ${ResetColor}" nompts
`sudo pkill -KILL -u ${nompts}`
get_nb_player
}

wait_player()
{
while true ; do
	userco=`top -n1 -b | grep dudo_clt | awk '{ print $2 }' | sort -u | wc -l`
	[ ${userco} -eq ${nbjoueurs} ] && break
	echo -en "${userco} joueur(s) connecté(s) ! En attente des autres joueurs, merci |\r" 
	sleep 0.5  
	echo -en "${userco} joueur(s) connecté(s) ! En attente des autres joueurs, merci /\r"
	sleep 0.5 
	echo -en "${userco} joueur(s) connecté(s) ! En attente des autres joueurs, merci -\r"
	sleep 0.5 
	echo -en "${userco} joueur(s) connecté(s) ! En attente des autres joueurs, merci |\r"
	sleep 0.5 
	echo  -en "${userco} joueur(s) connecté(s) ! En attente des autres joueurs, merci -\r"
	sleep 0.5 
	echo -en "${userco} joueur(s) connecté(s) ! En attente des autres joueurs, merci \\ \r"   
	sleep 0.5 
done
echo "${Green}Tous les joueurs sont connectés${ResetColor}"
echo "${Green}Initialisation la partie !${ResetColor}"
}

init_sub_sys() 
{
if ! [ -d /tmp/dudo ]
	then 
		mkdir /tmp/dudo
	else
		for f in `top -n1 -b | grep dudo_clt | awk '{ print $2 }' | sort -u` ; do
			if  [ ! -e /tmp/dudo/dudo_${f} ]
				then
				mkfifo /tmp/dudo/dudo_${f}	
			fi
			sleep 1
		done
fi
}

start_game() 
{
userco=`top -n1 -b | grep dudo_clt | awk '{ print $2 }' | sort -u | wc -l`
init_sub_sys
# ${line} 7 28
echo "${BlueCyan}NB joueurs connectés : ${userco}${ResetColor}"
# ${line} 8 28
echo "${BlueCyan}NB joueurs selectionné : ${nbjoueurs}${ResetColor}"
# ${line} 9 28
echo "${Green}Tous les Joueurs sont operationnels${ResetColor}"	
sleep 1
# ${line} 10 28
echo "${Green}Definition du premier joueur à commencer ${ResetColor}" 
sleep 1
array_users
firstplayer
}

#Initialise le tableau du nom des users	
array_users() 
{
a=0	
for i in `top -n1 -b | grep dudo_clt | awk '{ print $2 }' | sort -u` ; do
		users_nom[${a}]="${i}"
		a=$(($a+1))

done
echo ${users_nom[*]} > /$HOME/perudo/users
}

#Definit le premier joueur
firstplayer() 
{
# ${line} 11 28
echo "${Green}Qui sera le premier joueur ?${ResetColor}"	
# random sur valeur du tableau
i=$(echo $((RANDOM%`cat users | wc -w`))) 
first=$(echo "${Green}${users_nom[${i}]}${ResetColor}")
echo ${first}
}

#######CODE#######
clean_up

get_nb_player

verif_gt_userco

verif_lt_userco

verif_eq_userco

start_game

