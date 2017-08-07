#!/bin/bash
#
# NOTE: I am not the original author of this script.
# I have stumbled upon this script in my career and have found it useful, but do not know the original source.
# If you know the original author or origin of this script, please let me know in an issue and I will be glad to give credit where it is due.
#
#--------------------------------------------------------------------------------------------------------------
# This script is for logging other bash scripts.
# To enable logging of a bash script, you must place the flowing 3 lines in the beginning of THAT script:
#
# Replace /path/to/this/script_logger.sh with the full path to this script.
#
################################-PLACE THESE LINES BELOW THE BASH DELARATION-##################################
# source /path/to/this/script_logger.sh
# Enable_Logging
# Enable_Trap
###############################################################################################################
#
# MAKE SURE THERE ARE NO "#" SYMBOLS IN FRONT OF THE ABOVE LINES WHEN ENTEREND INTO ANOTHER SCRIPT.
# The "source" line assumes this script is saved in the custom Standard script directory.
#--------------------------------------------------------------------------------------------------------------





# DECLARING VARIABLES:
#
FileTime=`date +\%H\%M\%S`
FileDate=`date +\%Y\%m\%d`
TimeStamp=$(date +"%r")
DateStamp=$(date +"%Y-%m-%d")
SNWE=$(basename "$0")                          # SCRIPT NAME WITH EXTENSION.
ScriptName=$(basename "$0" | cut -d. -f1)       # SCRIPT NAME WITH EXTENSION REMOVED.
#LogFile="/var/log/$ScriptName.log"
LogFile="/var/log/custom.log"





# FUNCTION TO LOG THE OUTPUT OF A COMMAND:
#
function Log_out {
while read LINE; do
        local IN="$LINE"

        if [ -n "$IN" ]; then
                echo "${DateStamp}  ${TimeStamp}  $HOSTNAME  ($USER)  Source:[$SNWE] INFO: $IN" >> $LogFile
#        else
#                echo ${DateStamp} ${TimeStamp} info: $IN >> $LogFile
        fi

        unset IN
done
}




# FUNCTION TO LOG THE OUTPUT OF A COMMAND:
#
function Log_err {
while read LINE; do
        local IN="$LINE"

        if [ -n "$IN" ]; then
                echo "${DateStamp}  ${TimeStamp}  $HOSTNAME  ($USER)  Source:[$SNWE] ERROR: $IN" >> $LogFile
#        else
#                echo ${DateStamp} ${TimeStamp} error: $IN >> $LogFile
        fi

        unset IN
done
}




# FUNCTION TO ENABLE LOGGING OF ALL OUTPUT:
#
function Enable_Logging {
exec 1> >(Log_out)
exec 2> >(Log_err)
}




# FUNCTION TO CHECK THE EXITCODE AND LOG SUCCESS OR FAIL:
#
function Script_Exit {
if [ $? -eq 0 ]; then
        echo "${DateStamp}  ${TimeStamp}  $HOSTNAME  ($USER)  Source:[$SNWE] INFO: The Script Completed Successfully!" >> $LogFile
        echo ----------------------------------------------------------------------------------------------------------- >> $LogFile
        echo 0 > "/opt/custom/scripts/.$ScriptName.exit"
        exit 0
else
        echo "${DateStamp}  ${TimeStamp}  $HOSTNAME  ($USER)  Source:[$SNWE] ERROR: The Script Failed!" >> $LogFile
        echo ----------------------------------------------------------------------------------------------------------- >> $LogFile
        echo 1 > "/opt/custom/scripts/.$ScriptName.exit"
        exit 1
fi
}




function Enable_Trap {
# RUN EXITCODE CHECK REGARDLESS OF HOW THE SCRIPT EXITS:
#
trap Script_Exit EXIT INT TERM
}
