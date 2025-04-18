#!/bin/bash

set -eEo pipefail

# List of fonts to install
FONTS=("JetBrainsMono" "Hack")

# Directory to store the fonts
FONT_DIR="$HOME/.local/share/fonts"

# Nerd Fonts repository URL
REPO_URL="https://github.com/ryanoasis/nerd-fonts.git"

# Function to install a font
install_font() {
    local font_name=$1
    echo -e "\n\e[1;32mInstalling $font_name...\e[0m"
    
    # Clone the specific font from the repository
    git clone --filter=blob:none --sparse $REPO_URL
    cd nerd-fonts
    git sparse-checkout add patched-fonts/$font_name
    
    # Find and copy all .ttf files
    find patched-fonts/$font_name -name "*.ttf" -exec cp {} $FONT_DIR \;
    
    # Clean up
    cd ..
    rm -rf nerd-fonts
    
    echo -e "\n\e[1;32m$font_name installed successfully.\e[0m\n"
}

# Create font directory if it doesn't exist
mkdir -p "$FONT_DIR"

# Install each font in the list
for font in "${FONTS[@]}"; do
    install_font "$font"
done

# Update font cache
fc-cache -f -v
echo -e "\n\e[1;32mAll specified Nerd Fonts have been installed.\e[0m\n"

