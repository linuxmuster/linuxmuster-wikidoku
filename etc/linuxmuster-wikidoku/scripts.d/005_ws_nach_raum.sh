#!/bin/bash


AUSGABE="wikidoc[[workstations_raum|Workstations nach Raumname]]\n"

AUSGABE="${AUSGABE}~~NOCACHE~~\n\n"
AUSGABE="${AUSGABE}===== Workstations nach Raumname =====\n\n"

ifs=$IFS
IFS=$'\n'
for i in $(sort -t ";" -k 1 /etc/linuxmuster/workstations); do
   ZEILE=`echo $i | awk -F';' '{print "| **"$1 "** | " $2  " | " $3 " | " $4 " | " $5 " | " $11 " |"}'  `
   AUSGABE="${AUSGABE}$ZEILE\n"
done

IFS=$ifs

echo -e $AUSGABE
