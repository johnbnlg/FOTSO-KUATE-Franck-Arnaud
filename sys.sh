#!/bin/sh

# Concepteur: FOTSO KUATE Franck arnaud; Matricule: 16b884fs

usage(){
	echo "Bienvenu sur mon script sys.\n"
	echo "Choisir l'option à executer."
	echo "a) Informations des utilisateurs enregistrés il y a trois jours."
	echo "b) Acquisition, installation et lancement de l'environement XAMPP."
	echo "c) Archivage des éléments du répertoire personel qui ont été modifiés par l'utilisateur sudoer il y a deux jours dans un périphérique externe."
	echo "d) Informations sur l'utilisation du disque, de la mémoire, du processeur et de la swap."
	echo "q/Q) Quitter.\n"
}

usersInfo(){
	for homedir in `find /opt/* -maxdepth 0 -type d -mtime -3`
	do
		awk -v user=${homedir##*/} -F ":" 'user==$1{print $0}' /etc/passwd
	done
}

xamppSetup(){
	wget https://downloadsapachefriends.global.ssl.fastly.net/xampp-files/7.1.4/xampp-linux-x64-7.1.4-0-installer.run?from_af=true
	sudo chmod +x xampp-linux-x64-7.1.4-0-installer.run
	sudo ./xampp-linux-x64-7.1.4-0-installer.run
	sudo /opt/lampp/lampp start
}

compression(){
	find /home/sudoer/* -maxdepth 0 -type fd -mtime -2 -exec tar -rvf /dev/sdb1/suvegarde.tar {} \
}

sysInfo(){
	echo "Utilisation des disques"
	df -h
	
	echo "Utilisation de la mémoire et de la swap"
	free -h
	
	echo "Utilisation du processeur"
	top -n1
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
