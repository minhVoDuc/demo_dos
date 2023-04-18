#!/bin/bash

# 1. Check if the rule file exists
if [ ! -f "apache-dos.conf"]; then
    echo "Error: UFW rule file does not exist."
    exit 1
fi

# 2. Copy file to /etc/ufw/applications.d/
sudo cp apache-dos.conf /etc/ufw/applications.d/

# 3. Update rule
sudo ufw app update apache-dos

# 4. Apply new rule
sudo ufw allow Apache\ DOS