#!/bin/sh

# Concepteur: FOTSO KUATE Franck arnaud; Matricule: 16b884fs
usage(){
	echo "Bienvenu sur mon script sys.\n"
	echo "Choisir l'option à executer."
	echo "a) Informations des utilisateur enregistrés il y a trois jours."
	echo "b) Acquisition, installation et lancement de l'environement XAMPP."
	echo "c) Archivage des éléments du répertoire personel qui ont été modifiés par l'utilisateur sudoer il y a deux jours dans un périphérique externe."
	echo "d) Informations sur l'utilisation du disque, de la mémoire, du processeur et de la swap."
	echo "q/Q) Quitter."
}

usersInfo(){
	echo "loginname:password:lcdate:mindays:maxdays:ndays1:ndays2:expiration:reserved"
	awk -v date=$(date +%s) -F ":" '$2>=date-3*24*3600 && $2<=date-2*24*3600 {print $0}' /etc/shadow
}

xamppSetup(){
	wget https://downloadsapachefriends.global.ssl.fastly.net/xampp-files/7.1.4/xampp-linux-x64-7.1.4-0-installer.run?from_af=true
	sudo chmod +x xampp-linux-x64-7.1.4-0-installer.run
	sudo ./xampp-linux-x64-7.1.4-0-installer.run
	/bin/xampp_control
}

compression(){
	
	for file in `find /home/sudoer -type f -mtime -3`
	do
		tar -cf /dev/sdb1/$file.tar $file
	done
}

sysInfo(){
	echo "Utilisation des disques"
	df -h
	
	echo "Utilisation de la mémoire et de la swap"
	free -m
	
	echo "Informations sur le processeur"
	lscpu
}

usage
read option
case $option in
        a)
            usersInfo
            ;;
         
        b)
            xamppSetup
            ;;
         
        c)
            compression
            ;;
        d)
            sysInfo
            ;;
        q|Q)
            exit
            ;;
			
        *)
		usage
esac
