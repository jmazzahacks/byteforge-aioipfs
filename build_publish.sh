#!/bin/bash
set -e  # Exit on any error

echo "Building and publishing byteforge-aioipfs to PyPI..."

# Check if virtual environment is activated
if [[ "$VIRTUAL_ENV" == "" ]]; then
    echo "Activating virtual environment..."
    source bin/activate
fi

# Ensure build and twine are installed
echo "Installing/upgrading build tools..."
python -m pip install --upgrade build twine

# Clean and create dist directory
echo "Cleaning dist directory..."
rm -rf dist/
mkdir -p dist/

# Build package
echo "Building package..."
python -m build

# Check package integrity
echo "Checking package..."
python -m twine check dist/*

# Show what will be uploaded
echo "Files to upload:"
ls -la dist/

# Check for PyPI credentials
if [[ -z "$TWINE_PASSWORD" ]]; then
    echo "⚠️  TWINE_PASSWORD not set - you'll be prompted for your PyPI API token"
else
    echo "✓ Using PyPI token from TWINE_PASSWORD environment variable"
fi

# Upload to PyPI
echo "Uploading to PyPI..."
python -m twine upload dist/*

echo "✅ Successfully published to PyPI!"
