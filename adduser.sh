#!/bin/bash
# Usage: ./adduser.sh username "ssh-ed25519 AAAA... user@host"

USERNAME="$1"
SSHKEY="$2"

if [ -z "$USERNAME" ] || [ -z "$SSHKEY" ]; then
    echo "Usage: $0 <username> \"<ssh-public-key>\""
    exit 1
fi

# 1. Create user if not exists
if id "$USERNAME" &>/dev/null; then
    echo "User $USERNAME already exists"
else
    sudo adduser "$USERNAME"
fi

# 2. Lock password (prevents password login)
sudo passwd -l "$USERNAME"

# 3. Create .ssh directory
sudo mkdir -p /home/"$USERNAME"/.ssh
sudo chmod 700 /home/"$USERNAME"/.ssh
sudo chown "$USERNAME":"$USERNAME" /home/"$USERNAME"/.ssh

# 4. Install SSH key
echo "$SSHKEY" | sudo tee /home/"$USERNAME"/.ssh/authorized_keys >/dev/null

# 5. Fix permissions
sudo chmod 600 /home/"$USERNAME"/.ssh/authorized_keys
sudo chown "$USERNAME":"$USERNAME" /home/"$USERNAME"/.ssh/authorized_keys

echo "User $USERNAME created and SSH key installed."
echo "Password login disabled."
