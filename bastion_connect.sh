#!/bin/bash

#check path to key
if [ -z "$KEY_PATH" ]; then
    echo "KEY_PATH env var is expected"
    exit 5
fi

# check if ip add are given
if [ "$#" -eq 0 ]; then
    echo "Please provide bastion IP address"
    exit 5
fi


# Check if 1 addres are given
if [ "$#" -eq 1 ]; then
    # "JUMP TO PUBLIC SERVER"

 # Assign command-line arguments to variables
    jump_host="$1"
    user="ubuntu"

 # SSH command with jump host and specified private key
    ssh -i $KEY_PATH $user@$jump_host

fi

# Check if correct number of arguments are provided
if [ "$#" -eq 2 ]; then
    # "JUMP TO privte SERVER"

 # Assign command-line arguments to variables
    jump_host="$1"
    privte_host="$2"
    user="ubuntu"

    ssh -i $KEY_PATH -t $user@$jump_host "ssh -i keypair $user@$privte_host -t"

fi

# Check if correct number of arguments are provided
if [ "$#" -eq 3 ]; then
    # "JUMP TO privte SERVER and send command"

 # Assign command-line arguments to variables
    jump_host="$1"
    privte_host="$2"
    user="ubuntu"
    command="$3"

    ssh -i $KEY_PATH -t $user@$jump_host "ssh -i keypair $user@$privte_host -t" "$command"

fi
