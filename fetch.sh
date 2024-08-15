#!/bin/bash

# OS
source /etc/os-release
echo $ID

# CPU
grep -m 1 'model name' /proc/cpuinfo 

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


# CPU - =
# GPU (i, d) - =
# RAM =
# Disk = 
# OS (name, releasever) - =
# Computer model (host)
# Swap = 
# Network interface used
# Desktop Environment
# Kernel