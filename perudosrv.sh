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
echo -n "${Red}Combien de joueurs ? : ${ResetColor}" 

while true ; do
	
	read -r nbjoueurs

${line} 5 25
	echo -n "${Green}Ton choix est ${nbjoueurs}${ResetColor} "
	
	if [ ${nbjoueurs} -le 6 ] ; 
	
		then echo "${Green}C'est tout bon !${ResetColor}" ; break ; 
${line} 6 20		

		else echo -n "${Red}Trop de joueurs ! Repeat again : ${ResetColor}" ; 
	
	fi 
		done 

${line} 7 30
	echo "${BlueCyan}NB joueurs connectés : ${userco}${ResetColor}"
${line} 8 30
	echo "${BlueCyan}NB joueurs selectionné : ${nbjoueurs}${ResetColor}"
}


function attente () {
# Attente des joueurs
	

	${line} 9 30
	while true ; do 
	userco=`who | wc -l`
	${line} 9 30
	if [ ${userco} -eq ${nbjoueurs} ] ; 
		then break ;
		else echo -e "${BlueCyan}En attente des joueurs...${ResetColor}" ;
			for a in 5 4 3 2 1 0
				do
					${line} 10 30
					echo "${a}"
				done

	fi
	done

	echo "${Green}lancement de la partie !${ResetColor}"

}

#Code

intro

joueurs

attente

$HOME/perudo/perudoclt.sh






