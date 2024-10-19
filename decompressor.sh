#!/bin/bash

# Set Colours
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
endColour="\033[0m\e[0m"

# Install package
apt install 7zip 

function ctrl_c(){
    echo -e "\n\n${redColour}[!] Exiting${endColour}\n"
      exit 1
  }

# Capture Ctrl+C
trap ctrl_c INT

# Replace <file_to_decompress> with your file you want to decompress
first_file_name="<file_to_decompress>"
decompressed_file_name="$(7z l <file_to_decompress> | tail -n 3 | head -n 1 | awk 'NF{print $NF}')"
7z x $first_file_name &>/dev/null

while true; do

    if [[ -z "$decompressed_file_name" ]]; then
        echo -e "\n${redColour}[!] No more files to decompress${endColour}\n"
        exit 1
    fi

    echo -e "\n${greenColour}[+] New file decompressed: $decompressed_file_name ${endColour}"
    7z x $decompressed_file_name &> /dev/null
    decompressed_file_name="$(7z l $decompressed_file_name 2>/dev/null | tail -n 3 | head -n 1 | awk 'NF{print $NF}')"

done