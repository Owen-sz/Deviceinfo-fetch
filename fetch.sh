#!/bin/bash

BOLD='\033[1m'
RESET='\033[0m'

if [ -f ~/bin/deviceinfo ]; then

    # Computer model (host)
    hostname=$(hostname) 
    echo -e "${BOLD}Hostname:${RESET}" "$hostname"

    # OS
    source /etc/os-release
    echo -e "${BOLD}OS:${RESET}" "$PRETTY_NAME $VERSION_CODENAME"

    # Kernel
    kernel=$(uname -r)
    echo -e "${BOLD}kernel:${RESET}" "$kernel"
    
    # CPU
    cpu_info=$(grep -m 1 'model name' /proc/cpuinfo | awk -F: '{gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2}')
    echo -e "${BOLD}CPU:${RESET} $cpu_info"

    # GPU
    gpu=$(lspci | grep -i vga | awk '{for (i=5; i<=NF; i++) printf $i " "; print ""}')
    echo -e "${BOLD}GPU:${RESET}" "$gpu"

    # RAM
    memtotal=$(cat /proc/meminfo | grep -i memtotal | awk '{print $2/1024/1024 " GB"}')
    echo -e "${BOLD}Total Memory:${RESET}" "$memtotal"

    memavailable=$(cat /proc/meminfo | grep -i memavailable | awk '{print $2/1024/1024 " GB"}')
    echo -e "   ${BOLD}Available Memory:${RESET}" "$memavailable"

    swaptotal=$(cat /proc/meminfo | grep -i swaptotal | awk '{print $2/1024/1024 " GB"}')
    echo -e "   ${BOLD}Total Swap:${RESET}" "$swaptotal"

    swapfree=$(cat /proc/meminfo | grep -i swapfree | awk '{print $2/1024/1024 " GB"}')
    echo -e "   ${BOLD}Available Swap:${RESET}" "$swapfree"

    # disk
    echo -e "${BOLD}Disk Info:${RESET}"
    root_fs_type=$(findmnt -n -o FSTYPE /)
    disk=$(df / | awk 'NR==2 {print $1}' | sed 's/[0-9]*$//')
    total_storage=$(lsblk -dn -o SIZE "$disk")
    available_storage=$(df -h / | awk 'NR==2 {gsub("G", "GB", $4); print $4}')
    type=$(lsblk -o TRAN | awk 'NR>1 {print $1}' | sort -u | paste -sd " ")

    echo -e "   ${BOLD}File System:${RESET}" "$root_fs_type"
    echo -e "   ${BOLD}Total Usable Storage:${RESET}" "$total_storage"
    echo -e "   ${BOLD}Available Storage:${RESET}" "$available_storage"
    echo -e "   ${BOLD}Type:${RESET}" "$type"
fi

# move script so it can be universally ran

if [ ! -f ~/bin/deviceinfo ]; then
    mkdir -p ~/bin
    mv fetch.sh ~/bin/deviceinfo
    chmod +x ~/bin/deviceinfo
    echo 'export PATH=$PATH:~/bin' >> ~/.bashrc
    source ~/.bashrc
fi
