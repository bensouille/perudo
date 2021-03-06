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

main() 
{
	rm -f /tmp/*
	while true ; do
	userco=`top -n1 -b | grep perudoclt | awk '{ print $2 }' | wc -l`
	intro
	#1er read demande joueurs
		# ${line} 4 22
		echo -n "${Red}Mettre un chiffre entre 2 et 6 please ! ${ResetColor}" &&
		read -r nbjoueurs ; 
	verif_null_num
	verif_sup6_eq1
	verif_sup1_userco
	done
		
}
# Creer un fichier fifo pour chaque joueurs
check_clt () 
{
for f in `top -n1 -b | grep perudoclt | awk '{ print $2 }'` ; do
	if  [ ! -e /tmp/perudo_${f} ]
		then
		mkfifo /tmp/perudo_${f}	
	fi
	sleep 1
done
}

#equivalent d'un echo sur serveur et sur client via fifo
log()
{
echo -en "${1}"
if [ $(top -n1 -b | grep perudoclt | awk '{ print $2 }' | wc -l) > 0 ] ; 
	then
		for p in `top -n1 -b | grep perudoclt | awk '{ print $2 }'` ; do
		echo -en ${1} > /tmp/perudo_${p} 
		done
fi
}

#INTRO
intro() 
{
 
	# ${line} 0 20
	echo -e "${Blue}##########################################${ResetColor}"
	# ${line} 1 20
	echo -e "${Green}#         Bienvenue sur DUDO !!!         #${ResetColor}"
	# ${line} 2 21
	echo -e "${Green}#         `echo ${userco} "joueurs connectés"`          #${ResetColor}"	 
	# ${line} 3 20
	echo -e "${Blue}##########################################${ResetColor}"
}

#Verif si vide et num 
verif_null_num() 
{
	[ -z ${nbjoueurs} ] || [ ${nbjoueurs} = "" ] && 
	main
	 # ${line} 6 22
	echo "${nbjoueurs}" | grep -e '^[[:digit:]]*$'  > /dev/null ;
 	if ! [ $? -eq 0 ] ; then 				
 		echo "${Red}Un chiffre${ResetColor}" && 				
 		sleep 2 &&  			
 		main
 	fi
}

#Verif si plus de 6 joueurs et verif si egal à 1
verif_sup6_eq1() 
{
	# ${line} 6 22
	if [ ${nbjoueurs} -gt 6 ]
		then
			echo -n "${Red}Attention tu ne peux pas jouer à plus de 6 !!${ResetColor}" 
			sleep 2
			main 
	fi
		# ${line} 6 22	
		[ ${nbjoueurs} -eq 1 ] && echo -n "${Red}Attention tu ne peux pas jouer tout seul !!${ResetColor}" && 
		sleep 2 && 
		main
}

#Verif si sup à 1 et sup à userco
verif_sup1_userco()
{
	if [ ${nbjoueurs} -gt 1 ] && [ ${nbjoueurs} -gt ${userco} ] ; then
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
				1) attente && break ;;
				2) main ;;
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
				1) deco_joueur ;;
				2) main ;;
				3) exit ;;
				*) echo "1, 2 ou 3 ! merci !" ;;
			esac
		# ${line} 6 36
		[ ${nbjoueurs} -gt 1 ] && [ ${nbjoueurs} -eq ${userco} ] && 
		clear &&
		# ${line} 4 28 &&
		echo -n "${Green}Initialisation la partie !${ResetColor}" && 
		check_clt
		break 
	fi
}

#Attente de connexion des joueurs
attente() 
{
clear
while true ; do
check_clt
[ ${userco} -eq ${nbjoueurs} ] && break
	check_clt
	log "${userco} joueur(s) connecté(s) ! On attend sagement, merci |\r" 
	sleep 0.5  
	log "${userco} joueur(s) connecté(s) ! On attend sagement, merci /\r"
	sleep 0.5 
	log "${userco} joueur(s) connecté(s) ! On attend sagement, merci -\r"
	sleep 0.5 
	log "${userco} joueur(s) connecté(s) ! On attend sagement, merci |\r"
	sleep 0.5 
	log  "${userco} joueur(s) connecté(s) ! On attend sagement, merci -\r"
	sleep 0.5 
	log "${userco} joueur(s) connecté(s) ! On attend sagement, merci \\ \r"   
	sleep 0.5 
	userco=`top -n1 -b | grep perudoclt | sort -u | wc -l`
done
# ${line} 6 28
echo "${Green}Initialisation la partie !${ResetColor}"
launchgame
}

deco_joueur() 
{
echo `who | cut -d" " -f1 | sort -u`
read -p "${Green}nom du joueur à deconnecter : ${ResetColor}" nompts
`sudo pkill -KILL -u ${nompts}`
main
}


#Annonce debut de partie et place le nom des joueurs dans un fichier
launchgame() 
{
# ${line} 7 28
	log "${BlueCyan}NB joueurs connectés : ${userco}${ResetColor}"
# ${line} 8 28

	log "${BlueCyan}NB joueurs selectionné : ${nbjoueurs}${ResetColor}"
# ${line} 9 28
		log "${Green}Tous les Joueurs sont operationnels${ResetColor}" &&	
		sleep 1 &&
# ${line} 10 28
		log "${Green}Definition du premier joueur à commencer ${ResetColor}" 
		sleep 1
arrayusers
echo ${users_nom[*]} > /$HOME/perudo/users
firstplayer
}

#Initialise le tableau du nom des users	
arrayusers() 
{
a=0	
for i in `top -n1 -b | grep perudoclt | awk '{ print $2 }'` ; do
		users_nom[${a}]="${i}"
		a=$(($a+1))
done
}

#Definit le premier joueur
firstplayer() 
{
# ${line} 11 28
echo "${Green}Qui sera le premier joueur ?${ResetColor}"	
# random sur valeur du tableau
i=$(echo $((RANDOM%`cat users | wc -w`))) 
first=$(echo "${Green}${users_nom[${i}]}${ResetColor}")
log ${first}
}



#Code

main

check_clt 









# $HOME/perudo/perudocheck.sh






