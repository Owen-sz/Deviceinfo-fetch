#!/bin/bash

if [ -f ~/bin/deviceinfo ]; then

    # Computer model (host)
    hostname=$(hostname) 
    echo Hostname: $hostname

    # OS
    source /etc/os-release
    echo OS: "$ID $VERSION $VERSION_CODENAME"

    # Kernel
    kernel=$(uname -r)
    echo Kernel: "$kernel"
    
    # CPU
    grep -m 1 'model name' /proc/cpuinfo | awk -F: '{gsub(/^[ \t]+|[ \t]+$/, "", $2); print "CPU: "$2}'

    # GPU
    gpu=$(lspci | grep -i vga | awk '{for (i=5; i<=NF; i++) printf $i " "; print ""}')
    echo "GPU: $gpu"

    # RAM
    memtotal=$(cat /proc/meminfo | grep -i memtotal | awk '{print $2/1024/1024 " GB"}')
    echo "Total Memory: $memtotal"

    memavailable=$(cat /proc/meminfo | grep -i memavailable | awk '{print $2/1024/1024 " GB"}')
    echo "  Available Memory: $memavailable"

    swaptotal=$(cat /proc/meminfo | grep -i swaptotal | awk '{print $2/1024/1024 " GB"}')
    echo "  Total Swap: $swaptotal"

    swapfree=$(cat /proc/meminfo | grep -i swapfree | awk '{print $2/1024/1024 " GB"}')
    echo "  Swap Available: $swapfree"

    # disk
    echo "Disk info:"
    root_fs_type=$(findmnt -n -o FSTYPE /)
    disk=$(df / | awk 'NR==2 {print $1}' | sed 's/[0-9]*$//')
    total_storage=$(lsblk -dn -o SIZE $disk)
    available_space=$(df -h / | awk 'NR==2 {gsub("G", "GB", $4); print $4}')
    type=$(lsblk -o TRAN | awk 'NR>1 {print $1}' | sort -u | paste -sd " ")

    echo "  Filesystem: $root_fs_type"
    echo "  Total usable storage: $total_storage"
    echo "  Available space: $available_space"
    echo "  Type: $type"
fi

# move script so it can be universally ran

if [ ! -f ~/bin/deviceinfo ]; then
    mkdir -p ~/bin
    mv fetch.sh ~/bin/deviceinfo
    chmod +x ~/bin/deviceinfo
    echo 'export PATH=$PATH:~/bin' >> ~/.bashrc
    source ~/.bashrc
fi