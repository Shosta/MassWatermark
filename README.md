# Stamped your Pdf File with a List of Names

Imagine that you have a pdf file that you want to share to a bunch of people.

However that pdf file is confidential, so you want to make these people aware of their responsibilities and be able to know who's responsible in case there's a leak. 

## 👨‍💻Installation
----

### 👉Install Script

Just launch the install script

	./install.sh

### 👉Manual Install

#### Install Go 🐭
Be sure that you have Go installed on your device as we are going to use a Go package.
If you want to install Go on your device, you can follow this [link from the Go website](https://golang.org/doc/install).

#### Install the Pdf Library 🗃
The Go package we are going to use is [pdfcpu](https://pdfcpu.io/getting_started/getting_started).

To run this package, the required build version is Go 1.9 and up.

	go get github.com/hhrutter/pdfcpu/cmd/...

Add the execution rights to the shell file "stamp.sh".

	chmod +x stamp.sh

## 👨‍🏫Usage
----

Just use the help function from the script to understand how to use it : 

	./stamp.sh --help
	or
	./stamp.sh -h

You can launch the Shell script directly from the directory where it is located : 

    ./stamp.sh listOfNameFile pdfToStamp

Or you can make the script available system-wide.

You just have to add the script to the `/usr/local/bin` to make it available system-wide : 

	cp /path/to/stamp.sh /usr/local/bin/stamp

So you can now use it system-wide through : 

	stamp list.txt myConfidential.pdf
