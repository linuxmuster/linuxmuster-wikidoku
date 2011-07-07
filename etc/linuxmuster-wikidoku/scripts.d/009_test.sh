#!/bin/bash


AUSGABE="wikidoc[[workstations_hw|Workstations nach Hardwareklasse]]\n"

AUSGABE="${AUSGABE}===== Eine Testseite =====\n\n"

GRUPPENSCHIEBEL=`id schiebel`
AUSGABE="${AUSGABE}$GRUPPENSCHIEBEL\n\n"
echo -e $AUSGABE
