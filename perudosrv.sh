#!/bin/bash
# set -x
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

	${line} 2 21
	echo -e "${Green}#         `echo ${userco} "joueurs connectés"`          #${ResetColor}"
	 
	${line} 3 20
	echo -e "${Blue}##########################################${ResetColor}"

}


function joueurs () {

while true ; do
${line} 4 22

	echo -n "${Red}mettre un chiffre entre 2 et 6 please ! ${ResetColor}" && read -r nbjoueurs; 
${line} 4 62	
	[ -z ${nbjoueurs} ] || [ ${nbjoueurs} = "" ] && joueurs ;
	
${line} 5 22
	echo "${nbjoueurs}" | grep -e '^[[:digit:]]*$'  > /dev/null ;
 		if ! [ $? -eq 0 ] ; 
 			then
 				echo "${Red}Un chiffre${ResetColor}" && joueurs ; 
 		fi
${line} 5 22
if [ ${nbjoueurs} -gt 6 ] && echo -n "${Red}Attention tu peux pas jouer à plus de 6 !!${ResetColor}" ; 
	then joueurs ;
fi
${line} 6 22	
	[ ${nbjoueurs} -eq 1 ] && echo -n "${Red}Attention tu peux pas jouer tout seul !!${ResetColor}" ;
${line} 5 22	
if [ ${nbjoueurs} -gt 1 ] && [ ${nbjoueurs} -gt ${userco} ] ; 
		then
${line} 5 22		
			echo -n "${Green}Pas assez de joueurs connectés : ${userco}" ; echo -en  "\n`who | cut -d" " -f1` ${ResetColor}"
${line} $((6+${userco})) 22
			echo "Que souhaitez vous faire ? : "
			echo "1) Attendre d'autre joueur "
			echo "2) Redefinir le nombre de joueurs "
			echo "3) quitter le jeu " 
		else 
			[ ${nbjoueurs} -gt 1 ] && [ ${nbjoueurs} -lt ${userco} ] && echo -e "${Green}${userco} connectés, deconnectez un user ! ;) \n `who | cut -d" " -f1` ${ResetColor}" ;

			[ ${nbjoueurs} -gt 1 ] && [ ${nbjoueurs} -eq ${userco} ] && echo -n "${Green}ok Go${ResetColor}" && break ;
	fi
	# case 

	

	
done

# #Defini le nombre de joueurs
# while true ; do
# ${line} 4 22
# echo -n "${Red}Nouvelle partie, combien de joueurs ? : ${ResetColor}"
# read -r nbjoueurs
# ${line} 5 25
# echo -e "${Green}Ton choix est ${nbjoueurs}${ResetColor} " ;
# ${line} 6 25
# if [ -z ${nbjoueurs} ] ;
# 	then
# 		echo "mettre un chiffre ! ;) " ;
# 	else
# 		echo "${nbjoueurs}" | grep -e '^[[:digit:]]*$' > /dev/null ;
# 			if  [ $? -eq 0 ] ; 
# 				then
# 					if [ ${nbjoueurs} -le 6 ] && [ ${nbjoueurs} -gt 1 ] && [ ${nbjoueurs} -eq ${userco} ] ; 				
# 						then  
# 							echo "${Green}Impec ${ResetColor}" 
# 							break 
# 							if ! [ ${nbjoueurs} -ge 6 ] ;
# 								then 
# 									${line} 6 25
# 									echo "${Blue}En attente des joueurs !${ResetColor}" 
# 							fi			
# 					fi
						
# 				else
# 					echo -n "${Green}mettre un chiffre entre 2 et 6 please ! ${ResetColor}" ;
# 			fi
# fi

# done 

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






