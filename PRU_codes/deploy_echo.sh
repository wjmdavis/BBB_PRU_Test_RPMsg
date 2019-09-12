#! /bin/bash
#  Modified by WJMD Sep 2019
# 
#  1) Start with a call to expand aliases to make them work
#  2) Stop the PRUs at the beginning, restart them at the end
#  3) modified the path for firmware, based on previous results
#  4) Copy the filename to the remoteproc firmware location  
#
# Original Copyright (C) 2016 Pierrick Rauby <PierrickRauby - pierrick.rauby@gmail.com>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted 
#############################################################################

# without this, aliases don't work! #
shopt -s expand_aliases
printf "\n --------------------------------------------"
printf "\n deploy_echo.sh , modified 10Sep2019 by WJMD\n"
echo "**** Starting Script ****"


echo "Stopping PRUs..."
#Stop the PRUs before compiling and copying #
echo 'stop' > /sys/class/remoteproc/remoteproc1/state
echo 'stop' > /sys/class/remoteproc/remoteproc2/state

printf "\n -------------     PRU0     ------------- \n"
alias cd_PRU_Halt="cd /root/Test_RPMsg/PRU_codes/PRU_Halt"
cd_PRU_Halt
echo "Building PRU_Halt..."
make clean
make
echo "Copying files into /lib/firmware..."
cp gen/*.out /lib/firmware
echo "done"
alias cd_gen="cd gen"
cd_gen
echo "teeing name into /sys/class/remoteproc/remoteproc2/firmware"
ls *.out|tee /sys/class/remoteproc/remoteproc1/firmware
alias cd_up="cd .."
cd_up

printf "\n -------------     PRU1     ------------- \n"
alias cd_PRU_RPMsg_Echo_Interrupt1="cd ../PRU_RPMsg_Echo_Interrupt1"
cd_PRU_RPMsg_Echo_Interrupt1
echo "building PRU_RPMsg_Echo_Interrupt1"
make clean
make
echo "copying files into /lib/firmware"
cp gen/*.out /lib/firmware
echo "done"
echo "teeing name into /sys/class/remoteproc/remoteproc2/firmware"
cd_gen
ls *.out|tee /sys/class/remoteproc/remoteproc2/firmware
echo "done"

echo "Rebooting PRUs"
echo 'start' > /sys/class/remoteproc/remoteproc1/state
echo 'start' > /sys/class/remoteproc/remoteproc2/state

echo "done"
