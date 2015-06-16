#!/bin/bash
# set -x

#### Initialisation des variables ####

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

#Verifie si tous les joueurs ont bien lancé le jeu
function launchgame () {
#nb d'user connectés 
userco=`who | cut -d" " -f1 | sort -u | wc -l`
#nb de script perudoclt lancé
psperu=`ps aux | grep perudocheck | cut -d" " -f1 | sort -u | wc -l`


[ ${psperu} -eq ${userco} ] && 
echo "${Green}Tous les Joueurs sont operationnels${ResetColor}" &&
sleep 1 &&
echo "${Green}Definition du premier joueur à commencer ${ResetColor}" 
sleep 1

[ ${psperu} -ne ${userco} ] && 
echo "${Red}En attentes des autres joueurs.${ResetColor}" && 
while true ; do
sleep 1
#nb d'user connectés
userco=`who | cut -d" " -f1 | sort -u | wc -l`
#nb de script perudoclt lancé
psperu=`ps aux | grep perudocheck | cut -d" " -f1 | sort -u | wc -l`
  	if ! [ ${psperu} -eq ${userco} ] ; then
    	echo -n "${Red}.${ResetColor}"
    	sleep 1
	else
		clear
		echo "${Green}Tous les Joueurs sont operationnels${ResetColor}" 
		sleep 1 
		echo "${Green}Definition du premier joueur à commencer ${ResetColor}"
		sleep 1
		break
	fi
  done
}

#Definie le premier joueur




function tourpartour () {
#definition variable i

#boucle de tour
for i in `who` ; do
	nom=`echo ${i} | cut -d"" -f1`

	if ! [ -a /tmp/perudo/tour* ] ; then
				mkfifo /tmp/perudo/tour_${i}
				echo "tour N°$((${i}+1)) de `whoami`, il propose ${option1} en attente du joueur suivant" > ${tour} ;
			
	else
		cat < ${tour}
		

fi
done
}

launchgame