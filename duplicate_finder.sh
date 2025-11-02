#!/bin/bash
# ---------------------------------------------
# Basic Duplicate File Finder
# Name: Komal
# ---------------------------------------------

echo "Enter the directory path to scan for duplicates:"
read dir

# Check if directory exists
if [ ! -d "$dir" ]; then
    echo "Error: Directory not found!"
    exit 1
fi

echo
echo "---------------------------------------------"
echo "     DUPLICATE FILE FINDER - BASIC VERSION"
echo "---------------------------------------------"
echo
echo "Scanning directory: $dir"
echo "Please wait..."
echo

# Create a temporary file to store checksums
temp_file=$(mktemp)
find "$dir" -type f -exec md5sum {} + > "$temp_file"

echo "Original Files:"
echo "---------------------------------------------"

# Print the first occurrence of each hash (original files)
awk '!seen[$1]++ {print $2}' "$temp_file"

echo
echo "Duplicate Files:"
echo "---------------------------------------------"

# Print repeated hashes (duplicate files)
awk 'seen[$1]++ {print $2}' "$temp_file"

echo
echo "---------------------------------------------"
echo "Scan complete. Thank you for using the script!"
echo "---------------------------------------------"

# Remove the temporary file
rm "$temp_file"

