#!/bin/bash

# ==============================================================================
# Dotfiles Setup Script
#
# This script creates symbolic links for a user's dotfiles from a central
# repository to their home directory. It first backs up any existing files
# to a dedicated backup directory to prevent data loss.
# ==============================================================================

# Define the source directory (where this script lives)
# and the backup directory
DOTFILES_DIR=$(pwd)
BACKUP_DIR="$HOME/.dotfiles_backup"

# Define the list of files to be symlinked
declare -A FILES_TO_LINK
FILES_TO_LINK[".bashrc"]="$HOME/.bashrc"
FILES_TO_LINK[".flake8"]="$HOME/.flake8"
FILES_TO_LINK[".gitconfig"]="$HOME/.gitconfig"
FILES_TO_LINK[".tmux.conf"]="$HOME/.tmux.conf"
FILES_TO_LINK[".vimrc"]="$HOME/.vimrc"
FILES_TO_LINK["ipython_config.py"]="$HOME/.ipython/profile_default/ipython_config.py"
FILES_TO_LINK["ssh_config"]="$HOME/.ssh/config"

echo "Starting dotfiles setup..."

# Create the backup directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    echo "Created backup directory at $BACKUP_DIR"
fi

# Loop through the files and create the symbolic links
for file in "${!FILES_TO_LINK[@]}"; do
    source_path="$DOTFILES_DIR/$file"
    target_path="${FILES_TO_LINK[$file]}"

    echo "Processing $file..."

    # Check if the source file exists in the dotfiles repo
    if [ ! -e "$source_path" ]; then
        echo "  - Source file '$source_path' not found. Skipping."
        continue
    fi

    # Check if the target path's parent directory exists. If not, create it.
    target_parent_dir=$(dirname "$target_path")
    if [ ! -d "$target_parent_dir" ]; then
        echo "  - Parent directory '$target_parent_dir' not found. Creating it."
        mkdir -p "$target_parent_dir"
    fi

    # Check if the target file/link already exists
    if [ -e "$target_path" ] || [ -L "$target_path" ]; then
        echo "  - Existing file/link found at '$target_path'. Backing it up to '$BACKUP_DIR'."
        mv "$target_path" "$BACKUP_DIR/"
    fi

    # Create the symbolic link
    ln -s "$source_path" "$target_path"
    echo "  - Created symbolic link: '$source_path' -> '$target_path'"
done

echo "Dotfiles setup complete!"
