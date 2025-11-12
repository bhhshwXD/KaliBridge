#!/bin/bash

KALI_REPO_FILE="/etc/apt/sources.list.d/kali.list"
KALI_PREF_FILE="/etc/apt/preferences.d/kali.pref"
KALI_KEYRING="/usr/share/keyrings/kali-archive-keyring.gpg"
KALI_KEY_URL="https://archive.kali.org/archive-key.asc"
KALI_REPO_ENTRY="deb [arch=amd64 signed-by=$KALI_KEYRING] http://http.kali.org/kali kali-rolling main non-free contrib"

if ! command -v apt &> /dev/null; then
    echo "ERROR: This script is only for Debian/Ubuntu-based systems (which use 'apt')." >&2
    exit 1
fi

if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root (use sudo)." >&2
   exit 1
fi

uninstall_kali_repo() {
    echo "==========================================="
    echo "Status: KALI REPOSITORY FOUND"
    echo "Action: REMOVING KALI LINUX REPOSITORY"
    echo "==========================================="
    read -r -p "Are you sure you want to remove Kali repository configuration? (y/N): " response
    response=${response,,}

    if [[ "$response" != "y" ]]; then
        echo "Operation cancelled."
        exit 0
    fi

    echo "Removing repository file: $KALI_REPO_FILE"
    rm -f "$KALI_REPO_FILE"

    echo "Removing preferences (pinning) file: $KALI_PREF_FILE"
    rm -f "$KALI_PREF_FILE"

    echo "Removing GPG Key: $KALI_KEYRING"
    rm -f "$KALI_KEYRING"
    
    echo "-------------------------------------------"
    echo "Cleaning cache and updating package list..."
    apt clean > /dev/null 2>&1
    apt update

    echo "--- SUCCESS ---"
    echo "Kali Linux repository has been completely removed."
}

install_kali_repo() {
    echo "========================================="
    echo "Status: KALI REPOSITORY NOT FOUND"
    echo "Action: ADDING KALI LINUX REPOSITORY"
    echo "========================================="
    echo "⚠️ WARNING: This operation risks package conflicts."
    read -r -p "Are you sure you want to proceed with installation? (y/N): " response
    response=${response,,}

    if [[ "$response" != "y" ]]; then
        echo "Operation cancelled."
        exit 0
    fi

    echo "Installing required packages..."
    apt update > /dev/null 2>&1
    apt install -y wget gnupg dirmngr apt-transport-https > /dev/null 2>&1

    echo "Importing Kali Linux GPG Key..."
    wget -q -O - "$KALI_KEY_URL" | gpg --dearmor | tee "$KALI_KEYRING" > /dev/null

    if [ $? -ne 0 ]; then
        echo "Failed to import or save Kali Linux GPG key." >&2
        exit 1
    fi
    echo "GPG key successfully saved."

    echo "Adding kali-rolling repository ($KALI_REPO_FILE)..."
    echo "$KALI_REPO_ENTRY" | tee "$KALI_REPO_FILE" > /dev/null

    echo "Setting Pin-Priority 50 (Low Priority) ($KALI_PREF_FILE)..."
    cat <<EOF | tee "$KALI_PREF_FILE" > /dev/null
Package: *
Pin: release a=kali-rolling
Pin-Priority: 50
EOF
    
    echo "-------------------------------------------"
    echo "Updating package list..."
    apt update

    echo "--- SUCCESS ---"
    echo "Kali Linux repository has been added with Pin-Priority 50."
    echo "Use: apt install package-name -t kali-rolling to install tools."
}

if [ -f "$KALI_REPO_FILE" ]; then
    uninstall_kali_repo
else
    install_kali_repo
fi
