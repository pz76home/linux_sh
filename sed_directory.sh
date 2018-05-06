#!/bin/bash
#Complex sed with directory variables and multiple substitutions

export DIR=/directory1/directory2
export BASE=`basename /directory1/directory2`

sed 's|DIR|'$DIR'|g; s|BASE|'$BASE'|g' /directory/input_filename.txt > /directory/output_filename.txt
