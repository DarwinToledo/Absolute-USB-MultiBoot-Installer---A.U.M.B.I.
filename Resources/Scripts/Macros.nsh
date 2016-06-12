#===========================================================
# RUBIB (Rodri Universal multiBoot Installer B)
# Macros by Darwin Toledo
#===========================================================


       !macro FILEONAME FILE
              File /oname=$PLUGINSDIR\${FILE} "${FILE}"
       !macroend
       !define FILEONAME "!insertmacro FILEONAME "

       !macro FILEONAME2 FILE
              File /oname=$PLUGINSDIR\${FILE} "menu\${FILE}"
       !macroend
       !define FILEONAME2 "!insertmacro FILEONAME2 "
