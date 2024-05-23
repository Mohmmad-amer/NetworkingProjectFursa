#!/bin/bash

# Function to generate a new SSH key pair
generate_ssh_key() {
    ssh-keygen -t rsa -b 4096 -N "" -f "/home/ubuntu/keypairtorotate"
}

if [ "$#" -eq 0 ]; then
    echo "Please provide bastion IP address"
    exit 5
fi

# Check if 1 addres are given
if [ "$#" -eq 1 ]; then
    generate_ssh_key
    # copy new key to ssh/authorized_key to private and delete the old one
    cat keypairtorotate.pub | ssh -i keypair ubuntu@$1 'cat > .ssh/authorized_keys'
    #save the new key at keypair file
    chmod +w keypair
    cat keypairtorotate > keypair
    chmod 400 keypair
    rm keypairtorotate keypairtorotate.pub

fi
