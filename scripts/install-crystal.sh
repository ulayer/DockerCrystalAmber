#!/bin/bash

# Set $PATH
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Source and export variables
source /app/scripts/.env
export CRYSTAL_VERSION CRYSTAL_FILE_NAME CRYSTAL_SHA256_HASH

# Download the file
wget https://github.com/crystal-lang/crystal/releases/download/$CRYSTAL_VERSION/$CRYSTAL_FILE_NAME

# Check hash
echo ""${CRYSTAL_SHA256_HASH}" "${CRYSTAL_FILE_NAME}"" | sha256sum -c - > crystal_file_hash_output.txt

# Install crystal package
if grep "OK" crystal_file_hash_output.txt; then echo "Installing crystal package!" && dpkg -i "${CRYSTAL_FILE_NAME}"; else echo "Hash doesn't match, not installing crystal package"; fi
