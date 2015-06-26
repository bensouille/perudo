#!/bin/bash
# set -x
####PERRUDO SRV####

#### Initialisation des variables ####
#nombre d'utilisateurs connectés
# userco=`who | wc -l`
nomjoueur=`whoami`
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

function joueurs () {
	while true ; do
	clear
	userco=`top -n1 -b | grep perudoclt.sh | sort -u | wc -l`
	intro
	#1er read demande joueurs
		${line} 4 22
		echo -n "${Red}mettre un chiffre entre 2 et 6 please ! ${ResetColor}" &&
		read -r nbjoueurs ; 
	verifnullnum
	verifsup6eq1
	verifsup1userco
	done	
}


#INTRO
function intro () {
 
	${line} 0 20
	echo -e "${Blue}##########################################${ResetColor}"
	${line} 1 20
	echo -e "${Green}#         Bienvenue sur DUDO !!!         #${ResetColor}"
	${line} 2 21
	echo -e "${Green}#         `echo ${userco} "joueurs connectés"`          #${ResetColor}"	 
	${line} 3 20
	echo -e "${Blue}##########################################${ResetColor}"
}

#Verif si vide et num 
function verifnullnum () {
	[ -z ${nbjoueurs} ] || [ ${nbjoueurs} = "" ] && 
	joueurs
	 ${line} 6 22
	echo "${nbjoueurs}" | grep -e '^[[:digit:]]*$'  > /dev/null ;
 	if ! [ $? -eq 0 ] ; then 				
 		echo "${Red}Un chiffre${ResetColor}" && 				
 		sleep 2 &&  			
 		joueurs
 	fi
}

#Verif si plus de 6 joueurs et verif si egal à 1
function verifsup6eq1 () {
	${line} 6 22
	if [ ${nbjoueurs} -gt 6 ] && echo -n "${Red}Attention tu peux pas jouer à plus de 6 !!${ResetColor}" && sleep 2
		then joueurs 
	fi
		${line} 6 22	
		[ ${nbjoueurs} -eq 1 ] && echo -n "${Red}Attention tu peux pas jouer tout seul !!${ResetColor}" && sleep 2
	}

#Verif si sup à 1 et sup à userco
function verifsup1userco () {
	if [ ${nbjoueurs} -gt 1 ] && [ ${nbjoueurs} -gt ${userco} ] ; then
		${line} 6 0	
		echo "${Green}${userco} joueurs connectés : "  
		${line} 7 0	
		echo "${Green}`top -n1 -b | grep perudoclt.sh | cut -d" " -f5 | sort -u` ${ResetColor}" 
		${line} $((8+${userco})) 0
		echo "${Green}Que souhaitez vous faire ? : ${ResetColor}"
		echo "${Green}1) Attendre d'autre joueur ${ResetColor}"
		echo "${Green}2) Redefinir le nombre de joueurs ${ResetColor}"
		echo "${Green}3) quitter le jeu ${ResetColor}" 
		${line} $((14+${userco})) 0
		read -p "${Green}votre choix : ${ResetColor}" choix1
			case "${choix1}" in
				1) attente && break ;;
				2) joueurs ;;
				3) exit ;;
				*) echo "1, 2 ou 3 ! merci !" ;;
			esac
	else 
		[ ${nbjoueurs} -gt 1 ] && 
		[ ${nbjoueurs} -lt ${userco} ] && 
		echo -e "${Green}${userco} joueurs connectés ;) \n`who | cut -d" " -f1 | sort -u` ${ResetColor}" &&
		echo "Que souhaitez vous faire ? " &&
		echo "${Green}1) Deco un user${ResetColor}" &&
		echo "${Green}2) Redefinir le nombre de joueurs ${ResetColor}" &&
		echo "${Green}3) quitter le jeu ${ResetColor}" &&
		read -p "${Green}votre choix : ${ResetColor}" choix2 &&
			case "${choix2}" in
				1) decojoueur ;;
				2) joueurs ;;
				3) exit ;;
				*) echo "1, 2 ou 3 ! merci !" ;;
			esac
		${line} 6 36
		[ ${nbjoueurs} -gt 1 ] && [ ${nbjoueurs} -eq ${userco} ] && 
		clear &&
		${line} 4 28 &&
		echo -n "${Green}Initialisation la partie !${ResetColor}" && 
		break 
	fi
}

function decojoueur () {
echo `who | cut -d" " -f1 | sort -u`
read -p "${Green}nom du joueur à deconnecter : ${ResetColor}" nompts
`sudo pkill -KILL -u ${nompts}`
joueurs
}
	
#Attente de connexion des joueurs
function attente () {
clear
while [ ${userco} -ne ${nbjoueurs} ] ; do
${line} 5 20
	echo -n "${userco} joueur(s) connecté(s) ! On attend sagement, merci |" 
	sleep 0.1  
${line} 5 20
	echo -n "${userco} joueur(s) connecté(s) ! On attend sagement, merci /"
	sleep 0.1 
${line} 5 20
	echo -n "${userco} joueur(s) connecté(s) ! On attend sagement, merci -"
	sleep 0.1 
${line} 5 20
	echo -n "${userco} joueur(s) connecté(s) ! On attend sagement, merci |"
	sleep 0.1 
${line} 5 20
	echo -n "${userco} joueur(s) connecté(s) ! On attend sagement, merci -"
	sleep 0.1 
${line} 5 20
	echo -n "${userco} joueur(s) connecté(s) ! On attend sagement, merci \\"   
	sleep 0.1 
userco=`top -n1 -b | grep perudoclt | sort -u | wc -l`
done
${line} 6 28
echo "${Green}Initialisation la partie !${ResetColor}"
launchgame
}

#Annonce debut de partie et place les joueurs dans un tableau, nom et PID
function launchgame () {
${line} 7 28
	echo "${BlueCyan}NB joueurs connectés : ${userco}${ResetColor}"
${line} 8 28
	echo "${BlueCyan}NB joueurs selectionné : ${nbjoueurs}${ResetColor}"
${line} 8 28
		echo "${Green}Tous les Joueurs sont operationnels${ResetColor}" &&
		sleep 1 &&
		echo "${Green}Definition du premier joueur à commencer ${ResetColor}" 
		sleep 1
a=0
for i in `top -n1 -b | grep perudoclt.sh | awk '{ print $2 }'` ; do
		user_nom[${a}]="${i}"
		a=$(($a+1))
done
echo ${user_nom[*]} > /home/steph/perudo/users
firstplayer
}




function firstplayer () {
	echo "Qui sera le premier joueur ?"
	echo ${userco}
	a=0
}

#Code

joueurs



# $HOME/perudo/perudocheck.sh






