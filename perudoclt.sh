#!/bin/bash

####PERRUDO !!!####

#Variables globales du jeu
JOUEUR=`whoami`
i=0
DES1=$((RANDOM%6+1))
DES2=$((RANDOM%6+1))
DES3=$((RANDOM%6+1))
DES4=$((RANDOM%6+1))
DES5=$((RANDOM%6+1))

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


function nomjoueur () {
#
tput cup 10 20
echo -e "${Red}  Bonjour `whoami`, voici ton premier lancé  ${ResetColor}"
}

function lance () {
#Affiche le premier lancé de dés
tput cup 11 20
echo -e "${Blue}         #####################${ResetColor}"
 
tput cup 12 20
echo -e "${Red}         #       ${JOUEUR}        #${ResetColor}"

tput cup 13 20
echo -e "${Green}         #`tput bold`[`if [ ${DES1} = 1 ] ; then echo @ ; else echo ${DES1} ; fi`] [`if [ ${DES2} = 1 ] ; then echo @ ; else echo ${DES2} ; fi`] [`if [ ${DES3} = 1 ] ; then echo @ ; else echo ${DES3} ; fi`] [`if [ ${DES4} = 1 ] ; then echo @ ; else echo ${DES4} ; fi`] [`if [ ${DES5} = 1 ] ; then echo @ ; else echo ${DES5} ; fi`]#${ResetColor}"
 
tput cup 14 20
echo -e "${Blue}         #####################${ResetColor}"

i=$((i+1))
}

function tableau () {
#envoie les valeurs des dés dans un fichier tableau
			 $(if [ ${i} -le 1 ] ; 
				then echo "`if [ ${DES1} = 1 ] ; 
								then echo @ ; 
								else echo ${DES1} ; 
										fi` 
							`if [ ${DES2} = 1 ] ; 
								then echo @ ; 
								else echo ${DES2} ; 
										fi` 
							`if [ ${DES3} = 1 ] ;
								then echo @ ; 
								else echo ${DES3} ; 
										fi` 
							`if [ ${DES4} = 1 ] ; 
								then echo @ ; 
								else echo ${DES4} ;
								fi` 
							`if [ ${DES5} = 1 ] ; 
								then echo @ ; 
								else echo ${DES5} ; 
								fi`" > tableau_`whoami`_${i} ;

				else echo "`if [ ${DES1} = 1 ] ; 
								then echo @ ; 
								else echo ${DES1} ;
								fi` 
							`if [ ${DES2} = 1 ] ; 
								then echo @ ; 
								else echo ${DES2} ;
								fi` 
							`if [ ${DES3} = 1 ] ; 
								then echo @ ; 
								else echo ${DES3} ; 
								fi` 
							`if [ ${DES4} = 1 ] ; 
								then echo @ ; 
								else echo ${DES4} ; 
								fi` 
							`if [ ${DES5} = 1 ] ; 
								then echo @ ; 
								else echo ${DES5} ;
								fi`" >> tableau_`whoami`_${i} ;
fi)

}


function premier () {
#Premiere annonce du premier joueur
tput cup 9 27
echo "${Green}Que souhaites-tu annoncer ?${ResetColor}"
tput cup 10 23
echo "${Green}Exemples : 2D2 ou 3d5 ou 46 ou 6.4${ResetColor}"
tput cup 12 0
echo "${Red}ATTENTION !!! Au premier tour tu n'as pas le droit d'utiliser les DUDO !!!${ResetColor}"
tput cup 14 0
echo -n "${Green}Ton choix :${ResetColor} " 

while read -r option1; do
echo -n "${Red}Ton choix est${ResetColor} "
echo "${option1}" | grep -e '^[[:digit:]]*D[[:digit:]]$'  > /dev/null || echo "${option1}" | grep -e '^[[:digit:]]*d[[:digit:]]$' > /dev/null || echo "${option1}" | grep -e '^[[:digit:]]*[[:digit:]]$' > /dev/null || echo "${option1}" | grep -e '^[[:digit:]]*\.[[:digit:]]$' > /dev/null
if [ $? -eq 0 ] ; then echo "${Green}OK${ResetColor}" ; break ; else echo -n "${Red}mauvais, attention à la syntaxe ! Repeat again : ${ResetColor}" ; 
	fi 
		done 

}





#Code



lance

nomjoueur

tableau

premier



