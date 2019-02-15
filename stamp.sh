#!/bin/bash

IFS=' '
while read -r prenom nom
do
	eval $(echo $HOME/go/bin/pdfcpu stamp -pages odd,even "'"$nom $prenom, f:Courier, s:1, c: 0.75 0.75 0.75, r:45, o:0.5"'" $2 $nom"_"$prenom"_"$2)
done < $1
