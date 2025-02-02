# Kali Setup Script (NoVNC)

## Overview

The "Kali Setup Script (NoVNC)" is an automated setup script designed to streamline the installation and configuration of a Kali Linux environment with NoVNC support. This script is perfect for users who want a quick and efficient way to get a Kali Linux instance up and running, complete with NoVNC for remote desktop access.

## Features

- Automated installation of necessary packages and dependencies
- Configuration of NoVNC for remote desktop access
- System updates and optimizations
- Easy-to-follow instructions

## Requirements

- A fresh installation of Kali Linux
- Internet connection
- Root privileges

## Installation

1. Clone the git repository to your Kali Linux machine.
    ```bash
    git clone https://github.com/Cyber-Courses/Kali-Setup-Script-NoVNC.git
    cd Kali-Setup-Script-NoVNC/
    ```
2. Ensure the script has executable permissions:
    ```bash
    chmod +x setup.sh
    ```
3. Run the script as root:
    ```bash
    sudo ./setup.sh
    ```

## Usage

After running the script, your Kali Linux environment will be set up with NoVNC configured for remote desktop access. To access your Kali Linux instance remotely, you can use SSH port forwarding.

### SSH Port Forwarding

To forward the NoVNC port through SSH, use the following command:
```bash
ssh -i kali_key.pem -L 8081:localhost:8081 kali@1.1.1.1 
```

Replace `kali@1.1.1.1` with the appropriate username and IP address of your Kali Linux machine.

To forward the VNCserver port through SSH, use the following command:
```bash
ssh -i kali_key.pem -L 5901:localhost:5901 kali@1.1.1.1 
```

Replace `kali@1.1.1.1` with the appropriate username and IP address of your Kali Linux machine. Then, use a VNC client to connect.

### Access NoVNC

After setting up the SSH tunnel, open your web browser and go to:
```
http://localhost:8081/vnc.html
```

## Setting Up a Kali Linux VM on Azure

This script is particularly useful for setting up a Kali Linux VM on Azure. Follow these steps to create a VM on Azure and use this script:

1. **Log in to Azure Portal:**
   - Go to the [Azure Portal](https://portal.azure.com) and log in with your credentials.

2. **Create a New VM:**
   - Navigate to "Virtual Machines" and click on "Add" to create a new VM.
   - Choose "[Kali Linux](https://portal.azure.com/#view/Microsoft_Azure_Marketplace/GalleryItemDetailsBladeNopdl/id/kali-linux.kali)" from the list of available images in the marketplace.
   - Choose the latest version.
   - Change the username to `kali`.
   - Configure the VM size, region, and other settings as needed.
   - Review + Create
   - Download SSH Key

3. **Access the VM:**
   - Once the VM is created, connect to it using SSH Key:
     ```bash
     chmod 600 kali_key.pem
     ssh -i kali_key.pem your_username@your_vm_public_ip
     ```

4. **Run the Setup Script:**
   - Download the `setup.sh` script to your Kali Linux VM.
    ```bash
    git clone https://github.com/Cyber-Courses/Kali-Setup-Script-NoVNC.git
    cd Kali-Setup-Script-NoVNC/
    ```
   - Ensure the script has executable permissions:
     ```bash
     chmod +x setup.sh
     ```
   - Run the script as root:
     ```bash
     sudo ./setup.sh
     ```

6. **Set Up SSH Port Forwarding:**
   - On your **local** machine, use SSH port forwarding to access NoVNC:
     ```bash
     ssh -N -i kali_key.pem your_username@your_vm_public_ip -L 8081:localhost:8081
     ```

7. **Access NoVNC:**
   - On your **local** machine, open your web browser and go to:
     ```
     http://localhost:8081/vnc.html
     ```
     Use "password" to connect.
     
## Support

For issues and troubleshooting, please refer to the official Kali Linux documentation and the NoVNC project's support resources.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes.


---

© 2024 Cyber Courses


