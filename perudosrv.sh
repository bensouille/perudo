#!/bin/bash
# set -x
####PERRUDO SRV####

#### Initialisation des variables ####
#nombre d'utilisateurs connectés
# userco=`who | wc -l`

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

# Fonctions
 
function intro () {

while true ; do

clear

userco=`who | wc -l`

#INTRO 
	${line} 0 20
	echo -e "${Blue}##########################################${ResetColor}"
	 
	${line} 1 20
	echo -e "${Green}#         Bienvenue sur DUDO !!!         #${ResetColor}"

	${line} 2 21
	echo -e "${Green}#         `echo ${userco} "joueurs connectés"`          #${ResetColor}"
	 
	${line} 3 20
	echo -e "${Blue}##########################################${ResetColor}"

#1er read demande joueurs
	${line} 4 22
	echo -n "${Red}mettre un chiffre entre 2 et 6 please ! ${ResetColor}" &&
	read -r nbjoueurs ; 

#Verif si vide et num	
	[ -z ${nbjoueurs} ] || [ ${nbjoueurs} = "" ] && 
	intro
		${line} 6 22
	echo "${nbjoueurs}" | grep -e '^[[:digit:]]*$'  > /dev/null ;
 		if ! [ $? -eq 0 ] ; 
 			then
 				echo "${Red}Un chiffre${ResetColor}" &&
 				sleep 2 && 
 				intro
 		fi

#Verif si plus de 6 joueurs
	${line} 6 22
	if [ ${nbjoueurs} -gt 6 ] && echo -n "${Red}Attention tu peux pas jouer à plus de 6 !!${ResetColor}" && sleep 2
		then intro 
	fi

#Verif si egal à 1
	${line} 6 22	
	[ ${nbjoueurs} -eq 1 ] && echo -n "${Red}Attention tu peux pas jouer tout seul !!${ResetColor}" && sleep 2

#Verif si sup à 1 et sup à userco	
	if [ ${nbjoueurs} -gt 1 ] && [ ${nbjoueurs} -gt ${userco} ] ; then
	${line} 6 0	
	echo "${Green}${userco} joueurs connectés seulement : "  
	echo -e "`who | cut -d" " -f1` ${ResetColor}" 
	${line} $((7+${userco})) 0
	echo "${Green}Que souhaitez vous faire ? : ${ResetColor}"
	echo "${Green}1) Attendre d'autre joueur ${ResetColor}"
	echo "${Green}2) Redefinir le nombre de joueurs ${ResetColor}"
	echo "${Green}3) quitter le jeu ${ResetColor}" 
	${line} $((11+${userco})) 0
	read -p "${Green}votre choix : ${ResetColor}" option
	case "${option}" in
		1) attente ;;
		2) intro ;;
		3) exit ;;
		*) echo "1, 2 ou 3 ! merci !" ;;
	esac

	

	else 
	[ ${nbjoueurs} -gt 1 ] && 
	[ ${nbjoueurs} -lt ${userco} ] && 
	echo -e "${Green}${userco} joueurs connectés, deconnectez un user ! ;) \n`who | cut -d" " -f1` ${ResetColor}" &&
	sleep 3

	[ ${nbjoueurs} -gt 1 ] && [ ${nbjoueurs} -eq ${userco} ] && 
	echo -n "${Green}ok Go${ResetColor}" && 
	break 
	fi
		# case 



done

#Sortie de boucle, affichage de NB joueurs co et select 
	${line} 7 30
	echo "${BlueCyan}NB joueurs connectés : ${userco}${ResetColor}"
	${line} 8 30
	echo "${BlueCyan}NB joueurs selectionné : ${nbjoueurs}${ResetColor}"

}


##################### 1ere version fonction joueurs######################
#########################################################################
# #Defini le nombre de joueurs											#
# while true ; do 														#
# ${line} 4 22 															#
# echo -n "${Red}Nouvelle partie, combien de joueurs ? : ${ResetColor}" #
# read -r nbjoueurs														#
# ${line} 5 25															#																			
# echo -e "${Green}Ton choix est ${nbjoueurs}${ResetColor} " ;			#														
# ${line} 6 25															#		
# if [ -z ${nbjoueurs} ] ;
	# then
		# echo "mettre un chiffre ! ;) " ;
	# else
		# echo "${nbjoueurs}" | grep -e '^[[:digit:]]*$' > /dev/null ;
			# if  [ $? -eq 0 ] ; 
				# then
					# if [ ${nbjoueurs} -le 6 ] && [ ${nbjoueurs} -gt 1 ] && [ ${nbjoueurs} -eq ${userco} ] ; 				
						# then  
							# echo "${Green}Impec ${ResetColor}" 
							# break 
							# if ! [ ${nbjoueurs} -ge 6 ] ;
								# then 
									# ${line} 6 25
									# echo "${Blue}En attente des joueurs !${ResetColor}" 
							# fi			
					# fi
						
				# else
					# echo -n "${Green}mettre un chiffre entre 2 et 6 please ! ${ResetColor}" ;
			#  											  #						
# fi																	#
# done 																	#
#########################################################################

# function attente () {
# # Attente des joueurs
# 	clear
# 	while true ; do 
# 	userco=`who | wc -l`
# 	${line} 1 30
# 	if [ ${userco} -eq ${nbjoueurs} ] ; 
# 		then break ;
# 		else echo -e "${BlueCyan}En attente des joueurs...${ResetColor}" ;
# 			for a in 5 4 3 2 1 0
# 				do
# 					${line} 2 30
# 					echo "${a}"
# 				done
# 	fi
# 	done
# }

function attente () {

  printf "Attente."
  while true ; do
  	userco=`who | wc -l`
	if ! [ ${userco} -eq ${nbjoueurs} ] ; then
    printf "."
    sleep 1
	else
		clear
		break
	fi
  done

echo "${Green}lancement de la partie !${ResetColor}"

$HOME/perudo/perudoclt.sh

}

	



#Code

intro

$HOME/perudo/perudoclt.sh






