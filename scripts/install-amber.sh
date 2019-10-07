#!/bin/bash

# Set $PATH
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Source and export variables
source /app/scripts/.env
export AMBER_VERSION AMBER_FILE_NAME AMBER_SHA256_HASH

# Download the file
wget https://github.com/amberframework/amber/archive/$AMBER_FILE_NAME

# Check hash
echo ""${AMBER_SHA256_HASH}" "${AMBER_FILE_NAME}"" | sha256sum -c - > amber_file_hash_output.txt

# Extract amber archive
if grep "OK" amber_file_hash_output.txt; then echo "Extracting amber archive!" && tar -xzf "${AMBER_FILE_NAME}"; else echo "Hash doesn't match, not extracting amber archive" && exit; fi

# Install amber
echo "Making amber!"
cd amber-$AMBER_VERSION; make; make install
