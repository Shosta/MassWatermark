#!/bin/bash

# Add help value
if [ "$1" == "-h" ] || [ $1 == "--help" ]; then
  echo "Usage: stamp nameList myConfidential.pdf outputFolder"
  exit 0
fi

# Separator to read the file.
IFS=' '

# Use an output folder for the stamped pdf files.
if [ "$3" == "" ]; then
	outputFolder="./StampedPdf"
else
	outputFolder="$3/StampedPdf"
fi

# Create StampedPdf Directory if it does not exist.
if [ ! -d $outputFolder ]; then 
    echo "Creating $outputFolder ..."
    eval $(mkdir -p $outputFolder)
fi

while read -r prenom nom
do
	stamp="$prenom $nom"
    fileName=$(basename "$2")
    outputFilePath="$outputFolder/$prenom-$nom-$fileName"
	
	eval $(echo $GOBIN/pdfcpu stamp -pages odd,even "'"$stamp, f:Courier, s:1, c: 0.75 0.75 0.75, r:45, o:0.5"'" $2 $outputFilePath)
done < $1
