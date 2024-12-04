#!/bin/bash
set -e

# Upgrade pip and install hatch
python3 -m pip install --upgrade --user pip
python3 -m pip install --upgrade --user hatch

# Verify hatch installation
export PATH="$HOME/.local/bin:$PATH"
hatch --version

# Configure Git
git config --global http.version HTTP/1.1

# Create default environment
hatch env create default

# Clean previous builds
rm -rf build/ dist/

# Build the project
hatch build
