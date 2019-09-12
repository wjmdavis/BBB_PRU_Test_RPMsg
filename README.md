# BBB_PRU_Test_RPMsg
Example of BBB PRUs talking to ARM with RPMsg. Based on Pierrick Rauby's example

Changes from Pierrick's example

In deploy_echo.sh:
  1) Expand aliases:      shopt -s expand_aliases
  2) Stop the PRUs at the beginning, restart them at the end
  3) modified the path for firmware, based on previous results (just lib/firmware)
  4) Copy the filename to the remoteproc firmware location
