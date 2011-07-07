#!/bin/bash


AUSGABE="wikidoc[[workstations_name|Workstations nach Rechnername]]\n"

AUSGABE="${AUSGABE}~~NOCACHE~~\n\n"
AUSGABE="${AUSGABE}===== Workstations nach Rechnername =====\n\n"

ifs=$IFS
IFS=$'\n'
for i in $(sort -t ";" -k 2 /etc/linuxmuster/workstations); do
   ZEILE=`echo $i | awk -F';' '{print "| "$1 " | **" $2  "** | " $3 " | " $4 " | " $5 " | " $11 " |"}'  `
   AUSGABE="${AUSGABE}$ZEILE\n"
done

IFS=$ifs

echo -e $AUSGABE
