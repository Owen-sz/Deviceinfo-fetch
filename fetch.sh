#!/bin/bash
# This script uses both Bash and awk

if [ -f ~/bin/deviceinfo ]; then
    # OS
    source /etc/os-release
    echo OS Info: "$ID $VERSION $VERSION_CODENAME"

#    CPU
    grep -m 1 'model name' /proc/cpuinfo | awk -F: '{gsub(/^[ \t]+|[ \t]+$/, "", $2); print "cpu: "$2}'

    # GPU
    gpu=$(lspci | grep -i vga | awk '{for (i=5; i<=NF; i++) printf $i " "; print ""}')
    echo "GPU: $gpu"

    # RAM
    memtotal=$(cat /proc/meminfo | grep -i memtotal | awk '{print $2/1024/1024 " GB"}')
    echo "Total Memory: $memtotal"

    memavailable=$(cat /proc/meminfo | grep -i memavailable | awk '{print $2/1024/1024 " GB"}')
    echo "Available Memory: $memavailable"

    swaptotal=$(cat /proc/meminfo | grep -i swaptotal | awk '{print $2/1024/1024 " GB"}')
    echo "Total Swap: $swaptotal"

    swapfree=$(cat /proc/meminfo | grep -i swapfree | awk '{print $2/1024/1024 " GB"}')
    echo "Swap Available: $swapfree"

    # disk

    # Disk
    # OS (name, releasever)
    # Computer model (host)
    # Network interface used
    # Desktop Environment
    # Kernel
fi

# move script so it can be universally ran

if [ ! -f ~/bin/deviceinfo ]; then
    mkdir -p ~/bin
    mv fetch.sh ~/bin/deviceinfo
    chmod +x ~/bin/deviceinfo
    echo 'export PATH=$PATH:~/bin' >> ~/.bashrc
    source ~/.bashrc
fi