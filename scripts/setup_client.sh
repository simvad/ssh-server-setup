#!/bin/bash

configure_ssh_client() {
    echo "Setting up SSH client configuration..."

    # Default values
    DEFAULT_HOST_ALIAS="myserver"
    DEFAULT_HOSTNAME="192.168.1.100"
    DEFAULT_PORT="22"
    DEFAULT_USER="$USER"  # Current system user
    DEFAULT_IDENTITY_FILE="$HOME/.ssh/id_rsa"

    read -p "Host alias (shortcut name for server) [${DEFAULT_HOST_ALIAS}]: " HOST_ALIAS
    HOST_ALIAS=${HOST_ALIAS:-$DEFAULT_HOST_ALIAS}

    read -p "Server hostname or IP [${DEFAULT_HOSTNAME}]: " HOSTNAME
    HOSTNAME=${HOSTNAME:-$DEFAULT_HOSTNAME}

    read -p "SSH port [${DEFAULT_PORT}]: " PORT
    PORT=${PORT:-$DEFAULT_PORT}

    read -p "Username [${DEFAULT_USER}]: " USERNAME
    USERNAME=${USERNAME:-$DEFAULT_USER}

    read -p "Identity file (path to SSH key) [${DEFAULT_IDENTITY_FILE}]: " IDENTITY_FILE
    IDENTITY_FILE=${IDENTITY_FILE:-$DEFAULT_IDENTITY_FILE}

    mkdir -p ~/.ssh
    echo "Adding configuration to ~/.ssh/config..."
    {
        echo "Host ${HOST_ALIAS}"
        echo "    HostName ${HOSTNAME}"
        echo "    Port ${PORT}"
        echo "    User ${USERNAME}"
        echo "    IdentityFile ${IDENTITY_FILE}"
    } >> ~/.ssh/config

    echo "SSH configuration complete. Use 'ssh ${HOST_ALIAS}' to connect to your server."
}

# Necessary utilities
echo "Installing required packages..."
sudo apt update
sudo apt install -y ssh waypipe

configure_ssh_client
