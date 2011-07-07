#!/bin/bash


AUSGABE="wikidoc[[workstations_hw|Workstations nach Hardwareklasse]]\n"

AUSGABE="${AUSGABE}~~NOCACHE~~\n\n"
AUSGABE="${AUSGABE}===== Workstations nach Hardwareklasse =====\n\n"

ifs=$IFS
IFS=$'\n'
for i in $(sort -t ";" -k 3  /etc/linuxmuster/workstations); do
   ZEILE=`echo $i | awk -F';' '{print "| "$1 " | " $2  " | **" $3 "** | " $4 " | " $5 " | " $11 " |"}'  `
   AUSGABE="${AUSGABE}$ZEILE\n"
done

IFS=$ifs

echo -e $AUSGABE
