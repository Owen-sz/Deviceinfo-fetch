#!/bin/bash

# OS
source /etc/os-release
echo $ID

# CPU
grep -m 1 'model name' /proc/cpuinfo 

# GPU
lspci | grep -i vga 

# 





# CPU -
# GPU (i, d) - 
# RAM
# Disk
# OS (name, releasever) - 
# Computer model (host)
# Swap
# Network interface used
# Desktop Environment
# Kernel