#!/bin/bash

# Add help value
if [ "$1" == "-h" ] || [ $1 == "--help" ]; then
  echo "Usage: watermark nameList myConfidential.pdf outputFolder"
  exit 0
fi

# Separator to read the file.
IFS=' '

# Use an output folder for the stamped pdf files.
if [ "$3" == "" ]; then
	outputFolder="./WatermarkedPdf"
else
	outputFolder="$3/WatermarkedPdf"
fi

# Create StampedPdf Directory if it does not exist.
if [ ! -d $outputFolder ]; then 
    echo "Creating $outputFolder ..."
    eval $(mkdir -p $outputFolder)
fi

while read -r prenom nom
do
	watermark="$prenom $nom"
    fileName=$(basename "$2")
    outputFilePath="$outputFolder/$prenom-$nom-$fileName"
	
    eval $(echo $GOBIN/pdfcpu watermark -pages odd,even "'"$watermark, f:Courier, s:1, c: 0.75 0.75 0.75, r:45, o:0.5"'" $2 $outputFilePath)
done < $1
