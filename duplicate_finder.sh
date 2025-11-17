 #!/bin/bash
# ---------------------------------------------------
# MENU-DRIVEN DUPLICATE FILE FINDER
# Name: Komal
# ---------------------------------------------------

# Function to find original files (first occurrence of each hash)
find_originals() {
    dir="."
    echo
    echo "---------------------------------------------------"
    echo "               ORIGINAL FILES FINDER"
    echo "---------------------------------------------------"
    echo "Scanning current directory: $(pwd)"
    echo "Please wait..."
    echo

    temp_file=$(mktemp)

    # Skip .git folder while scanning
    find "$dir" -type f ! -path "./.git/*" -exec md5sum {} \; > "$temp_file"

    echo "Original Files:"
    echo "---------------------------------------------------"
    awk '!seen[$1]++ {print $2}' "$temp_file"
    echo
    echo "---------------------------------------------------"
    echo "Original file scan complete!"
    echo "---------------------------------------------------"
    rm "$temp_file"
}

# Function to find duplicate files
find_duplicates() {
    dir="."
    echo
    echo "---------------------------------------------------"
    echo "               DUPLICATE FILES FINDER"
    echo "---------------------------------------------------"
    echo "Scanning current directory: $(pwd)"
    echo "Please wait..."
    echo

    temp_file=$(mktemp)

    # Skip .git folder while scanning
    find "$dir" -type f ! -path "./.git/*" -exec md5sum {} \; > "$temp_file"

    echo "Duplicate Files:"
    echo "---------------------------------------------------"
    awk 'seen[$1]++ {print $2}' "$temp_file"
    echo
    echo "---------------------------------------------------"
    echo "Duplicate file scan complete!"
    echo "---------------------------------------------------"
    rm "$temp_file"
}

# Function to show about info
about_project() {
    echo
    echo "---------------------------------------------------"
    echo "                  ABOUT THE PROJECT"
    echo "---------------------------------------------------"
    echo "Project : Duplicate File Finder"
    echo "Name    : Komal"
    echo "Version : Basic Menu-Driven (Auto Directory)"
    echo
    echo "Description:"
    echo "This script scans the current working directory"
    echo "for duplicate files using MD5 checksums."
    echo "---------------------------------------------------"
}

# Function to display the main menu
show_menu() {
    echo
    echo "---------------------------------------------------"
    echo "               DUPLICATE FILE FINDER MENU"
    echo "---------------------------------------------------"
    echo "1. Find Original Files"
    echo "2. Find Duplicate Files"
    echo "3. About the Project"
    echo "4. Exit"
    echo "---------------------------------------------------"
}

# Main loop
while true; do
    show_menu
    echo -n "Enter your choice [1-4]: "
    read choice

    case $choice in
        1) find_originals ;;
        2) find_duplicates ;;
        3) about_project ;;
        4)
            echo " Goodbye!..."
            echo
            exit 0
            ;;
        *)
            echo "Invalid option! Please try again."
            ;;
    esac
done
