#===========================================================
# Spanish International File
# by Darwin Toledo - www.darwintoledo.com
#===========================================================

!define RODRILANG ${LANG_SPANISHINTERNATIONAL}


        LangString License_Subtitle         ${RODRILANG} "Por favor, revise los t�rminos de la licencia antes de continuar"
        LangString License_Text_Top         ${RODRILANG} "El software dentro de este programa se dividen en las siguientes licencias."
        LangString License_Text_Bottom      ${RODRILANG} "Debe aceptar los t�rminos de este acuerdo de licencia para ejecutar ${NAME}. Si est� de acuerdo, haga clic en Acepto para continuar."
        LangString SelectDist_Title         ${RODRILANG} "Seleccion de unidad y opciones de Distro."
        LangString SelectDist_Subtitle      ${RODRILANG} "Elija una unidad USB, y una Distribuci�n, archivo ISO/ZIP.$\r$\nSe pueden a�adir distribuciones adicionales cada vez que se ejecuta la herramienta."
        LangString DrivePage_Text           ${RODRILANG} "Paso 1: Seleccione la letra de su dispositivo USB."
        LangString Distro_Text              ${RODRILANG} "Paso 2: Seleccione una distribuci�n de la lista."
        LangString IsoPage_Text             ${RODRILANG} "Paso 3: Seleccionar $FileFormat (el nombre debe ser similar al anterior)."
        LangString IsoPage_Title            ${RODRILANG} "Seleccione su $FileFormat"
        LangString Casper_Text              ${RODRILANG} "Paso 4: Establecer tama�o de archivo persistente para cambios almacenamiento (opcional)."
        LangString IsoFile                  ${RODRILANG} "$FileFormat file|$ISOFileName" ;$ISOFileName variable previously *.iso
        LangString Extract                  ${RODRILANG} "Extracting the $FileFormat: The progress bar will not move until finished. Please be patient..."
        LangString CreateSysConfig          ${RODRILANG} "Creating configuration files for $DestDisk"
        LangString ExecuteSyslinux          ${RODRILANG} "Executing syslinux on $BootDir"
        LangString SkipSyslinux             ${RODRILANG} "Good Syslinux Exists..."
        LangString WarningSyslinux          ${RODRILANG} "An error ($R8) occurred while executing syslinux.$\r$\nYour USB drive won't be bootable..."
        LangString WarningSyslinuxOLD       ${RODRILANG} "This YUMI revision uses a newer Syslinux version that is not compatible with earlier revisions.$\r$\nPlease ensure your USB drive doesn't contain earlier revision installs."
        LangString Install_Title            ${RODRILANG} "$InUnStall $ISOFileName"
        LangString Install_SubTitle         ${RODRILANG} "Please wait while we $InUnStall $DistroName on $JustDrive"
        LangString Install_Finish_Sucess    ${RODRILANG} "${NAME} sucessfully $InUnStalled $DistroName on $JustDrive"
        LangString Finish_Install           ${RODRILANG} "$InUnStallation is Complete."
        LangString Finish_Title             ${RODRILANG} "${NAME} has completed the $InUnStallation."
        LangString Finish_Text              ${RODRILANG} "Your Selections have been $InUnStalled on your USB drive.$\r$\n$\r$\nFeel Free to run this tool again to $InUnStall more Distros.$\r$\n$\r$\nYUMI will keep track of selections you have already $InUnStalled."
        LangString Finish_Link              ${RODRILANG} "Visit the ${NAME} Tutorial Page"
        LangString Create_Button            ${RODRILANG} "Crear"

        LangString VIEW_ONREM_DISTROS       ${RODRILANG} "View or Remove Installed Distros?"
        LangString DOWNLOAD_ISOOP           ${RODRILANG} "Download the ISO (Optional)."
        LangString SHOW_ALL_ISOS            ${RODRILANG} "Show All ISOs?"
        LangString RL_BROWSE                ${RODRILANG} "Browse"
        LangString RL_VISIST_OFHOME         ${RODRILANG} "Visit the $OfficialName HomePage"
        LangString BROW_AND_SELFORM         ${RODRILANG} "Browse to and select the $FileFormat"
        LangString RL1_STEP1                ${RODRILANG} "Step 1: ${NAME} Summoned $DestDisk as your USB Device"
        LangString SHOW_ALL_DRIVES          ${RODRILANG} "Show All Drives?"
        LangString CLICK_TO_ONLINEHELP      ${RODRILANG} "Click HERE to visit the ${NAME} page for additional Help!"

        LangString RL2_STEP1                ${RODRILANG} "Paso 1: Seleccione la letra de la unidad USB."
        LangString SHOW_ALL_DRIVES2         ${RODRILANG} "Show All Drives?"
        LangString RL2_FORMAT               ${RODRILANG} "Format $DestDisk Drive (Erase Content)?"
        LangString SHOW_ALL_ISOS2           ${RODRILANG} "Show All ISOs?"
        LangString DOWNLOAD_ISOOP2          ${RODRILANG} "Download the ISO (Optional)."
        LangString RL_VISIST_OFHOME2        ${RODRILANG} "Visit the $OfficialName HomePage"
        LangString BROW_AND_SELFORM2        ${RODRILANG} "Browse to and select the $FileFormat"
        LangString RL_BROWSE2               ${RODRILANG} "Browse"
        LangString CLICK_TO_ONLINEHELP2     ${RODRILANG} "Click HERE to visit the ${NAME} page for additional Help!"
        LangString RL2_SHOWING              ${RODRILANG} "Showing All Drives"
        LangString RL2_SHOWALL              ${RODRILANG} "Show All Drives?"
        LangString RL_ODL                   ${RODRILANG} "Opened Download Link"
        LangString RL_DL1                   ${RODRILANG} "Download Link"

        LangString MENU_LABEL_LUNIX_DIST    ${RODRILANG} "Distribuciones Linux"
        LangString MENU_LABEL_SYS_TOOLS     ${RODRILANG} "Herramientas de Sistema"
        LangString MENU_LABEL_ANTIVIR       ${RODRILANG} "Herramientas Antivirus"
        LangString MENU_LABEL_NETBOOK       ${RODRILANG} "Distribuciones para Netbook"
        LangString MENU_LABEL_OTHER_OS      ${RODRILANG} "Otros Sistemas Operativos y Herramientas"
        LangString MENU_LABEL_UNLISTED      ${RODRILANG} "Unlisted ISO (via SYSLINUX)"
        LangString MENU_LABEL_GRUB          ${RODRILANG} "GRUB Bootable ISOs"
        LangString MENU_LABEL_GRUB_LARGE    ${RODRILANG} "GRUB Bootable ISOs and Windows XP/7/8"

        ;LangString LABEL           ${RODRILANG} ""

!undef RODRILANG