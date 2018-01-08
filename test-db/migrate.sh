#!/bin/bash

NC='\033[0m'
BLUE='\e[1;34m'
GREEN='\e[1;32m'
RED='\e[1;31m'

conf_dir='conf'
conf_file='postgre.conf'

line() {
    printf " ${GREEN}%39s${NC}%-2s%-100s\n" "$1" ":" "$2"
}

usage() {
    echo ""
    line "migrate.sh" "információt ír ki a használatról"
    line "migrate.sh <környezet>" "a conf/környezet mappa alatt található oracle.conf fájl alapján"
    line "" "migrációt hajt végre a migrate flyway parancs használatával"
    line "migrate.sh <környezet> <flyway parancs>" "a conf/környezet mappa alatt található oracle.conf fájl alapján"
    line "" "végrehajtja az adott flyway parancsot (migrate, info, validate, baseline, repair, clean)"
    echo ""
}

echo_error() {
    echo -e "\n$1\n"
}

check_environment() {
    if [ ! -d "$conf_dir/$1" ] ; then
        echo_error "A ${RED}$conf_dir/$1${NC} könyvtár nem található."
        return 1
    fi
} 

check_conf_file() {
    if [ ! -e "$conf_dir/$1/$conf_file" ] ; then
        echo_error "A ${RED}$conf_dir/$1/$conf_file${NC} konfigurációs fájl nem található."
        return 1
    fi
}

check_flyway_command() {
    case $1 in
        clean)
			echo -e "\n"-------------------- ${RED}A clean parancsot használva a teljes adatbázis sémát törölni fogja.${NC} ---------------------
			echo -e "Biztosan törölni szeretné a teljes adatbázis sémát?"
			read -n1 -rsp $'Nyomjon i billentyűt a folytatáshoz, vagy bármelyik másik billentyűt a kilépéshez...\n' key
            if [ "$key" = "i" ] ; then
				return 0
			else
				return 1
			fi
        ;;
    esac
}

execute_flyway_command() {
	echo -e "\n"-------------------- ${GREEN}Adatbázis konfiguráció ellenőrzés!${NC} ---------------------
	./printConfig.sh $conf_dir/$1/$conf_file
	echo -e "\n"-------------------- ${GREEN}Nyomjon c billentyűt a következő parancs folytatásához:${NC} ${BLUE}$2${NC}
	read -n1 -rsp $'Nyomjon c billentyűt a folytatáshoz, vagy bármelyik másik billentyűt a kilépéshez...\n' key
	
	if [ "$key" = "c" ] ; then
		./flyway -configFile=$conf_dir/$1/$conf_file -locations=filesystem:sql $2
	fi
}


if [ $# -eq 1 ] ; then
    check_environment $1 && check_conf_file $1 && execute_flyway_command $1 migrate

elif [ $# -eq 2 ] ; then
    check_environment $1 && check_conf_file $1 && check_flyway_command $2 && execute_flyway_command $1 $2

else
    usage
fi
