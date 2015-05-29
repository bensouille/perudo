#!/bin/bash

####PERRUDO SRV####

#### Initialisation des variables ####
#nombre d'utilisateurs connectés
userco=`who | wc -l`

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
# Effacement du terminal
	clear
	  
	${line} 0 20
	echo -e "${Blue}##########################################${ResetColor}"
	 
	${line} 1 20
	echo -e "${Green}#         Bienvenue sur DUDO !!!         #${ResetColor}"

	${line} 2 20
	echo -e "${Green}#           Le POKER des dés             #${ResetColor}"
	 
	${line} 3 20
	echo -e "${Blue}##########################################${ResetColor}"

}


function joueurs () {
#Defini le nombre de joueurs
	
${line} 4 30		
echo -n "combien de joueurs ? : " 

while true ; do
${line} 5 30
read -r nbjoueurs
	echo -n "${Red}Ton choix est ${nbjoueurs}${ResetColor} "
	if [ ${nbjoueurs} -le 6 ] ; 
		then echo "C'est tout bon !" ; break ; 
${line} 5 30		
		else echo -n "${Red}Trop de joueurs ! Repeat again : ${ResetColor}" ; 
	fi 
		done 

}


function attente () {
# Attente des joueurs
	${line} 7 30
	echo " nb joueurs connectés : ${userco}"
	${line} 8 30
	echo " nb joueurs selectionné : ${nbjoueurs}"

	${line} 9 30
	while [ ${userco} -lt ${nbjoueurs} ]
	 do
		echo -e "en attente des joueurs"
		sleep 60
	done

	echo "lancement de la partie !"

}

#Code

intro

joueurs

attente

$HOME/perudo/perudoclt.sh






