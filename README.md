# adduser.sh — HPC Cluster User Provisioning Script

Create a new Linux user on an HPC node and install an SSH public key for **key‑only authentication**.

The script accepts a **username** and an **SSH public key** (quoted) as parameters.

---

## Features

- Creates the user if they do not already exist  
- Locks the password to enforce **key‑only login**  
- Creates the `.ssh` directory with correct permissions  
- Installs the provided SSH public key  
- Ensures secure ownership and permissions  
- Idempotent: safe to run repeatedly  
- Works cleanly with automation tools (Ansible, pdsh, cluster bootstrap scripts)

---

## Usage

```bash
./adduser.sh <username> "<ssh-public-key>"
