#!/bin/bash
# Simple bulk file renamer for changing prefixes
# Cut -c{number}- cuts the first x characters from a file name and prepends the newname

for name in Etrm_Mms_Databases_*
do
    newname=Etrm_Nets_Windows_"$(echo "$name" | cut -c20-)"
    mv "$name" "$newname"
done
