#!/bin/bash

# source config
if [ -r  /etc/linuxmuster-wikidoku/wikidoku.conf ]; then 
. /etc/linuxmuster-wikidoku/wikidoku.conf
fi

NOW=`date +"%d.%m.%Y-%H:%M"`
AUSGABE="wikidoc[[status|Musterlösungsstatus]]\n"

AUSGABE="${AUSGABE}~~NOCACHE~~\n\n"
AUSGABE="${AUSGABE}===== Musterlösungsstatus ($NOW)=====\n\n"

AUSGABE="${AUSGABE}===== Versionsinfos =====\n\n"
TEMP="/etc/debian_version /etc/issue"
for i in $TEMP; do 
    WERT=`cat $i`
    AUSGABE="${AUSGABE}^$i|$WERT|\n"
done

HOSTS=`cat /etc/linuxmuster/workstations | grep -v "^#" | wc -l`
HOSTS22=`grep ";22$" /etc/linuxmuster/workstations | grep -v "^#" | wc -l`
let HOSTS0=$HOSTS-$HOSTS22

AUSGABE="${AUSGABE}===== /etc/linuxmuster/workstations =====\n\n"
AUSGABE="${AUSGABE}^ Rechner gesamt ^ mit Imaging ^ ohne Imaging ^\n"
AUSGABE="${AUSGABE}| $HOSTS | $HOSTS22 | $HOSTS0 |\n"



AUSGABE="${AUSGABE}===== Netzwerkinformationen =====\n\n"
AUSGABE="${AUSGABE}/etc/linuxmuster/network.settings\n"

ifs=$IFS
IFS=$'\n'
for i in $(cat /var/lib/linuxmuster/network.settings); do
    NWSETTINGS=`echo $i | sed -e  '/^#/d' | sed -e 's/"//g' | sed -e 's/=/###/' | awk -F'###' '{print "| "$1" | "$2" |"}' ` 
    AUSGABE="${AUSGABE}$NWSETTINGS\n"
    IMAGING=`echo $i | grep imaging | awk -F'=' '{print $2}'`   
    PAKETGRUPPEN="${PAKETGRUPPEN} $IMAGING"
done
IFS=$ifs

AUSGABE="${AUSGABE}===== Paketversionen =====\n\n"
for paket in $PAKETGRUPPEN; do 
    installed_packages=`dpkg -l "*${paket}*" | grep "^ii"`
    IFS=$ifs
    IFS=$'\n'
    AUSGABE="${AUSGABE}\n\n=== Pakete deren Name '$paket' enthält ===\n\n"
    AUSGABE="${AUSGABE}^Status^Paket^Version^\n"
    for package in $installed_packages; do 
       ZEILE=`echo $package | awk '{print "| "$1" | " $2 " | " $3 " |"}'`
       AUSGABE="${AUSGABE}$ZEILE\n"
    done
    IFS=$ifs
done


echo -e $AUSGABE
