#!/bin/bash

# 1. Install snort package
if ! command -v snort &> /dev/null
then
    echo "Snort is not installed. Installing..."
    sudo apt install snort -y
else
    echo "Snort is already installed."
fi

# 2. Change HOME_NET in snort.conf
# + Install ifconfig package
if ! command -v ifconfig &> /dev/null
then
    echo "ifconfig is not installed. Installing..."
    sudo apt install ifconfig -y
else
    echo "ifconfig is already installed."
fi
# + Detect IP address
ip_address=$(ifconfig enp0s8 | grep 'inet addr:' | cut -d: -f2 | awk '{print $1}')

# + Replace HOME_NET in snort.conf with detected IP address
sudo sed -i "s/HOME_NET.*/HOME_NET $ip\/24/" /etc/snort/snort.conf
echo "Changing HOME_NET done."

# 3. Add rules to local.rules
# + Check if the file exists
if [ ! -f local.rules ]; then
    echo "The file local.rules does not exist."
    exit 1
fi

# + Append the rules to the end of the local.rules file
sudo cat local.rules >> /etc/snort/rules/local.rules
echo "Rules successfully appended to /etc/snort/rules/local.rules"

# 4. Run snort and observe alert directly on console
sudo snort -A console -c /etc/snort/snort.conf -i esp0s8