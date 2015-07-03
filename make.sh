#!/bin/bash

nbcocottes=10
nbwords=9
wordlist="wordlist_fr"
model="model.svg"

# if it doesn't exist, create an output folder
mkdir output

# first loop to produce all cocottes
for ((i=0 ; $nbcocottes - $i ; i++))
do echo "Cocotte " $i

    svgfile="cocotte$i.svg"
    pdffile="cocotte$i.pdf"

    cp $model output/$svgfile
    
    # second loop to select random words
    for ((j=1 ; $nbwords - $j ; j++))
    do
        # random word from the file
        word=`sed -n "$((RANDOM%$(wc -l < $wordlist)))p" $wordlist`
        sed -i -e "s/abcde"$j"/$word/g" output/$svgfile
    done

    # Generate PDF from SVG using inkscape cli
    inkscape --without-gui --export-pdf=output/$pdffile output/$svgfile

    # Print cocotte 
    #lpr -P MX320-series cocotte0.pdf
done

# Delete all svg
rm output/*.svg
