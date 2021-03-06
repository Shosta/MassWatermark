#!/bin/bash

#Define some colors
RED='\033[0;31m'
NC='\033[0m'

#Default values
nameList=$1
pdfToStamp=$2
outputFolder="./StampedPdf"

usage()
{
  echo "usage: stamp
	[[-o|--output] <outputFolder>]
	[[-l|--list] <names_list>]
	[[-f|--file] <pdf_to_stamp>]
        [-h|--help]"
}


# Separator to read the file.
IFS=' '


# Main
while [ ! -z "$1" ]; do
  case $1 in
    -o | --output)
      shift
      outputFolder="$1/StampedPdf"
      ;;
    -l | --list)
      shift
      nameList=$1
      if [ ! -f $nameList ]; then
        echo -e "${RED}\n$nameList does not exist, exit${NC}"
        exit
      fi
      ;;
    -f | --file)
      shift
      pdfToStamp=$1
      if [ ! -f $pdfToStamp ]; then
        echo -e "${RED}\n$pdfToStamp does not exist, exit${NC}"
        exit
      fi
      ;;
    -h | --help)
      usage
      exit
  esac
  shift
done

# Create StampedPdf Directory if it does not exist.
if [ ! -d $outputFolder ]; then 
  echo "Creating $outputFolder ..."
  eval $(mkdir -p $outputFolder)
fi

while read -r prenom nom
do
	stamp="$prenom $nom"
  fileName=$(basename "$pdfToStamp")
  outputFilePath="$outputFolder/$prenom-$nom-$fileName"

  eval $(echo $GOBIN/pdfcpu stamp -pages odd,even "'"$stamp, f:Courier, s:1, c: 0.75 0.75 0.75, r:45, o:0.5"'" $pdfToStamp $outputFilePath)
done < $nameList
