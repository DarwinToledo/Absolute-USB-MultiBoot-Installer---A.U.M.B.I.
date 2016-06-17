#===========================================================
# DEFINES
#===========================================================

           !include BuildCount.nsh

           !define NAME                "RUBIB"
           !define FILENAME            "RUBIB"
           !define DESKTOP_USER        "Ro"
           !define VERSION             "1.5.0.${BUILD_NUMBER}"

           #INST RESOURCES
           !define MUI_ICON            "${NSISDIR}\Contrib\Graphics\Icons\box-install.ico"
           !define RUBIB_WEBSITE       "http://rubib.darwintoledo.com/"
           !define RUBIB_LINK2         "http://rubib.darwintoledo.com/2016/06/rubib-rodri-universal-multiboot.html"


           ;!define BUILD_BETA
           !define BUILD_STABLE
