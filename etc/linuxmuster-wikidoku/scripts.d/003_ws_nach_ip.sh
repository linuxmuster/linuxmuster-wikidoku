#!/bin/bash


AUSGABE="wikidoc[[workstations_ip|Workstations nach IP-Adresse]]\n"

AUSGABE="${AUSGABE}~~NOCACHE~~\n\n"
AUSGABE="${AUSGABE}===== Workstations nach IP-Adresse =====\n\n"


OKTETT1=`cat /etc/linuxmuster/workstations | awk -F';' '{print $5}' | awk -F. '{print $1}' | sort -u -n `
OKTETT2=`cat /etc/linuxmuster/workstations | awk -F';' '{print $5}' | awk -F. '{print $2}' | sort -u -n `
OKTETT3=`cat /etc/linuxmuster/workstations | awk -F';' '{print $5}' | awk -F. '{print $3}' | sort -u -n `

ifs=$IFS
IFS=$'\n'
for o1 in $OKTETT1; do 
for o2 in $OKTETT2; do 
for o3 in $OKTETT3; do 
OKTETT4=`grep ";$o1\.$o2\.$o3\." /etc/linuxmuster/workstations | awk -F';' '{print $5}' | awk -F. '{print $4}' | sort -u -n `
for o4 in $OKTETT4; do
for i in $(grep ";$o1\.$o2\.$o3\.$o4;" /etc/linuxmuster/workstations | sort -n ); do
   ZEILE=`echo $i | awk -F';' '{print "| "$1 " | " $2  " | " $3 " | " $4 " | **" $5 "** | " $11 " |"}'  `
   AUSGABE="${AUSGABE}$ZEILE\n"
done
done
done
done
done

IFS=$ifs

echo -e $AUSGABE
