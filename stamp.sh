#!/bin/bash

# Add help value
if [ "$1" == "-h" ] || [ $1 == "--help" ]; then
  echo "Usage: stamp listOfNameFile pdfToStamp outputFolder"
  exit 0
fi

# Separator to read the file.
IFS=' '

# Use an output folder for the stamped pdf files.
if [ $3 == "" ] then
	outputFolder="./StampedPdf"
else
	outputFolder="$3/StampedPdf"
fi

# Create StampedPdf Directory if it does not exist.
[ ! -d $outputFolder ] && mkdir -p $outputFolder
while read -r prenom nom
do
	stamp="$prenom $nom"
	outputFilePath="$outputFolder/$prenom-$nom-$2"
	
	eval $(echo $GOBIN/pdfcpu stamp -pages odd,even "'"$stamp, f:Courier, s:1, c: 0.75 0.75 0.75, r:45, o:0.5"'" $2 $outputFilePath)
done < $1
