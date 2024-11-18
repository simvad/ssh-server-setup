# ssh-server-setup

This automates the setup of an SSH server on a Debian based distro. It is based on the conversion of an old ASUS SonicMaster laptop and might carry traces thereof

## Features
- **Dynamic Network Configuration**:
  - Interactive static IP configuration for the server.
- **SSH Access**:
  - Automatically set up the server for SSH access.
- **Wake-on-LAN (WOL)**:
  - Persistent WOL service to remotely power up the server.
- **System Tweaks**:
  - Prevents hibernation and lid-close actions for uninterrupted service.
- **File Transfers**:
  - Simplified SFTP setup for transferring files between client and server.

## Setup Instructions

### 1. Setting Up the Server

Clone this project onto the server and execute the `setup_server.sh` script.

The script will prompt you for the following values (with defaults provided):
- Network interface name (e.g. enp2s0f2)
- Static IP address (e.g. 192.168.1.100)
- Netmask (e.g. 255.255.255.0)
- Gateway (e.g. 192.168.1.1)

### 2. Setting up the client
Clone this project onto the client and execute `setup_client.sh`

- Host alias: Shortcut name for the server (e.g. myserver).
- Server IP: (e.g. 192.168.1.100)
- SSH port (e.g. 22 or custom port.)
- Username: (e.g. simon)
- Identity file path: Path to your SSH private key (e.g. ~/.ssh/id_rsa).

You can thereafter ssh into the server with command `ssh <alias>`

### 3. Wake-on-LAN (WOL)
If possible, WOL has been configured and enabled with the server setup script. To use it, you need the servers MAC addreess. This can be obtained by running `ip link show <interface>`

Hereafter, the server can be woken with `./wake_on_lan.sh <MAC_ADDRESS>`

### 4. File Transfers with SFTP

After setup, files can be transfered with SFTP by starting an SFTP session `sftp <alias>`

### 5. Forwrd GUI applications with Waypipe
A server with running wayand can render and forward GUI applications through SSH with Waypipe. This can be done with command `waypipe ssh <alias> <application>`