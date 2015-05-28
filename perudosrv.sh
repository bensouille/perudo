#!/bin/bash

####PERRUDO SRV####

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

# Fonctions
 
function intro () {
# Effacement du terminal
clear
  
tput cup 0 20
echo -e "${Blue}##########################################${ResetColor}"
 
tput cup 1 20
echo -e "${Green}#         Bienvenue sur DUDO !!!         #${ResetColor}"

tput cup 2 20
echo -e "${Green}#           Le POKER des dés             #${ResetColor}"
 
tput cup 3 20
echo -e "${Blue}##########################################${ResetColor}"

}


function nbjoueurs () {
#Defini le nombre de joueurs
tput cup 4 20
echo -n "combien de joeurs ? : "

}


function attente () {
#Attente des joueurs

}

#Code

intro



$HOME/perudoclt.sh