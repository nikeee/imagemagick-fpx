#!/usr/bin/env bash
set -euo pipefail

# Mass convert all files in a directory to a different format
# Usage: mass-convert.sh <input-dir> <output-dir> <output-format>
# Example: mass-convert.sh /home/user/input /home/user/output jpg

# Check if the input directory exists
if [ ! -d "$1" ]; then
    echo "Input directory does not exist"
    exit 1
fi

# $3 has the default value "jpg" if it's not specified
output_format="${3:-jpg}"

find "$1" -type f -iname "*.fpx" | while read file_to_convert
do
    # Get the filename without the extension
    filename=$(basename -- "$file_to_convert")
    filename="${filename%.*}"

    # get directory withotu file name
    dir=$(dirname "$file_to_convert")

    # strip input dir
    prefix=${1#$dir}

    output_dir="$2/$prefix"
    output_dir=${output_dir%/}

    # create output dir if it doesn't exist
    if [ ! -d "$output_dir" ]; then
        mkdir -p "$output_dir"
    fi


    dest_file="$output_dir/$filename.$output_format"

    echo "Converting $file_to_convert to $dest_file"
    convert "$file_to_convert" "$dest_file"

    # Copy the file's metadata to the output file (creationt ime etc)
    touch -r "$file_to_convert" "$dest_file"

    # Convert the file to the output format
    # convert "$file" "$output_dir/$filename.$3"
done
