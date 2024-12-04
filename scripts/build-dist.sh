#!/bin/bash
set -e

# Clean previous builds
rm -rf build/ dist/
hatch build   