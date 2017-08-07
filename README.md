#Bash Script Logger

## NOTE:
### I am not the original author of this script.
### I have stumbled upon this script in my career and have found it useful, but do not know the original source.
### If you know the original author or origin of this script, please let me know in an issue and I will be glad to give credit where it is due.

#--------------------------------------------------------------------------------------------------------------
 This script is for logging other bash scripts.
 To enable logging of a bash script, you must place the flowing 3 lines in the beginning of THAT script:

 Replace /path/to/this/script_logger.sh with the full path to this script.

***-PLACE THESE LINES BELOW THE BASH DELARATION-***
 source /path/to/this/script_logger.sh
 Enable_Logging
 Enable_Trap


 MAKE SURE THERE ARE NO "#" SYMBOLS IN FRONT OF THE ABOVE LINES WHEN ENTEREND INTO ANOTHER SCRIPT.
 The "source" line assumes this script is saved in the custom Standard script directory.
#--------------------------------------------------------------------------------------------------------------
