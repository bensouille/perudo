#!/bin/bash
# set -x
####PERRUDO !!!####

#Variables globales du jeu
JOUEUR=`whoami`
DES1=$((RANDOM%6+1))
DES2=$((RANDOM%6+1))
DES3=$((RANDOM%6+1))
DES4=$((RANDOM%6+1))
DES5=$((RANDOM%6+1))
srvco=`top -n1 -b | grep dudo_srv | awk '{ print $2 }' | sort -u | wc -l`
#### Initialisation des variables ####

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


#Attente de lancement de la partie et affichage msg serveur
wait_clt()
{
while true ; do
	nbfifo=`find /tmp/dudo/ -type p | wc -l` 
	userco=`top -n1 -b | grep dudo_clt | awk '{ print $2 }' | sort -u | wc -l`
	[ ${userco} -eq ${nbfifo} ] && break
	echo -en "${userco} joueur(s) connecté(s) ! En attente des autres joueurs et du serveur, merci |\r" 
	sleep 0.5  
	echo -en "${userco} joueur(s) connecté(s) ! En attente des autres joueurs et du serveur, merci /\r"
	sleep 0.5 
	echo -en "${userco} joueur(s) connecté(s) ! En attente des autres joueurs et du serveur, merci -\r"
	sleep 0.5 
	echo -en "${userco} joueur(s) connecté(s) ! En attente des autres joueurs et du serveur, merci |\r"
	sleep 0.5 
	echo -en "${userco} joueur(s) connecté(s) ! En attente des autres joueurs et du serveur, merci -\r"
	sleep 0.5 
	echo -en "${userco} joueur(s) connecté(s) ! En attente des autres joueurs et du serveur, merci \\ \r"   
	sleep 0.5 
done
}



# start() 
# {
# echo -en "En attente du serveur\r"
# while true ; do
# ${line} 5 20	
# [ -e /tmp/perudo_`whoami` ] && cat /tmp/perudo_`whoami` 
# sleep 1
# done
# }




# nomjoueur() 
# {
# Affiche le nom du joueur
# tput cup 3 31
# echo -e "${Red}  Bonjour ${JOUEUR} ${ResetColor}"
# }

# lance() 
# {
# Affiche le premier lancé de dés
# tput cup 4 20
# echo -e "${Blue}         #####################${ResetColor}"
 # 
# tput cup 5 20
# echo -e "${Red}         #       Tour n°x      #${ResetColor}"

# tput cup 6 20
# echo -e "${Green}         #`tput bold`[`if [ ${DES1} = 1 ] ; then echo @ ; else echo ${DES1} ; fi`] [`if [ ${DES2} = 1 ] ; then echo @ ; else echo ${DES2} ; fi`] [`if [ ${DES3} = 1 ] ; then echo @ ; else echo ${DES3} ; fi`] [`if [ ${DES4} = 1 ] ; then echo @ ; else echo ${DES4} ; fi`] [`if [ ${DES5} = 1 ] ; then echo @ ; else echo ${DES5} ; fi`]#${ResetColor}"
 # 
# tput cup 7 20
# echo -e "${Blue}         #####################${ResetColor}"
# }


# function veriftour () {
# if 

# }

# premier() 
# {
# Premiere annonce du premier joueur
# tput cup 8 27
# echo "${Green}Que souhaites-tu annoncer ?${ResetColor}"
# tput cup 9 23
# echo "${Green}Exemples : 2D2 ou 3d5 ou 46 ou 6.4${ResetColor}"
# tput cup 10 0
# echo "${Red}ATTENTION !!! Au premier tour tu n'as pas le droit d'utiliser les DUDO !!!${ResetColor}"
# tput cup 11 0

# if [ -a /tmp/perudo/tour ] ; then
	# cat < ${tour}
# else
	# while read -p "${Green}Ton choix : ${ResetColor}" option1; do
		# echo -n "${Red}Ton choix est${ResetColor} "
	# echo "${option1}" | grep -e '^[[:digit:]]*D[[:digit:]]$' > /dev/null || 
	# echo "${option1}" | grep -e '^[[:digit:]]*d[[:digit:]]$' > /dev/null || 
	# echo "${option1}" | grep -e '^[[:digit:]]*[[:digit:]]$' > /dev/null || 
	# echo "${option1}" | grep -e '^[[:digit:]]*\.[[:digit:]]$' > /dev/null

		# if [ $? -eq 0 ] ; then 
			# echo "${Green}OK${ResetColor}" && break
 		# else 
	 		# echo -n "${Red}mauvais, attention à la syntaxe ! Repeat again : ${ResetColor}" ; 
		# fi
		 # 
	# done
# fi
# }


#Code

wait_clt

verif_srv_co

# start

# nomjoueur

# lance

# premier

# tourpartour



