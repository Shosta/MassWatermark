#!/bin/bash

nameList=$1
pdfToStamp=$2
outputFolder="./StampedPdf"

# Add help value
#if [ "$1" == "-h" ] || [ $1 == "--help" ]; then
#  echo "Usage: stamp listOfNameFile pdfToStamp outputFolder"
#  exit 0
#fi

usage()
{
  echo "usage: stamp.sh
		[[-o|--output] <outputFolder>]
		[[-l|--list] <names_list>]
		[[-f|--file] <pdf_to_stamp>]
  		[-h|--help]"
}

# Separator to read the file.
IFS=' '

# Use an output folder for the stamped pdf files.
#if [ $3 == "" ] then
#  outputFolder="./StampedPdf"
#else
#  outputFolder="$3/StampedPdf"
#fi


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
        echo "${RED}\n$nameList does not exist, exit${NC}"
        exit
      fi
      ;;
    -f | --file)
      shift
      pdfToStamp=$1
      if [ ! -f $pdfToStamp ]; then
        echo "${RED}\n$pdfToStamp does not exist, exit${NC}"
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
[ ! -d $outputFolder ] && mkdir -p $outputFolder
while read -r prenom nom
do
	stamp="$prenom $nom"
    fileName=$(basename "$2")
    outputFilePath="$outputFolder/$prenom-$nom-$fileName"
	
	eval $(echo $GOBIN/pdfcpu stamp -pages odd,even "'"$stamp, f:Courier, s:1, c: 0.75 0.75 0.75, r:45, o:0.5"'" $2 $outputFilePath)
done < $1

  eval $(echo $GOBIN/pdfcpu stamp -pages odd,even "'"$stamp, f:Courier, s:1, c: 0.75 0.75 0.75, r:45, o:0.5"'" $pdfToStamp $outputFilePath)
done < $nameList
