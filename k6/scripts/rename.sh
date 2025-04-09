#!/bin/bash

# Function to rename files with a specific suffix in a directory and its subdirectories
rename_files() {
    local source_suffix="$1"
    local target_suffix="$2"
    local start_dir="${3:-.}"

    # Use find to locate files with the source suffix
    find "$start_dir" -type f -name "*-$source_suffix" | while read -r file; do
        # Create the new filename by replacing the suffix
        new_file="${file%$source_suffix}$target_suffix"

        # Rename the file
        mv "$file" "$new_file"
        echo "Renamed: $file -> $new_file"
    done
}

# Check if correct number of arguments are provided
if [ $# -lt 2 ] || [ $# -gt 3 ]; then
    echo "Usage: $0 <source_suffix> <target_suffix> [start_directory]"
    echo "Example: $0 txt log /path/to/search"
    exit 1
fi

# Call the rename function with provided arguments
rename_files "$1" "$2" "${3:-.}"
