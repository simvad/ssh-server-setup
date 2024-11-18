#!/bin/bash

configure_static_ip() {
    echo "Configuring static IP for the server..."

    # Default values
    DEFAULT_INTERFACE="enp2s0f2"
    DEFAULT_IP="192.168.1.100"
    DEFAULT_NETMASK="255.255.255.0"
    DEFAULT_GATEWAY="192.168.1.1"

    read -p "Network interface [${DEFAULT_INTERFACE}]: " INTERFACE
    INTERFACE=${INTERFACE:-$DEFAULT_INTERFACE}

    read -p "Static IP address [${DEFAULT_IP}]: " IP_ADDRESS
    IP_ADDRESS=${IP_ADDRESS:-$DEFAULT_IP}

    read -p "Netmask [${DEFAULT_NETMASK}]: " NETMASK
    NETMASK=${NETMASK:-$DEFAULT_NETMASK}

    read -p "Gateway [${DEFAULT_GATEWAY}]: " GATEWAY
    GATEWAY=${GATEWAY:-$DEFAULT_GATEWAY}

    # Backup existing interfaces file
    echo "Backing up current interfaces file..."
    sudo cp /etc/network/interfaces /etc/network/interfaces.bak

    # Write new configuration
    echo "Updating /etc/network/interfaces..."
    sudo bash -c "cat > /etc/network/interfaces" <<EOL


source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto $INTERFACE
iface $INTERFACE inet static
    address $IP_ADDRESS
    netmask $NETMASK
    gateway $GATEWAY
EOL

    echo "Restarting networking to apply changes..."
    sudo systemctl restart networking

    echo "Static IP configuration complete."
    echo "Interface: $INTERFACE"
    echo "IP Address: $IP_ADDRESS"
    echo "Netmask: $NETMASK"
    echo "Gateway: $GATEWAY"
}

# Required packages
echo "Installing required packages..."
sudo apt update
sudo apt install -y openssh-server ufw ethtool timeshift waypipe

# Enable the firewall
echo "Enabling and configuring the firewall..."
sudo ufw enable
sudo ufw allow ssh

# Configure static IP
configure_static_ip

# Configure WOL
echo "Configuring Wake-on-LAN..."
sudo cp ../configs/wol.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable wol.service
sudo systemctl start wol.service

# Disable hibernation 
echo "Disabling hibernation on lid close..."
sudo cp ../configs/systemd_logind.conf /etc/systemd/logind.conf
sudo systemctl restart systemd-logind

echo "Server setup complete. Please verify the configuration and test the system."
