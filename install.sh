#!/bin/bash

# check for specific command
# Return values:
#  0 - command is available
#  1 - command is not available
check_for_command(){
  command -v "$1" 1>/dev/null 2>&-
}


# Check if the Go language is already installed.
if check_for_command go; then
    echo "The Go language is installed."
else
    echo 'The Go language is not installed.'
    echo "Please install the Go language first as we are relying on a Go package for that program."
    echo "Go to https://golang.org/dl/ to install the Go language on your computer."
    exit 1
fi


# Check if the pdfcpu package is already installed
if check_for_command $GOBIN/pdfcpu version; then
    echo "'pdfcpu' is installed"
else
    echo "'pdfcpu' is not installed." >&2

    # Install the pdfcpu package.
    echo "Installing 'pdfcpu'..."
    go get github.com/hhrutter/pdfcpu/cmd/...
    go install github.com/hhrutter/pdfcpu/cmd/pdfcpu
fi


# Make the Stamp.sh file available system-wide.
echo "Installing stamp system-wide (located in /usr/local/bin)..."
chmod +x ./stamp.sh
cp ./stamp.sh /usr/local/bin/stamp

echo "'stamp' is available system-wide. Try 'stamp --help' to see how it is working."


# Make the Stamp.sh file available system-wide.
echo "Installing watermark system-wide (located in /usr/local/bin)..."
chmod +x ./watermark.sh
cp ./watermark.sh /usr/local/bin/watermark

echo "'watermark' is available system-wide. Try 'watermark --help' to see how it is working."
